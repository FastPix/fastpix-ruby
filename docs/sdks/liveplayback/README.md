# LivePlayback
(*live_playback*)

## Overview

### Available Operations

* [create_playback_id_of_stream](#create_playback_id_of_stream) - Create a playbackId
* [delete_playback_id_of_stream](#delete_playback_id_of_stream) - Delete a playbackId
* [get_live_stream_playback_id](#get_live_stream_playback_id) - Get playbackId details

## create_playback_id_of_stream

Generates a new playback ID for the live stream, allowing viewers to access the stream through this ID. The playback ID can be shared with viewers for direct access to the live broadcast. 

  By calling this endpoint with the `streamId`, FastPix returns a unique `playbackId`, which can be used to stream the live content. 

  #### Example

  A media platform needs to distribute a unique playback ID to users for an exclusive live concert. The platform can also embed the stream on various partner websites.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="create-playbackId-of-stream" method="post" path="/live/streams/{streamId}/playback-ids" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.live_playback.create_playback_id_of_stream(stream_id: '8717422d89288ad5958d4a86e9afe2a2', playback_id_request: Models::Components::PlaybackIdRequest.new(
  access_policy: Models::Components::BasicAccessPolicy::PUBLIC,
))

unless res.playback_id_success_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         | Example                                                                             |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `stream_id`                                                                         | *::String*                                                                          | :heavy_check_mark:                                                                  | Upon creating a new live stream, FastPix assigns a unique identifier to the stream. | 8717422d89288ad5958d4a86e9afe2a2                                                    |
| `playback_id_request`                                                               | [Models::Components::PlaybackIdRequest](../../models/shared/playbackidrequest.md)   | :heavy_check_mark:                                                                  | N/A                                                                                 | {<br/>"accessPolicy": "public"<br/>}                                                |

### Response

**[T.nilable(Models::Operations::CreatePlaybackIdOfStreamResponse)](../../models/operations/createplaybackidofstreamresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::UnauthorizedError       | 401                                     | application/json                        |
| Models::Errors::InvalidPermissionError  | 403                                     | application/json                        |
| Models::Errors::LiveNotFoundError       | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |

## delete_playback_id_of_stream

Deletes a previously created playback ID for a live stream. This will prevent any new viewers from accessing the stream through the playback ID, though current viewers will be able to continue watching for a limited time before being disconnected. By providing the `playbackId`, FastPix deletes the ID and ensures new playback requests will fail. 

#### Example
A streaming service wants to prevent new users from joining a live stream that is nearing its end. The host can delete the playback ID to ensure no one can join the stream or replay it once it ends.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="delete-playbackId-of-stream" method="delete" path="/live/streams/{streamId}/playback-ids" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.live_playback.delete_playback_id_of_stream(stream_id: '8717422d89288ad5958d4a86e9afe2a2', playback_id: '88b7ac0f-2504-4dd5-b7b4-d84ab4fee1bd')

unless res.live_stream_delete_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         | Example                                                                             |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `stream_id`                                                                         | *::String*                                                                          | :heavy_check_mark:                                                                  | Upon creating a new live stream, FastPix assigns a unique identifier to the stream. | 8717422d89288ad5958d4a86e9afe2a2                                                    |
| `playback_id`                                                                       | *::String*                                                                          | :heavy_check_mark:                                                                  | Unique identifier for the playbackId                                                | 88b7ac0f-2504-4dd5-b7b4-d84ab4fee1bd                                                |

### Response

**[T.nilable(Models::Operations::DeletePlaybackIdOfStreamResponse)](../../models/operations/deleteplaybackidofstreamresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::UnauthorizedError       | 401                                     | application/json                        |
| Models::Errors::InvalidPermissionError  | 403                                     | application/json                        |
| Models::Errors::NotFoundErrorPlaybackId | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |

## get_live_stream_playback_id

Retrieves details about a previously created playback ID. If you provide the distinct `playbackId` that was given back to you in the previous stream or <a href="https://docs.fastpix.io/reference/create-playbackid-of-stream">create playbackId</a> request, FastPix will provide the relevant playback details such as the access policy. 

#### Example
A developer needs to confirm the access policy of the playback ID to ensure whether the stream is public or private for viewers.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-live-stream-playback-id" method="get" path="/live/streams/{streamId}/playback-ids/{playbackId}" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.live_playback.get_live_stream_playback_id(stream_id: '61a264dcc447b63da6fb79ef925cd76d', playback_id: '61a264dcc447b63da6fb79ef925cd76d')

unless res.playback_id_success_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                            | Type                                                                                 | Required                                                                             | Description                                                                          | Example                                                                              |
| ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------ |
| `stream_id`                                                                          | *::String*                                                                           | :heavy_check_mark:                                                                   | Upon creating a new live stream, FastPix assigns a unique identifier to the stream.  | 61a264dcc447b63da6fb79ef925cd76d                                                     |
| `playback_id`                                                                        | *::String*                                                                           | :heavy_check_mark:                                                                   | Upon creating a new playbackId, FastPix assigns a unique identifier to the playback. | 61a264dcc447b63da6fb79ef925cd76d                                                     |

### Response

**[T.nilable(Models::Operations::GetLiveStreamPlaybackIdResponse)](../../models/operations/getlivestreamplaybackidresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::UnauthorizedError       | 401                                     | application/json                        |
| Models::Errors::InvalidPermissionError  | 403                                     | application/json                        |
| Models::Errors::NotFoundErrorPlaybackId | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |