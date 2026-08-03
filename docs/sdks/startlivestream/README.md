# StartLiveStream

## Overview

Operations for starting live streams

### Available Operations

* [create_new_stream](#create_new_stream) - Create a new stream

## create_new_stream

Creates a new <a href="https://fastpix.com/docs/live-streaming/live-stream-with-rtmps">RTMPS</a> or <a href="https://fastpix.com/docs/live-streaming/live-stream-with-srt">SRT</a> live stream in FastPix. When you create a stream, FastPix generates a unique `streamKey` and `srtSecret` that you can use with broadcasting software such as OBS to connect to FastPix RTMPS or SRT servers. Use SRT for live streaming in unstable network conditions, as it provides error correction and encryption for a more reliable and secure broadcast.


Leverage SRT for live streaming in environments with unstable networks, taking advantage of its error correction and encryption features for a resilient and secure broadcast. 

<h4>How it works</h4> 

1. Send a `POST` request to this endpoint. You can configure the stream settings, including `metadata` (such as stream name and description), `reconnectWindow` (in case of disconnection), and privacy options (`public` or `private`). 

2. FastPix returns the stream details for both RTMPS and SRT configurations. These keys and IDs from the stream details are essential for connecting the broadcasting software to FastPix’s servers and transmitting the live stream to viewers.

3. After the live stream is created, FastPix sends a `POST` request to your specified webhook endpoint with the event <a href="https://fastpix.com/docs/webhooks/live-events#videolive_streamcreated">video.live_stream.created</a>.

**Example:**


  Imagine a gaming platform that allows users to live stream gameplay directly from their dashboard. The API creates a new stream, provides the necessary stream key, and sets it to "private" so that only specific viewers can access it. 


Related guide: <a href="https://fastpix.com/docs/live-streaming/quickstart">How to live stream</a>

### Example Usage

<!-- UsageSnippet language="ruby" operationID="create-new-stream" method="post" path="/live/streams" -->
```ruby
require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
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

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `request`                                                                                     | [Models::Components::CreateLiveStreamRequest](../../models/shared/createlivestreamrequest.md) | :heavy_check_mark:                                                                            | The request object to use for the request.                                                    |

### Response

**[T.nilable(Models::Operations::CreateNewStreamResponse)](../../models/operations/createnewstreamresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |