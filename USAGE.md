<!-- Start SDK Example Usage [usage] -->
```ruby
require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: 'your-access-token',
    password: 'your-secret-key'
  )
)

req = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::PullVideoInput.new(
      type: 'video',
      url: 'https://static.fastpix.com/fp-sample-video.mp4',
    ),
  ],
  metadata: { "key1": 'value1' },
)

begin
  res = s.input_video.create_media(request: req)
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s if defined?(res) && res&.raw_response
end
```
<!-- End SDK Example Usage [usage] -->