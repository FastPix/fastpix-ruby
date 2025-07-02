require 'spec_helper'
require 'fastpixapi'
require_relative '../config/fastpix_config'

RSpec.describe FastpixApiSDK::ManageLiveStream do
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
      FastPix::Config.live_stream_url,
      0
    )
  end
  let(:manage_live_stream) { described_class.new(sdk_config) }

  describe '#get_all_streams' do
    context 'when the request is successful' do
      it 'retrieves all live streams' do
        response = manage_live_stream.get_all_streams
        puts "RESPONSE (get_all_streams success): #{JSON.pretty_generate(response.get_streams_response.to_dict)}"
        puts "RAW RESPONSE (get_all_streams): #{response.raw_response.body}"
        expect(response.status_code).to eq(200)
      end
    end
  end

  describe '#get_live_stream_by_id' do
    context 'when the request is successful' do
      it 'retrieves a live stream by ID' do
        all_streams_response = manage_live_stream.get_all_streams
        stream_id = all_streams_response.get_streams_response.data.first.stream_id
        response = manage_live_stream.get_live_stream_by_id(stream_id: stream_id)
        puts "RESPONSE (get_live_stream_by_id success): #{JSON.pretty_generate(response.livestreamget_response.to_dict)}"
        puts "RAW RESPONSE (get_live_stream_by_id): #{response.raw_response.body}"
        expect(response.status_code).to eq(200)
      end
    end
  end

  describe '#delete_live_stream' do
    context 'when the request is successful' do
      it 'deletes a live stream' do
        all_streams_response = manage_live_stream.get_all_streams
        stream_id = all_streams_response.get_streams_response.data.first.stream_id
        response = manage_live_stream.delete_live_stream(stream_id: stream_id)
        puts "RESPONSE (delete_live_stream success): #{JSON.pretty_generate(response.live_stream_delete_response.to_dict)}"
        puts "RAW RESPONSE (delete_live_stream): #{response.raw_response.body}"
        expect(response.status_code).to eq(200)
      end
    end
  end

  describe '#update_live_stream' do
    context 'when the request is successful' do
      it 'updates a live stream' do
        all_streams_response = manage_live_stream.get_all_streams
        stream_id = all_streams_response.get_streams_response.data.first.stream_id
        patch_request = FastpixApiSDK::Models::Components::PatchLiveStreamRequest.new(
          reconnect_window: 60
        )
        response = manage_live_stream.update_live_stream(stream_id: stream_id, patch_live_stream_request: patch_request)
        puts "RESPONSE (update_live_stream success): #{JSON.pretty_generate(response.patch_response_dto.to_dict)}"
        puts "RAW RESPONSE (update_live_stream): #{response.raw_response.body}"
        expect(response.status_code).to eq(200)
      end
    end
  end
end 