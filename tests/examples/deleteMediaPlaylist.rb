
require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
      security: Models::Components::Security.new(
        username: '1b92c0d6-5548-4642-b13e-4bb7d77dbaf4',
        password: 'ff32012b-ec02-40ca-b0d4-711d81537e73',
      ),
    )

res = s.playlist.delete_media_from_playlist(playlist_id: 'dd1e13a6-011b-4f87-b78d-45855d537cad', body: Models::Components::MediaIdsRequest.new(
  media_ids: [
    'f7253f80-af5c-4eb7-9cc7-cd04b7877ff4',
    '8063b4d6-a3c1-4934-8084-8bfae5fcfa90',
    '4cbd1bbc-9c9c-42fe-9e2a-c96e60caf701'
  ],
))

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end
