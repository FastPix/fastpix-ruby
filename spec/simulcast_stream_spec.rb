require 'spec_helper'
require 'fastpixapi'
require_relative '../config/fastpix_config'

RSpec.describe FastpixApiSDK::SimulcastStream do
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
  let(:simulcast_stream) { described_class.new(sdk_config) }

  let(:manage_live_stream) { FastpixApiSDK::ManageLiveStream.new(sdk_config) }

  let(:stream_id) do
    all_streams_response = manage_live_stream.get_all_streams
    all_streams_response.get_streams_response.data.first.stream_id
  end

  let(:simulcast_request) do
    FastpixApiSDK::Models::Components::SimulcastRequest.new(
      url: 'rtmp://hyd01.contribute.live-video.net/app/',
      stream_key: 'live_1012464221_DuM8W004MoZYNxQEZ0czODgfHCFBhk'
    )
  end

  describe '#create_simulcast_of_stream' do
    it 'creates a simulcast for a stream' do
      response = simulcast_stream.create_simulcast_of_stream(
        stream_id: stream_id,
        simulcast_request: simulcast_request
      )
      puts "RESPONSE (create_simulcast_of_stream): #{JSON.pretty_generate(response.simulcast_response.to_dict)}"
      puts "RAW RESPONSE (create_simulcast_of_stream): #{response.raw_response.body}"
      expect(response.status_code).to eq(201)
      @simulcast_id = response.simulcast_response.data.simulcast_id
    end
  end

  describe '#get_specific_simulcast_of_stream' do
    it 'gets a specific simulcast of a stream' do
      # Create simulcast first
      create_response = simulcast_stream.create_simulcast_of_stream(
        stream_id: stream_id,
        simulcast_request: simulcast_request
      )
      simulcast_id = create_response.simulcast_response.data.simulcast_id
      response = simulcast_stream.get_specific_simulcast_of_stream(
        stream_id: stream_id,
        simulcast_id: simulcast_id
      )
      puts "RESPONSE (get_specific_simulcast_of_stream): #{JSON.pretty_generate(response.simulcast_response.to_dict)}"
      puts "RAW RESPONSE (get_specific_simulcast_of_stream): #{response.raw_response.body}"
      expect(response.status_code).to eq(200)
    end
  end

  describe '#update_specific_simulcast_of_stream' do
    it 'updates a specific simulcast of a stream' do
      # Create simulcast first
      create_response = simulcast_stream.create_simulcast_of_stream(
        stream_id: stream_id,
        simulcast_request: simulcast_request
      )
      simulcast_id = create_response.simulcast_response.data.simulcast_id
      metadata_obj = FastpixApiSDK::Models::Components::SimulcastUpdateRequestMetadata.new
      update_request = FastpixApiSDK::Models::Components::SimulcastUpdateRequest.new(
        is_enabled: false,
        metadata: metadata_obj
      )
      response = simulcast_stream.update_specific_simulcast_of_stream(
        stream_id: stream_id,
        simulcast_id: simulcast_id,
        simulcast_update_request: update_request
      )
      puts "RESPONSE (update_specific_simulcast_of_stream): #{JSON.pretty_generate(response.simulcast_update_response.to_dict)}"
      puts "RAW RESPONSE (update_specific_simulcast_of_stream): #{response.raw_response.body}"
      expect(response.status_code).to eq(200)
      expect(response.simulcast_update_response.data.is_enabled).to eq(false)
    end
  end

  describe '#delete_simulcast_of_stream' do
    it 'deletes a simulcast of a stream' do
      # Create simulcast first
      create_response = simulcast_stream.create_simulcast_of_stream(
        stream_id: stream_id,
        simulcast_request: simulcast_request
      )
      simulcast_id = create_response.simulcast_response.data.simulcast_id
      response = simulcast_stream.delete_simulcast_of_stream(
        stream_id: stream_id,
        simulcast_id: simulcast_id
      )
      puts "RESPONSE (delete_simulcast_of_stream): #{response.simulcastdelete_response.success}"
      puts "RAW RESPONSE (delete_simulcast_of_stream): #{response.raw_response.body}"
      expect(response.status_code).to eq(200)
      expect(response.simulcastdelete_response.success).to eq(true)
    end
  end
end 