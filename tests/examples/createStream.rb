require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
      security: Models::Components::Security.new(
        username: '1b92c0d6-5548-4642-b13e-4bb7d77dbaf4',
        password: 'ff32012b-ec02-40ca-b0d4-711d81537e73',
      ),
    )

req = Models::Components::CreateLiveStreamRequest.new(
  playback_settings: Models::Components::PlaybackSettings.new(),
  input_media_settings: Models::Components::InputMediaSettings.new(
    metadata: {
      "livestream_name": 'fastpix_livestream',
    },
  ),
)

res = s.start_live_stream.create_new_stream(request: req)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end
