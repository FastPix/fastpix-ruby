require 'spec_helper'
           b require 'fastpixapi'
require_relative '../config/fastpix_config'

RSpec.describe FastpixApiSDK::Playback do
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
  let(:playback) { described_class.new(sdk_config) }

  let(:playback_media) do
    FastpixApiSDK::Playback.new(
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
    )
  end

  describe '#create_playback_id_of_stream' do
    context 'when the request is successful' do
      it 'creates a playback ID for a stream' do
        # First, get a stream ID from the live stream
        manage_live_stream = FastpixApiSDK::ManageLiveStream.new(sdk_config)
        all_streams_response = manage_live_stream.get_all_streams
        stream_id = all_streams_response.get_streams_response.data.first.stream_id
        puts "Using stream_id: #{stream_id}"

        playback_id_request = FastpixApiSDK::Models::Components::PlaybackIdRequest.new(
          access_policy: FastpixApiSDK::Models::Components::PlaybackIdRequestAccessPolicy::PUBLIC
        )
        response = playback.create_playback_id_of_stream(
          stream_id: stream_id,
          playback_id_request: playback_id_request
        )
        puts "RESPONSE (create_playback_id_of_stream success): #{JSON.pretty_generate(response.playback_id_response.to_dict)}"
        puts "RAW RESPONSE (create_playback_id_of_stream): #{response.raw_response.body}"
        expect(response.status_code).to eq(201)
      end
    end
  end

  describe '#get_live_stream_playback_id' do
    context 'when the request is successful' do
      it 'retrieves a playback ID for a stream' do
        # First, get a stream ID and create a playback ID
        manage_live_stream = FastpixApiSDK::ManageLiveStream.new(sdk_config)
        all_streams_response = manage_live_stream.get_all_streams
        stream_id = all_streams_response.get_streams_response.data.first.stream_id
        
        playback_id_request = FastpixApiSDK::Models::Components::PlaybackIdRequest.new(
          access_policy: FastpixApiSDK::Models::Components::PlaybackIdRequestAccessPolicy::PUBLIC
        )
        create_response = playback.create_playback_id_of_stream(
          stream_id: stream_id,
          playback_id_request: playback_id_request
        )
        playback_id = create_response.playback_id_response.data.id

        response = playback.get_live_stream_playback_id(stream_id: stream_id, playback_id: playback_id)
        puts "RESPONSE (get_live_stream_playback_id success): #{JSON.pretty_generate(response.playback_id_response.to_dict)}"
        puts "RAW RESPONSE (get_live_stream_playback_id): #{response.raw_response.body}"
        expect(response.status_code).to eq(200)
      end
    end
  end

  describe '#create_media_playback_id' do
    context 'when the request is successful' do
      it 'creates a playback ID for a media asset' do
        begin
          # First, get a media ID from the media list
          manage_videos = FastpixApiSDK::ManageVideos.new(
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
          )
          all_media_response = manage_videos.list_media
          media_id = all_media_response.object.data.first.id
          puts "Using media_id: #{media_id}"

          request_body = FastpixApiSDK::Models::Operations::CreateMediaPlaybackIdRequestBody.new(
            access_policy: FastpixApiSDK::Models::Operations::CreateMediaPlaybackIdAccessPolicy::PUBLIC
          )
          response = playback_media.create_media_playback_id(
            media_id: media_id,
            request_body: request_body
          )
          puts "RESPONSE (create_media_playback_id success): #{JSON.pretty_generate(response.object.to_dict)}"
          puts "RAW RESPONSE (create_media_playback_id): #{response.raw_response.body}"
          expect(response.status_code).to eq(201)
        rescue FastpixApiSDK::Models::Errors::APIError => e
          puts "APIError caught!"
          puts "Status: ", e.status_code if e.respond_to?(:status_code)
          puts "Body: ", e.body if e.respond_to?(:body)
          puts "Raw Response: ", e.raw_response.inspect if e.respond_to?(:raw_response)
          raise
        end
      end
    end
  end

  describe '#delete_media_playback_id' do
    context 'when the request is successful' do
      it 'deletes a playback ID for a stream' do
        manage_live_stream = FastpixApiSDK::ManageLiveStream.new(sdk_config)
        all_streams_response = manage_live_stream.get_all_streams
        stream_id = all_streams_response.get_streams_response.data.first.stream_id
        puts "Using stream_id: #{stream_id}"

        playback_id_request = FastpixApiSDK::Models::Components::PlaybackIdRequest.new(
          access_policy: FastpixApiSDK::Models::Components::PlaybackIdRequestAccessPolicy::PUBLIC
        )
        create_response = playback.create_playback_id_of_stream(
          stream_id: stream_id,
          playback_id_request: playback_id_request
        )
        playback_id = create_response.playback_id_response.data.id

        response = playback.delete_playback_id_of_stream(
          stream_id: stream_id,
          playback_id: playback_id
        )
        puts "RESPONSE (delete_playback_id_of_stream success): #{response.live_stream_delete_response.success}"
        puts "RAW RESPONSE (delete_playback_id_of_stream): #{response.raw_response.body}"
        expect(response.status_code).to eq(200)
        expect(response.live_stream_delete_response.success).to eq(true)
      end
    end
  end
end 