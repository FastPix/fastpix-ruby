require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
      security: Models::Components::Security.new(
    username: 'your-access-token',
    password: 'your-secret-key'
      ),
    )

res = s.manage_videos.list_media(limit: 20, offset: 1, order_by: Models::Components::SortOrder::DESC)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end