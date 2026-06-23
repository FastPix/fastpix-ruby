require 'spec_helper'
require 'fastpixapi'
require_relative '../config/fastpix_config'

SUCCESS_CONTEXT = 'when the request is successful'
UNAUTHORIZED_CONTEXT = 'when the request fails with unauthorized error'
VALIDATION_ERROR_DESC = 'raises validation error'
PAYLOAD_VALIDATION_FAILED = 'payload validation failed'
TEST_ID = 'test-id'
UPDATED_TITLE = 'Updated Title'

RSpec.describe FastpixApiSDK::ManageVideos do
  let(:sdk_config) do
    FastpixApiSDK::SDKConfiguration.new(
      Faraday.new, # client
      FastpixApiSDK::SDKHooks::Hooks.new, # hooks
      nil, # retry_config
      30_000, # timeout_ms (30 seconds)
      FastpixApiSDK::Models::Components::Security.new(
        username: FastPix::Config.username,
        password: FastPix::Config.password
      ), # security
      nil, # security_source
      FastPix::Config.server_url, # server_url
      0 # server_idx
    )
  end
  let(:client) { instance_double(Faraday::Connection) }
  let(:manage_videos) { described_class.new(sdk_config) }
  let(:test_media_id) do
    list_response = manage_videos.list_media
    expect(list_response.status_code).to eq(200)
    media_list = list_response.object.data
    skip 'No videos found in the account' if media_list.empty?
    media_list.first.id
  end

  before do
    allow(sdk_config).to receive(:get_server_details).and_return([FastPix::Config.server_url, {}])
    allow(sdk_config).to receive(:user_agent).and_return('test-agent')
    allow(sdk_config).to receive(:timeout).and_return(30)
    allow(sdk_config).to receive(:security_source).and_return(
      -> { FastpixApiSDK::Models::Components::Security.new(
        username: FastPix::Config.username,
        password: FastPix::Config.password
      )}
    )
  end

  describe '#list_media' do
    context SUCCESS_CONTEXT do
      it 'retrieves list of videos' do
        response = manage_videos.list_media
        puts "RESPONSE (list_media success): #{JSON.pretty_generate(response.object.data.take(2).map(&:to_dict))}"
        puts "RAW RESPONSE (list_media): #{response.raw_response.body}"
        expect(response.status_code).to eq(200)
        expect(response.object.data).to be_an(Array)
        puts "Available methods for list_media response: #{response.object.data.first.methods - Object.methods}"
        puts "Media ID: #{response.object.data.first.id}"
      end
    end

    context UNAUTHORIZED_CONTEXT do
      it 'skips unauthorized error test (cannot simulate without invalid credentials)' do
        skip 'Cannot simulate unauthorized error without invalid credentials.'
      end
    end
  end

  describe 'Media Operations' do
    let(:media_id) { test_media_id }

    describe '#get_media' do
      context SUCCESS_CONTEXT do
        it 'retrieves video status' do
          response = manage_videos.get_media(media_id: media_id)
          puts "RESPONSE (get_media success): #{JSON.pretty_generate(response.object.to_dict)}"
          puts "RAW RESPONSE (get_media): #{response.raw_response.body}"
          expect(response.status_code).to eq(200)
          expect(response.object.data.id).to eq(media_id)
          puts "Status value: #{response.object.data.status.inspect}"
          expect(response.object.data.status).not_to be_nil
          expect(response.object.data.status).not_to eq('')
          puts "Available methods for get_media response: #{response.object.methods - Object.methods}"
          puts "Media Details: #{JSON.pretty_generate(response.object.data.to_dict)}"
        end
      end

      context 'when the request fails with not found error' do
        it VALIDATION_ERROR_DESC do
          error = nil
          begin
            manage_videos.get_media(media_id: 'non-existent-id')
          rescue UncaughtThrowError => e
            error = e.tag
          end
          puts "RESPONSE (get_media not found): #{error ? JSON.pretty_generate(error.to_dict) : 'nil'}"
          expect(error).to be_a(FastpixApiSDK::Models::Errors::ValidationErrorResponse)
          expect(error.error.code).to eq(422)
          expect(error.error.message).to eq(PAYLOAD_VALIDATION_FAILED)
          puts "Available methods for error response: #{error.methods - Object.methods}"
        end
      end

      context UNAUTHORIZED_CONTEXT do
        it VALIDATION_ERROR_DESC do
          error = nil
          begin
            manage_videos.get_media(media_id: TEST_ID)
          rescue UncaughtThrowError => e
            error = e.tag
          end
          puts "RESPONSE (get_media unauthorized): #{error ? JSON.pretty_generate(error.to_dict) : 'nil'}"
          expect(error).to be_a(FastpixApiSDK::Models::Errors::ValidationErrorResponse)
          expect(error.error.code).to eq(422)
          expect(error.error.message).to eq(PAYLOAD_VALIDATION_FAILED)
          puts "Available methods for error response: #{error.methods - Object.methods}"
        end
      end
    end

    describe '#updated_media' do
      context SUCCESS_CONTEXT do
        it 'updates media metadata' do
          metadata = FastpixApiSDK::Models::Operations::UpdatedMediaMetadata.new
          metadata.instance_variable_set(:@title, UPDATED_TITLE)
          metadata.instance_variable_set(:@description, 'Updated Description')
          request_body = FastpixApiSDK::Models::Operations::UpdatedMediaRequestBody.new(
            metadata: metadata
          )

          response = manage_videos.updated_media(media_id: media_id, request_body: request_body)
          puts "RESPONSE (updated_media success): #{JSON.pretty_generate(response.object.to_dict)}"
          puts "RAW RESPONSE (updated_media): #{response.raw_response.body}"
          expect(response.status_code).to eq(200)
          expect(response.object.data.id).to eq(media_id)
          expect(response.object.data.metadata).to be_a(FastpixApiSDK::Models::Components::MediaMetadata)
          expect(response.object.data.metadata.title).to eq(UPDATED_TITLE)
          expect(response.object.data.metadata.description).to eq('Updated Description')
        end
      end

      context UNAUTHORIZED_CONTEXT do
        it VALIDATION_ERROR_DESC do
          metadata = FastpixApiSDK::Models::Operations::UpdatedMediaMetadata.new
          metadata.instance_variable_set(:@title, UPDATED_TITLE)
          request_body = FastpixApiSDK::Models::Operations::UpdatedMediaRequestBody.new(
            metadata: metadata
          )

          error = nil
          begin
            manage_videos.updated_media(media_id: TEST_ID, request_body: request_body)
          rescue UncaughtThrowError => e
            error = e.tag
          end
          puts "RESPONSE (updated_media unauthorized): #{error ? JSON.pretty_generate(error.to_dict) : 'nil'}"
          expect(error).to be_a(FastpixApiSDK::Models::Errors::ValidationErrorResponse)
          expect(error.error.code).to eq(422)
          expect(error.error.message).to eq(PAYLOAD_VALIDATION_FAILED)
        end
      end
    end

    describe '#retrieve_media_input_info' do
      context SUCCESS_CONTEXT do
        it 'retrieves media input information' do
          response = manage_videos.retrieve_media_input_info(media_id: media_id)
          puts "RESPONSE (retrieve_media_input_info success): #{JSON.pretty_generate(response.object.to_dict)}"
          puts "RAW RESPONSE (retrieve_media_input_info): #{response.raw_response.body}"
          expect(response.status_code).to eq(200)
          expect(response.object.data).not_to be_nil
          expect(response.object.data['configuration']['url']).not_to be_nil
          expect(response.object.data['file']['tracks']).not_to be_nil
          expect(response.object.data['file']['containerFormat']).not_to be_nil
        end
      end

      context UNAUTHORIZED_CONTEXT do
        it VALIDATION_ERROR_DESC do
          error = nil
          begin
            manage_videos.retrieve_media_input_info(media_id: TEST_ID)
          rescue UncaughtThrowError => e
            error = e.tag
          end
          puts "RESPONSE (retrieve_media_input_info unauthorized): #{error ? JSON.pretty_generate(error.to_dict) : 'nil'}"
          expect(error).to be_a(FastpixApiSDK::Models::Errors::ValidationErrorResponse)
          expect(error.error.code).to eq(422)
          expect(error.error.message).to eq(PAYLOAD_VALIDATION_FAILED)
        end
      end
    end

    describe '#delete_media' do
      context SUCCESS_CONTEXT do
        it 'deletes the media' do
          response = manage_videos.delete_media(media_id: media_id)
          puts "RESPONSE (delete_media success): #{JSON.pretty_generate(response.object.to_dict)}"
          puts "RAW RESPONSE (delete_media): #{response.raw_response.body}"
          expect(response.status_code).to eq(200)
          expect(response.object.success).to be true
        end
      end

      context UNAUTHORIZED_CONTEXT do
        it VALIDATION_ERROR_DESC do
          error = nil
          begin
            manage_videos.delete_media(media_id: TEST_ID)
          rescue UncaughtThrowError => e
            error = e.tag
          end
          puts "RESPONSE (delete_media unauthorized): #{error ? JSON.pretty_generate(error.to_dict) : 'nil'}"
          expect(error).to be_a(FastpixApiSDK::Models::Errors::ValidationErrorResponse)
          expect(error.error.code).to eq(422)
          expect(error.error.message).to eq(PAYLOAD_VALIDATION_FAILED)
        end
      end
    end
  end
end 