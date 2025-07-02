<!-- Start SDK Example Usage [usage] -->
```ruby
require 'fastpixapi'

s = ::FastpixApiSDK::SDK.new(
      security: Models::Components::Security.new(
        username: '',
        password: '',
      ),
    )

req = Models::Components::CreateLiveStreamRequest.new(
  playback_settings: Models::Components::PlaybackSettings.new(),
  input_media_settings: Models::Components::InputMediaSettings.new(
    metadata: Models::Components::CreateLiveStreamRequestMetadata.new(),
  ),
)

res = s.start_live_stream.create_new_stream(req)

if ! res.live_stream_response_dto.nil?
  # handle response
end

```
<!-- End SDK Example Usage [usage] -->