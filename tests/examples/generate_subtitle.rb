require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
      security: Models::Components::Security.new(
        username: '1b92c0d6-5548-4642-b13e-4bb7d77dbaf4',
        password: 'ff32012b-ec02-40ca-b0d4-711d81537e73',
      ),
    )



begin
    res = s.manage_videos.generate_subtitle_track(media_id: 'f7253f80-af5c-4eb7-9cc7-cd04b7877ff4', track_id: '81bd80d8-831a-4d82-913b-4b5aff49b646', body: Models::Components::TrackSubtitlesGenerateRequest.new(
  language_name: 'Italian',
))
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end
