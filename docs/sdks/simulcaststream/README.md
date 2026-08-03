# SimulcastStream

## Overview

Operations for simulcast stream management

### Available Operations

* [create_simulcast_of_stream](#create_simulcast_of_stream) - Create a simulcast
* [delete_simulcast_of_stream](#delete_simulcast_of_stream) - Delete a simulcast
* [get_specific_simulcast_of_stream](#get_specific_simulcast_of_stream) - Get a specific simulcast
* [update_specific_simulcast_of_stream](#update_specific_simulcast_of_stream) - Update a simulcast

## create_simulcast_of_stream

Creates a simulcast for a parent live stream. Simulcasting allows you to broadcast a live stream to multiple social platforms simultaneously (for example, YouTube, Facebook, or Twitch). This helps expand your audience reach across platforms. A simulcast can only be created when the parent live stream is in the idle state (not currently live or disabled). Only one simulcast target can be created per API call. 
#### How it works

1. Change to: When you call this endpoint, provide the parent `streamId` along with the simulcast target details (such as platform and credentials). The API returns a unique `simulcastId`, which you can use to manage the simulcast later.  

2. To notify your application about the status of simulcast related events check for the <a href="https://fastpix.com/docs/webhooks/webhook-event-reference#simulcast-target-events">webhooks for simulcast</a> target events. 

#### Example
An event manager sets up a live stream for a virtual conference and wants to simulcast the stream on YouTube and Facebook Live. They first create the primary live stream in FastPix, ensuring it's in the idle state. Then, they use the API to create a simulcast target for YouTube. 

Related guide: <a href="https://fastpix.com/docs/live-streaming/simulcast-to-multiple-platforms">Simulcast to 3rd party platforms</a>

### Example Usage

<!-- UsageSnippet language="ruby" operationID="create-simulcast-of-stream" method="post" path="/live/streams/{streamId}/simulcast" -->
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

res = s.simulcast_stream.create_simulcast_of_stream(stream_id: 'your-stream-id', body: Models::Components::SimulcastRequest.new(
  url: 'rtmp://hyd01.contribute.live-video.net/app/',
  stream_key: 'your-stream-key',
  metadata: {
    "livestream_name": 'Tech-Connect Summit',
  },
))

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                                                                                         | Type                                                                                                                                                                              | Required                                                                                                                                                                          | Description                                                                                                                                                                       | Example                                                                                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `stream_id`                                                                                                                                                                       | *::String*                                                                                                                                                                        | :heavy_check_mark:                                                                                                                                                                | After creating a new live stream, FastPix assigns a unique identifier to the stream.                                                                                              | your-stream-id                                                                                                                                                  |
| `body`                                                                                                                                                                            | [Models::Components::SimulcastRequest](../../models/shared/simulcastrequest.md)                                                                                                   | :heavy_check_mark:                                                                                                                                                                | N/A                                                                                                                                                                               | {<br/>"url": "rtmp://hyd01.contribute.live-video.net/app/",<br/>"streamKey": "your-stream-key",<br/>"metadata": {<br/>"livestream_name": "Tech-Connect Summit"<br/>}<br/>} |

### Response

**[T.nilable(Models::Operations::CreateSimulcastOfStreamResponse)](../../models/operations/createsimulcastofstreamresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## delete_simulcast_of_stream

Deletes a simulcast using its unique simulcastId, which you received during the simulcast creation process. Deleting a simulcast stops the broadcast to the associated platform, while the parent stream continues if it’s live. This action can’t be undone, and you must create a new simulcast to resume streaming to the same platform.

Webhook event: <a href="https://fastpix.com/docs/webhooks/live-events#videolive_streamsimulcast_targetdeleted">video.live_stream.simulcast_target.deleted</a>


#### Example
A broadcaster may need to stop simulcasting to one platform while keeping the stream active on others. For example, a tech company is simulcasting a product launch across multiple platforms. Midway through the event, they decide to stop the simulcast on Facebook due to performance issues but continue streaming on YouTube. They use this API to delete the Facebook simulcast target. 

### Example Usage

<!-- UsageSnippet language="ruby" operationID="delete-simulcast-of-stream" method="delete" path="/live/streams/{streamId}/simulcast/{simulcastId}" -->
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

res = s.simulcast_stream.delete_simulcast_of_stream(stream_id: 'your-stream-id', simulcast_id: 'your-simulcast-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                                      | Type                                                                                                                           | Required                                                                                                                       | Description                                                                                                                    | Example                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| `stream_id`                                                                                                                    | *::String*                                                                                                                     | :heavy_check_mark:                                                                                                             | After creating a new live stream, FastPix assigns a unique identifier to the stream.                                           | your-stream-id                                                                                               |
| `simulcast_id`                                                                                                                 | *::String*                                                                                                                     | :heavy_check_mark:                                                                                                             | When you create the new simulcast, FastPix assign a universal unique identifier which can contain a maximum of 255 characters. | your-simulcast-id                                                                                               |

### Response

**[T.nilable(Models::Operations::DeleteSimulcastOfStreamResponse)](../../models/operations/deletesimulcastofstreamresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## get_specific_simulcast_of_stream

Retrieves the details of a specific simulcast associated with a parent live stream. By providing both the `streamId` of the parent stream and the `simulcastId`, FastPix returns detailed information about the simulcast, such as the stream URL, the status of the simulcast, and metadata. 

#### Example
This endpoint can be used to verify the status of the simulcast on external platforms before the live stream begins. For example, before starting a live gaming event, the organizer wants to ensure that the simulcast to Twitch is set up correctly. They retrieve the simulcast information to confirm that everything is properly configured.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-specific-simulcast-of-stream" method="get" path="/live/streams/{streamId}/simulcast/{simulcastId}" -->
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

res = s.simulcast_stream.get_specific_simulcast_of_stream(stream_id: 'your-stream-id', simulcast_id: 'your-simulcast-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                                      | Type                                                                                                                           | Required                                                                                                                       | Description                                                                                                                    | Example                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| `stream_id`                                                                                                                    | *::String*                                                                                                                     | :heavy_check_mark:                                                                                                             | After creating a new live stream, FastPix assigns a unique identifier to the stream.                                           | your-stream-id                                                                                               |
| `simulcast_id`                                                                                                                 | *::String*                                                                                                                     | :heavy_check_mark:                                                                                                             | When you create the new simulcast, FastPix assign a universal unique identifier which can contain a maximum of 255 characters. | your-simulcast-id                                                                                               |

### Response

**[T.nilable(Models::Operations::GetSpecificSimulcastOfStreamResponse)](../../models/operations/getspecificsimulcastofstreamresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## update_specific_simulcast_of_stream

Updates the status of a specific simulcast linked to a parent live stream. You can enable or disable the simulcast at any time while the parent stream is active or idle. After the live stream is disabled, the simulcast can no longer be modified.

Webhook event: <a href="https://fastpix.com/docs/webhooks/live-events#videolive_streamsimulcast_targetupdated">video.live_stream.simulcast_target.updated</a>

#### Example
When a `PATCH` request is made to this endpoint, the API updates the status of the simulcast. This can be useful for pausing or resuming a simulcast on a particular platform without stopping the parent live stream.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-specific-simulcast-of-stream" method="put" path="/live/streams/{streamId}/simulcast/{simulcastId}" -->
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

res = s.simulcast_stream.update_specific_simulcast_of_stream(stream_id: 'your-stream-id', simulcast_id: 'your-simulcast-id', body: Models::Components::SimulcastUpdateRequest.new(
  metadata: {
    "simulcast_name": 'Tech today',
  },
))

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                                      | Type                                                                                                                           | Required                                                                                                                       | Description                                                                                                                    | Example                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| `stream_id`                                                                                                                    | *::String*                                                                                                                     | :heavy_check_mark:                                                                                                             | Upon creating a new live stream, FastPix assigns a unique identifier to the stream.                                            | your-stream-id                                                                                               |
| `simulcast_id`                                                                                                                 | *::String*                                                                                                                     | :heavy_check_mark:                                                                                                             | When you create the new simulcast, FastPix assign a universal unique identifier which can contain a maximum of 255 characters. | your-simulcast-id                                                                                               |
| `body`                                                                                                                         | [Models::Components::SimulcastUpdateRequest](../../models/shared/simulcastupdaterequest.md)                                    | :heavy_check_mark:                                                                                                             | N/A                                                                                                                            | {<br/>"isEnabled": true,<br/>"metadata": {<br/>"simulcast_name": "Tech today"<br/>}<br/>}                                      |

### Response

**[T.nilable(Models::Operations::UpdateSpecificSimulcastOfStreamResponse)](../../models/operations/updatespecificsimulcastofstreamresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |