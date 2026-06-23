require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
      security: Models::Components::Security.new(
        username: '1b92c0d6-5548-4642-b13e-4bb7d77dbaf4',
        password: 'ff32012b-ec02-40ca-b0d4-711d81537e73',
      ),
    )

res = s.playback.update_domain_restrictions(media_id: 'f7253f80-af5c-4eb7-9cc7-cd04b7877ff4', playback_id: '9df634b4-06a0-4e43-bcec-74e79826c4af', body: Models::Operations::UpdateDomainRestrictionsRequestBody.new(
  allow: [
    'yourdomain.com',
    'sampledomain.com',
  ],
  deny: [
    'yourworkdomain.com',
  ],
))

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end
