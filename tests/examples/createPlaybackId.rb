require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
      security: Models::Components::Security.new(
         username: '1b92c0d6-5548-4642-b13e-4bb7d77dbaf4',
       password: 'ff32012b-ec02-40ca-b0d4-711d81537e73'
      ),
    )

begin
  res = s.playback.create_media_playback_id(media_id: 'f7253f80-af5c-4eb7-9cc7-cd04b7877ff4', body: Models::Operations::CreateMediaPlaybackIdRequestBody.new(
    access_policy: Models::Components::AccessPolicy::PUBLIC,
    resolution: Models::Operations::Resolution::ONE_THOUSAND_AND_EIGHTYP,
  ))
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts "HTTP #{e.status_code}"
  puts JSON.pretty_generate(JSON.parse(e.body))
end
