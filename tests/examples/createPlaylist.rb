require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
      security: Models::Components::Security.new(
        username: '1b92c0d6-5548-4642-b13e-4bb7d77dbaf4',
        password: 'ff32012b-ec02-40ca-b0d4-711d81537e73',
      ),
    )

req = Models::Components::CreatePlaylistRequestSmart.new(
  name: 'playlist name',
  reference_id: 'a6',
  type: Models::Components::CreatePlaylistRequestSmartType::SMART,
  description: 'This is a playlist',
  play_order: Models::Components::PlaylistOrder::CREATED_DATE_ASC,
  limit: 20,
  metadata: Models::Components::Metadata.new(
    created_date: Models::Components::DateRange.new(
      start_date: '2024-11-11',
      end_date: '2024-12-12',
    ),
    updated_date: Models::Components::DateRange.new(
      start_date: '2024-11-11',
      end_date: '2024-12-12',
    ),
  ),
)

res = s.playlist.create_a_playlist(request: req)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end
