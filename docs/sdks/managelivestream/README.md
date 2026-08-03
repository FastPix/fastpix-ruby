# ManageLiveStream

## Overview

Operations for managing live streams

### Available Operations

* [get_all_streams](#get_all_streams) - Get all live streams
* [get_live_stream_viewer_count_by_id](#get_live_stream_viewer_count_by_id) - Get stream views by ID
* [get_live_stream_by_id](#get_live_stream_by_id) - Get stream by ID
* [delete_live_stream](#delete_live_stream) - Delete a stream
* [update_live_stream](#update_live_stream) - Update a stream
* [enable_live_stream](#enable_live_stream) - Enable a stream
* [disable_live_stream](#disable_live_stream) - Disable a stream
* [complete_live_stream](#complete_live_stream) - Complete a stream

## get_all_streams

Retrieves a list of all live streams associated with the current workspace. It provides an overview of both current and past live streams, including details like `streamId`, `metadata`, `status`, `createdAt` and more.


#### How it works

Use the access token and secret key related to the workspace in the request header. When called, the API provides a paginated response containing all the live streams in that specific workspace. This is helpful for retrieving a large volume of streams and managing content in bulk.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-all-streams" method="get" path="/live/streams" -->
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

res = s.manage_live_stream.get_all_streams(limit: 20, offset: 1, order_by: Models::Operations::OrderBy::DESC)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                                           | Type                                                                                                                                | Required                                                                                                                            | Description                                                                                                                         | Example                                                                                                                             |
| ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `limit`                                                                                                                             | *T.nilable(::Integer)*                                                                                                              | :heavy_minus_sign:                                                                                                                  | Limit specifies the maximum number of items to display per page.                                                                    | 20                                                                                                                                  |
| `offset`                                                                                                                            | *T.nilable(::Integer)*                                                                                                              | :heavy_minus_sign:                                                                                                                  | Offset determines the starting point for data retrieval within a paginated list.                                                    | 1                                                                                                                                   |
| `order_by`                                                                                                                          | [T.nilable(Models::Operations::OrderBy)](../../models/operations/orderby.md)                                                        | :heavy_minus_sign:                                                                                                                  | The list of value can be order in two ways DESC (Descending) or ASC (Ascending). In case not specified, by default it will be DESC. | desc                                                                                                                                |

### Response

**[T.nilable(Models::Operations::GetAllStreamsResponse)](../../models/operations/getallstreamsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## get_live_stream_viewer_count_by_id

This endpoint retrieves the current number of viewers watching a specific live stream, identified by its unique `streamId`.

The viewer count is an **approximate value**, optimized for performance. It provides a near-real-time estimate of how many clients are actively watching the stream. This approach ensures high efficiency, especially when the stream is being watched at large scale across multiple devices or platforms.

#### Example

Suppose a content creator is hosting a live concert and wants to display the number of live viewers on their dashboard. This endpoint can be queried to show up-to-date viewer statistics.

Related guide: <a href="https://fastpix.com/docs/live-streaming/create-and-manage-live-streams#how-to-get-stream-viewers">Manage streams</a>

### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-live-stream-viewer-count-by-id" method="get" path="/live/streams/{streamId}/viewer-count" -->
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

res = s.manage_live_stream.get_live_stream_viewer_count_by_id(stream_id: 'your-stream-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                            | Type                                                                                 | Required                                                                             | Description                                                                          | Example                                                                              |
| ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ |
| `stream_id`                                                                          | *::String*                                                                           | :heavy_check_mark:                                                                   | After creating a new live stream, FastPix assigns a unique identifier to the stream. | your-stream-id                                                     |

### Response

**[T.nilable(Models::Operations::GetLiveStreamViewerCountByIdResponse)](../../models/operations/getlivestreamviewercountbyidresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## get_live_stream_by_id

This endpoint retrieves details about a specific live stream by its unique `streamId`. It includes data such as the stream’s `status` (idle, preparing, active, disabled), `metadata` (title, description), and more. 
#### Example

  Suppose a news agency is broadcasting a live event and wants to track the configurations set for the live stream while also checking the stream's status.


Related guide: <a href="https://fastpix.com/docs/live-streaming/create-and-manage-live-streams#how-to-get-stream-viewers">Manage streams</a>

### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-live-stream-by-id" method="get" path="/live/streams/{streamId}" -->
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

res = s.manage_live_stream.get_live_stream_by_id(stream_id: 'your-stream-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         | Example                                                                             |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `stream_id`                                                                         | *::String*                                                                          | :heavy_check_mark:                                                                  | Upon creating a new live stream, FastPix assigns a unique identifier to the stream. | your-stream-id                                                    |

### Response

**[T.nilable(Models::Operations::GetLiveStreamByIdResponse)](../../models/operations/getlivestreambyidresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## delete_live_stream

Permanently deletes a specified live stream from the workspace. If the stream is active, the encoder is disconnected and ingestion stops immediately. This action is irreversible, and any future playback attempts fail as a result.

    Provide the `streamId` in the request to terminate active connections and remove the stream from the workspace. You can further look for <a href="https://fastpix.com/docs/webhooks/live-events#videolive_streamdeleted">video.live_stream.deleted</a> webhook to notify your system about the status.

  #### Example

  For an online concert platform, a trial stream was mistakenly made public. The event manager deletes the stream before the concert begins to avoid confusion among viewers. 


    Related guide: <a href="https://fastpix.com/docs/live-streaming/create-and-manage-live-streams#delete-a-stream">Manage streams</a>

### Example Usage

<!-- UsageSnippet language="ruby" operationID="delete-live-stream" method="delete" path="/live/streams/{streamId}" -->
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

res = s.manage_live_stream.delete_live_stream(stream_id: 'your-stream-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         | Example                                                                             |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `stream_id`                                                                         | *::String*                                                                          | :heavy_check_mark:                                                                  | Upon creating a new live stream, FastPix assigns a unique identifier to the stream. | your-stream-id                                                    |

### Response

**[T.nilable(Models::Operations::DeleteLiveStreamResponse)](../../models/operations/deletelivestreamresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## update_live_stream

This endpoint allows you to modify the parameters of an existing live stream, such as its `metadata` (title, description) or the `reconnectWindow`. It’s useful for making changes to a stream that has already been created but not yet ended. After the live stream is disabled, you cannot update a stream. 


  
  The updated stream parameters and the `streamId` needs to be shared in the request, and FastPix returns the updated stream details. After the update, <a href="https://fastpix.com/docs/webhooks/live-events#videolive_streamupdated">video.live_stream.updated</a> webhook event notifies your system.

 #### Example

 A host realizes they need to extend the reconnect window for their live stream in case they lose connection temporarily during the event. Or suppose during a multi-day online conference, the event organizers need to update the stream title to reflect the next day"s session while keeping the same stream ID for continuity. 



   Related guide: <a href="https://fastpix.com/docs/live-streaming/create-and-manage-live-streams#delete-a-stream">Manage streams</a>

### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-live-stream" method="patch" path="/live/streams/{streamId}" -->
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

res = s.manage_live_stream.update_live_stream(stream_id: 'your-stream-id', body: Models::Components::PatchLiveStreamRequest.new(
  metadata: {
    "livestream_name": 'Gaming_stream',
  },
  reconnect_window: 100,
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

| Parameter                                                                                   | Type                                                                                        | Required                                                                                    | Description                                                                                 | Example                                                                                     |
| ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------- |
| `stream_id`                                                                                 | *::String*                                                                                  | :heavy_check_mark:                                                                          | After creating a new live stream, FastPix assigns a unique identifier to the stream.        | your-stream-id                                                            |
| `body`                                                                                      | [Models::Components::PatchLiveStreamRequest](../../models/shared/patchlivestreamrequest.md) | :heavy_check_mark:                                                                          | N/A                                                                                         | {<br/>"metadata": {<br/>"livestream_name": "Gaming_stream"<br/>},<br/>"reconnectWindow": 100<br/>} |

### Response

**[T.nilable(Models::Operations::UpdateLiveStreamResponse)](../../models/operations/updatelivestreamresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## enable_live_stream

This endpoint allows you to enable a livestream by transitioning its status from `disabled` to `idle`. After it is enabled, the stream becomes available and ready to accept an incoming broadcast from a streaming tool.

Streams on the trial plan cannot be re-enabled if they are in the `disabled` state.

The `livestreamId` must be provided in the path, and the stream must not already be in an enabled state (`idle`, `preparing`, or `active`).

#### Example

A creator disables a livestream to pause it temporarily. Later, they decide to continue the session. By calling this endpoint with the stream's ID, they can re-enable and restart the same livestream.

Related guide <a href="https://fastpix.com/docs/live-streaming/create-and-manage-live-streams#disable-a-stream">Manage streams</a>

### Example Usage

<!-- UsageSnippet language="ruby" operationID="enable-live-stream" method="put" path="/live/streams/{streamId}/live-enable" -->
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

res = s.manage_live_stream.enable_live_stream(stream_id: 'your-stream-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         | Example                                                                             |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `stream_id`                                                                         | *::String*                                                                          | :heavy_check_mark:                                                                  | Upon creating a new live stream, FastPix assigns a unique identifier to the stream. | your-stream-id                                                    |

### Response

**[T.nilable(Models::Operations::EnableLiveStreamResponse)](../../models/operations/enablelivestreamresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## disable_live_stream

This endpoint disables a livestream by setting its status to `disabled`. Use this to stop a livestream when it's no longer needed or must be taken offline intentionally.

A disabled stream can later be re-enabled using the enable endpoint — however, if you're on a trial plan, re-enabling is not allowed once the stream is disabled.

#### Example

A speaker finishes their live session and wants to prevent the stream from being mistakenly started again. By calling this endpoint, the stream is transitioned to a `disabled` state, ensuring it's permanently stopped (unless re-enabled on a paid plan).

Related guide <a href="https://fastpix.com/docs/live-streaming/create-and-manage-live-streams#disable-a-stream">Manage streams</a>

### Example Usage

<!-- UsageSnippet language="ruby" operationID="disable-live-stream" method="put" path="/live/streams/{streamId}/live-disable" -->
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

res = s.manage_live_stream.disable_live_stream(stream_id: 'your-stream-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                            | Type                                                                                 | Required                                                                             | Description                                                                          | Example                                                                              |
| ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ |
| `stream_id`                                                                          | *::String*                                                                           | :heavy_check_mark:                                                                   | After creating a new live stream, FastPix assigns a unique identifier to the stream. | your-stream-id                                                     |

### Response

**[T.nilable(Models::Operations::DisableLiveStreamResponse)](../../models/operations/disablelivestreamresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## complete_live_stream

This endpoint marks a livestream as completed by stopping the active stream and transitioning its status to `idle`. It is typically used after a livestream session has ended.

This operation only works when the stream is in the `active` state.

Completing a stream can help finalize the session and trigger post-processing events like VOD generation.

#### Example

A virtual event ends, and the system or host needs to close the livestream to prevent further streaming. This endpoint ensures the livestream status is changed from `active` to `idle`, indicating it's officially completed.

Related guide <a href="https://fastpix.com/docs/live-streaming/create-and-manage-live-streams#disable-a-stream">Manage streams</a>

### Example Usage

<!-- UsageSnippet language="ruby" operationID="complete-live-stream" method="put" path="/live/streams/{streamId}/finish" -->
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

res = s.manage_live_stream.complete_live_stream(stream_id: 'your-stream-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         | Example                                                                             |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `stream_id`                                                                         | *::String*                                                                          | :heavy_check_mark:                                                                  | Upon creating a new live stream, FastPix assigns a unique identifier to the stream. | your-stream-id                                                    |

### Response

**[T.nilable(Models::Operations::CompleteLiveStreamResponse)](../../models/operations/completelivestreamresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |