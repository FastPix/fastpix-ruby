require 'spec_helper'
require 'fastpixapi'
require_relative '../config/fastpix_config'

RSpec.describe FastpixApiSDK::StartLiveStream do
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
  let(:start_live_stream) { described_class.new(sdk_config) }

  describe '#create_new_stream' do
    context 'when the request is successful' do
      it 'creates a new live stream' do
        playback_settings = FastpixApiSDK::Models::Components::PlaybackSettings.new(
          access_policy: FastpixApiSDK::Models::Components::PlaybackSettingsAccessPolicy::PUBLIC
        )
        input_media_settings = FastpixApiSDK::Models::Components::InputMediaSettings.new(
          max_resolution: FastpixApiSDK::Models::Components::CreateLiveStreamRequestMaxResolution::ONE_THOUSAND_AND_EIGHTYP,
          reconnect_window: 60,
          media_policy: FastpixApiSDK::Models::Components::MediaPolicy::PUBLIC,
          metadata: FastpixApiSDK::Models::Components::CreateLiveStreamRequestMetadata.new
        )
        request = FastpixApiSDK::Models::Components::CreateLiveStreamRequest.new(
          playback_settings: playback_settings,
          input_media_settings: input_media_settings
        )
        begin
          response = start_live_stream.create_new_stream(request: request)
          puts "RESPONSE (create_new_stream success): #{JSON.pretty_generate(response.live_stream_response_dto.to_dict)}"
          puts "RAW RESPONSE (create_new_stream): #{response.raw_response.body}"
          expect(response.status_code).to eq(201)
        rescue FastpixApiSDK::Models::Errors::APIError => e
          puts "API ERROR: #{e.body}"
          raise
        end
      end
    end
  end
end 