# ManageLiveStream
(*manage_live_stream*)

## Overview

### Available Operations

* [get_all_streams](#get_all_streams) - Get all live streams
* [get_live_stream_by_id](#get_live_stream_by_id) - Get stream by ID
* [delete_live_stream](#delete_live_stream) - Delete a stream
* [update_live_stream](#update_live_stream) - Update a stream

## get_all_streams

Retrieves a list of all live streams associated with the user’s account (workspace). It provides an overview of both current and past live streams, including details like streamId, title, status, and creation time. 

### Example Usage

```ruby
require 'fastpixapi'

s = ::FastpixApiSDK::SDK.new(
      security: Models::Components::Security.new(
        username: '',
        password: '',
      ),
    )

res = s.manage_live_stream.get_all_streams(limit='20', offset='1', order_by=Models::Operations::GetAllStreamsOrderBy::DESC)

if ! res.get_streams_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                           | Type                                                                                                                                | Required                                                                                                                            | Description                                                                                                                         | Example                                                                                                                             |
| ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------- |
| `limit`                                                                                                                             | *T.nilable(::String)*                                                                                                               | :heavy_minus_sign:                                                                                                                  | Limit specifies the maximum number of items to display per page.                                                                    | 20                                                                                                                                  |
| `offset`                                                                                                                            | *T.nilable(::String)*                                                                                                               | :heavy_minus_sign:                                                                                                                  | Offset determines the starting point for data retrieval within a paginated list.                                                    | 1                                                                                                                                   |
| `order_by`                                                                                                                          | [T.nilable(Models::Operations::GetAllStreamsOrderBy)](../../models/operations/getallstreamsorderby.md)                              | :heavy_minus_sign:                                                                                                                  | The list of value can be order in two ways DESC (Descending) or ASC (Ascending). In case not specified, by default it will be DESC. | desc                                                                                                                                |

### Response

**[T.nilable(Models::Operations::GetAllStreamsResponse)](../../models/operations/getallstreamsresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::UnauthorizedError       | 401                                     | application/json                        |
| Models::Errors::InvalidPermissionError  | 403                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |

## get_live_stream_by_id

This endpoint retrieves detailed information about a specific live stream by its unique streamId. It includes data such as the stream’s status (idle, preparing, active, disabled), metadata (title, description), and more. 

  **Practical example:** Suppose a news agency is broadcasting a live event and wants to track the configurations set for the live stream while also checking the stream's status.

### Example Usage

```ruby
require 'fastpixapi'

s = ::FastpixApiSDK::SDK.new(
      security: Models::Components::Security.new(
        username: '',
        password: '',
      ),
    )

res = s.manage_live_stream.get_live_stream_by_id(stream_id='61a264dcc447b63da6fb79ef925cd76d')

if ! res.livestreamget_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         | Example                                                                             |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `stream_id`                                                                         | *::String*                                                                          | :heavy_check_mark:                                                                  | Upon creating a new live stream, FastPix assigns a unique identifier to the stream. | 61a264dcc447b63da6fb79ef925cd76d                                                    |

### Response

**[T.nilable(Models::Operations::GetLiveStreamByIdResponse)](../../models/operations/getlivestreambyidresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::UnauthorizedError       | 401                                     | application/json                        |
| Models::Errors::InvalidPermissionError  | 403                                     | application/json                        |
| Models::Errors::NotFoundError           | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |

## delete_live_stream

Permanently removes a specified live stream from the workspace. If the stream is still active, the encoder will be disconnected, and the ingestion will stop. This action cannot be undone, and any future playback attempts will fail. 

  By providing the streamId, the API will terminate any active connections to the stream and remove it from the list of available live streams. You can further look for video.live_stream.deleted webhook to notify your system about the status. 

  **Example:** For an online concert platform, a trial stream was mistakenly made public. The event manager deletes the stream before the concert begins to avoid confusion among viewers. 

### Example Usage

```ruby
require 'fastpixapi'

s = ::FastpixApiSDK::SDK.new(
      security: Models::Components::Security.new(
        username: '',
        password: '',
      ),
    )

res = s.manage_live_stream.delete_live_stream(stream_id='8717422d89288ad5958d4a86e9afe2a2')

if ! res.live_stream_delete_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         | Example                                                                             |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `stream_id`                                                                         | *::String*                                                                          | :heavy_check_mark:                                                                  | Upon creating a new live stream, FastPix assigns a unique identifier to the stream. | 8717422d89288ad5958d4a86e9afe2a2                                                    |

### Response

**[T.nilable(Models::Operations::DeleteLiveStreamResponse)](../../models/operations/deletelivestreamresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::UnauthorizedError       | 401                                     | application/json                        |
| Models::Errors::InvalidPermissionError  | 403                                     | application/json                        |
| Models::Errors::NotFoundError           | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |

## update_live_stream

This endpoint allows users to modify the parameters of an existing live stream, such as its metadata (title, description) or the reconnect window. It’s useful for making changes to a stream that has already been created but not yet ended. Once the live stream is disabled, you cannot update a stream. 


  The updated stream parameters and the streamId needs to be shared in the request, and FastPix will return the updated stream details. Once updated, video.live_stream.updated webhook event notifies your system. 

  **Practical example:** A host realizes they need to extend the reconnect window for their live stream in case they lose connection temporarily during the event. Or suppose during a multi-day online conference, the event organizers need to update the stream title to reflect the next day's session while keeping the same stream ID for continuity. 

### Example Usage

```ruby
require 'fastpixapi'

s = ::FastpixApiSDK::SDK.new(
      security: Models::Components::Security.new(
        username: '',
        password: '',
      ),
    )

res = s.manage_live_stream.update_live_stream(stream_id='91a264dcc447b63da6fb79ef925cd76d', patch_live_stream_request=Models::Components::PatchLiveStreamRequest.new(
  metadata: Models::Components::PatchLiveStreamRequestMetadata.new(),
  reconnect_window: 100,
))

if ! res.patch_response_dto.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                              | Type                                                                                                   | Required                                                                                               | Description                                                                                            | Example                                                                                                |
| ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------ |
| `stream_id`                                                                                            | *::String*                                                                                             | :heavy_check_mark:                                                                                     | Upon creating a new live stream, FastPix assigns a unique identifier to the stream.                    | 91a264dcc447b63da6fb79ef925cd76d                                                                       |
| `patch_live_stream_request`                                                                            | [T.nilable(Models::Components::PatchLiveStreamRequest)](../../models/shared/patchlivestreamrequest.md) | :heavy_minus_sign:                                                                                     | N/A                                                                                                    | {<br/>"metadata": {<br/>"livestream_name": "Gaming_stream"<br/>},<br/>"reconnectWindow": 100<br/>}     |

### Response

**[T.nilable(Models::Operations::UpdateLiveStreamResponse)](../../models/operations/updatelivestreamresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::UnauthorizedError       | 401                                     | application/json                        |
| Models::Errors::InvalidPermissionError  | 403                                     | application/json                        |
| Models::Errors::NotFoundError           | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |