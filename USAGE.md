<!-- Start SDK Example Usage [usage] -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

req = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::VideoInput.new(
      type: 'video',
      url: 'https://static.fastpix.io/sample.mp4',
    ),
  ],
  metadata: {
    "key1": 'value1',
  },
  access_policy: Models::Components::CreateMediaRequestAccessPolicy::PUBLIC,
)

res = s.input_video.create_media(request: req)

unless res.create_media_success_response.nil?
  # handle response
end

```
<!-- End SDK Example Usage [usage] -->