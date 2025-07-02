require 'spec_helper'
require 'fastpixapi'
require_relative '../config/fastpix_config'

RSpec.describe FastpixApiSDK::InputVideo do
  let(:sdk_config) do
    FastpixApiSDK::SDKConfiguration.new(
      Faraday.new,
      FastpixApiSDK::SDKHooks::Hooks.new,
      nil,
      30_000,
      FastpixApiSDK::Models::Components::Security.new(
        username: FastPix::Config.username,
        password: FastPix::Config.password
      ),
      nil,
      FastPix::Config.server_url,
      0
    )
  end
  let(:input_video) { described_class.new(sdk_config) }

  describe '#create_media' do
    context 'when the request is successful' do
      it 'creates media from a public URL' do
        request = FastpixApiSDK::Models::Components::CreateMediaRequest.new(
          inputs: [
            FastpixApiSDK::Models::Components::VideoInput.new(
              type: 'video',
              url: 'https://static.fastpix.io/sample.mp4'
            )
          ],
          metadata: FastpixApiSDK::Models::Components::CreateMediaRequestMetadata.new,
          access_policy: FastpixApiSDK::Models::Components::CreateMediaRequestAccessPolicy::PUBLIC,
          max_resolution: FastpixApiSDK::Models::Components::CreateMediaRequestMaxResolution::ONE_THOUSAND_AND_EIGHTYP
        )
        response = input_video.create_media(request: request)
        puts "RESPONSE (create_media success): #{JSON.pretty_generate(response.object.to_dict)}"
        puts "RAW RESPONSE (create_media): #{response.raw_response.body}"
        expect(response.status_code).to eq(201)
        expect(response.object.data.id).not_to be_nil
      end
    end

    context 'when the request fails with bad request' do
      it 'raises validation error for invalid URL' do
        request = FastpixApiSDK::Models::Components::CreateMediaRequest.new(
          inputs: [
            FastpixApiSDK::Models::Components::VideoInput.new(
              type: 'video',
              url: 'invalid-url',
              start_time: 0.0,
              end_time: 60.0
            )
          ],
          access_policy: FastpixApiSDK::Models::Components::CreateMediaRequestAccessPolicy::PUBLIC,
          metadata: FastpixApiSDK::Models::Components::CreateMediaRequestMetadata.new
        )
        error = nil
        begin
          input_video.create_media(request: request)
        rescue UncaughtThrowError => e
          error = e.tag
        end
        puts "RESPONSE (create_media bad request): #{error ? JSON.pretty_generate(error.to_dict) : 'nil'}"
        expect(error).to be_a(FastpixApiSDK::Models::Errors::ValidationErrorResponse)
        expect(error.error.code).to eq(422).or eq(400)
      end
    end

    context 'when the request fails with unauthorized error' do
      it 'skips unauthorized error test (cannot simulate without invalid credentials)' do
        skip 'Cannot simulate unauthorized error without invalid credentials.'
      end
    end
  end

  describe '#direct_upload_video_media' do
    context 'when the request is successful' do
      it 'returns uploadId and presigned URL for direct upload' do
        request = FastpixApiSDK::Models::Operations::DirectUploadVideoMediaRequest.new(
          cors_origin: '*',
          push_media_settings: FastpixApiSDK::Models::Operations::PushMediaSettings.new(
            access_policy: FastpixApiSDK::Models::Operations::DirectUploadVideoMediaAccessPolicy::PUBLIC,
            start_time: 0.0,
            end_time: 60.0
          )
        )
        response = input_video.direct_upload_video_media(request: request)
        puts "RESPONSE (direct_upload_video_media success): #{JSON.pretty_generate(response.object.to_dict)}"
        puts "RAW RESPONSE (direct_upload_video_media): #{response.raw_response.body}"
        puts "FULL RESPONSE OBJECT: #{response.inspect}"
        expect(response.status_code).to eq(201)
        expect(response.object.data.url).not_to be_nil
      end
    end

    context 'when the request fails with bad request' do
      it 'raises validation error for invalid request' do
        request = FastpixApiSDK::Models::Operations::DirectUploadVideoMediaRequest.new(
          cors_origin: '*',
          push_media_settings: FastpixApiSDK::Models::Operations::PushMediaSettings.new(
            access_policy: FastpixApiSDK::Models::Operations::DirectUploadVideoMediaAccessPolicy::PRIVATE,
            start_time: -1.0,
            end_time: 60.0
          )
        )
        error = nil
        begin
          input_video.direct_upload_video_media(request: request)
        rescue UncaughtThrowError => e
          error = e.tag
        end
        puts "RESPONSE (direct_upload_video_media bad request): #{error ? JSON.pretty_generate(error.to_dict) : 'nil'}"
        expect(error).to be_a(FastpixApiSDK::Models::Errors::ValidationErrorResponse)
        expect(error.error.code).to eq(422).or eq(400)
      end
    end

    context 'when the request fails with unauthorized error' do
      it 'skips unauthorized error test (cannot simulate without invalid credentials)' do
        skip 'Cannot simulate unauthorized error without invalid credentials.'
      end
    end
  end
end 