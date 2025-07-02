# Playback
(*playback*)

## Overview

### Available Operations

* [create_playback_id_of_stream](#create_playback_id_of_stream) - Create a playbackId
* [delete_playback_id_of_stream](#delete_playback_id_of_stream) - Delete a playbackId
* [get_live_stream_playback_id](#get_live_stream_playback_id) - Get stream's playbackId
* [create_media_playback_id](#create_media_playback_id) - Create a playback ID
* [delete_media_playback_id](#delete_media_playback_id) - Delete a playback ID

## create_playback_id_of_stream

Generates a new playback ID for the live stream, allowing viewers to access the stream through this ID. The playback ID can be shared with viewers for direct access to the live broadcast. 

  By calling this endpoint with the streamId, FastPix returns a unique playbackId, which can be used to stream the live content. 

  **Use case:** A media platform needs to distribute a unique playback ID to users for an exclusive live concert. The platform can also embed the stream on various partner websites. 

### Example Usage

```ruby
require 'fastpixapi'

s = ::FastpixApiSDK::SDK.new(
      security: Models::Components::Security.new(
        username: '',
        password: '',
      ),
    )

res = s.playback.create_playback_id_of_stream(stream_id='8717422d89288ad5958d4a86e9afe2a2', playback_id_request=Models::Components::PlaybackIdRequest.new())

if ! res.playback_id_response.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                    | Type                                                                                         | Required                                                                                     | Description                                                                                  | Example                                                                                      |
| -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| `stream_id`                                                                                  | *::String*                                                                                   | :heavy_check_mark:                                                                           | Upon creating a new live stream, FastPix assigns a unique identifier to the stream.          | 8717422d89288ad5958d4a86e9afe2a2                                                             |
| `playback_id_request`                                                                        | [T.nilable(Models::Components::PlaybackIdRequest)](../../models/shared/playbackidrequest.md) | :heavy_minus_sign:                                                                           | N/A                                                                                          | {<br/>"accessPolicy": "public"<br/>}                                                         |

### Response

**[T.nilable(Models::Operations::CreatePlaybackIdOfStreamResponse)](../../models/operations/createplaybackidofstreamresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::UnauthorizedError       | 401                                     | application/json                        |
| Models::Errors::InvalidPermissionError  | 403                                     | application/json                        |
| Models::Errors::NotFoundError           | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |

## delete_playback_id_of_stream

Deletes a previously created playback ID for a live stream. This will prevent any new viewers from accessing the stream through the playback ID, though current viewers will be able to continue watching for a limited time before being disconnected. By providing the playbackId, FastPix deletes the ID and ensures new playback requests will fail. 

  **Use case:** A streaming service wants to prevent new users from joining a live stream that is nearing its end. The host can delete the playback ID to ensure no one can join the stream or replay it once it ends. 

### Example Usage

```ruby
require 'fastpixapi'

s = ::FastpixApiSDK::SDK.new(
      security: Models::Components::Security.new(
        username: '',
        password: '',
      ),
    )

res = s.playback.delete_playback_id_of_stream(stream_id='8717422d89288ad5958d4a86e9afe2a2', playback_id='88b7ac0f-2504-4dd5-b7b4-d84ab4fee1bd')

if ! res.live_stream_delete_response.nil?
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

Retrieves details about a previously created playback ID. If you provide the distinct playback ID that was given back to you in the previous stream or playbackId create request, FastPix will provide the relevant playback details such as the access policy. 

  **Use case:** A developer needs to confirm the playback ID details to ensure the right stream is being accessed by viewers. 

### Example Usage

```ruby
require 'fastpixapi'

s = ::FastpixApiSDK::SDK.new(
      security: Models::Components::Security.new(
        username: '',
        password: '',
      ),
    )

res = s.playback.get_live_stream_playback_id(stream_id='61a264dcc447b63da6fb79ef925cd76d', playback_id='61a264dcc447b63da6fb79ef925cd76d')

if ! res.playback_id_response.nil?
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

## create_media_playback_id

You can create a new playback ID for a specific media asset. If you have already retrieved an existing playbackId using the "Get Media by ID" endpoint for a media asset, you can use this endpoint to generate a new playback ID with a specified access policy. 



If you want to create a private playback ID for a media asset that already has a public playback ID, this endpoint also allows you to do so by specifying the desired access policy. 

#### How it works

1. **Make a POST request** to the **/on-demand/`<mediaId>`/playback-ids** endpoint, replacing `<mediaId>` with the uploadId or id of the media asset. 

2. Include the **access policy** in the request body to indicate whether the new playback ID should be private or public. 

3. Receive a response containing the newly created playback ID with the requested access level. 


**Use case:** A video streaming service generates playback IDs for each media file when users request to view specific content. The playback ID is then used by the video player to stream the video.


### Example Usage

```ruby
require 'fastpixapi'

s = ::FastpixApiSDK::SDK.new(
      security: Models::Components::Security.new(
        username: '',
        password: '',
      ),
    )

res = s.playback.create_media_playback_id(media_id='dbb8a39a-e4a5-4120-9f22-22f603f1446e', request_body=Models::Operations::CreateMediaPlaybackIdRequestBody.new(
  access_policy: Models::Operations::CreateMediaPlaybackIdAccessPolicy::PUBLIC,
))

if ! res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                      | Type                                                                                                                           | Required                                                                                                                       | Description                                                                                                                    | Example                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| `media_id`                                                                                                                     | *::String*                                                                                                                     | :heavy_check_mark:                                                                                                             | When creating the media, FastPix assigns a universally unique identifier with a maximum length of 255 characters.              | dbb8a39a-e4a5-4120-9f22-22f603f1446e                                                                                           |
| `request_body`                                                                                                                 | [T.nilable(Models::Operations::CreateMediaPlaybackIdRequestBody)](../../models/operations/createmediaplaybackidrequestbody.md) | :heavy_minus_sign:                                                                                                             | Request body for creating playback id for an media                                                                             | {<br/>"accessPolicy": "public"<br/>}                                                                                           |

### Response

**[T.nilable(Models::Operations::CreateMediaPlaybackIdResponse)](../../models/operations/createmediaplaybackidresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::InvalidPermissionError  | 401                                     | application/json                        |
| Models::Errors::ForbiddenError          | 403                                     | application/json                        |
| Models::Errors::MediaNotFoundError      | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |

## delete_media_playback_id

This endpoint allows you to remove a specific playback ID associated with a media asset. Deleting a playbackId will revoke access to the media content linked to that ID. 


#### How it works

1. Make a DELETE request to the **/on-demand/`<mediaId>`/playback-ids** endpoint, replacing `<mediaId>` with the uploadId or id of the media asset from which you want to delete the playback ID. 

2. Specify the playback ID you wish to delete in the request body. 

**Use case:** Your platform offers limited-time access to premium content. When the subscription expires, you can revoke access to the content by deleting the associated playback ID, preventing users from streaming the video further. 


### Example Usage

```ruby
require 'fastpixapi'

s = ::FastpixApiSDK::SDK.new(
      security: Models::Components::Security.new(
        username: '',
        password: '',
      ),
    )

res = s.playback.delete_media_playback_id(media_id='dbb8a39a-e4a5-4120-9f22-22f603f1446e', playback_id='dbb8a39a-e4a5-4120-9f22-22f603f1446e')

if ! res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                             | Type                                                                                                  | Required                                                                                              | Description                                                                                           | Example                                                                                               |
| ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                            | *::String*                                                                                            | :heavy_check_mark:                                                                                    | Return the universal unique identifier for media which can contain a maximum of 255 characters.       | dbb8a39a-e4a5-4120-9f22-22f603f1446e                                                                  |
| `playback_id`                                                                                         | *::String*                                                                                            | :heavy_check_mark:                                                                                    | Return the universal unique identifier for playbacks  which can contain a maximum of 255 characters.  | dbb8a39a-e4a5-4120-9f22-22f603f1446e                                                                  |

### Response

**[T.nilable(Models::Operations::DeleteMediaPlaybackIdResponse)](../../models/operations/deletemediaplaybackidresponse.md)**

### Errors

| Error Type                                   | Status Code                                  | Content Type                                 |
| -------------------------------------------- | -------------------------------------------- | -------------------------------------------- |
| Models::Errors::InvalidPermissionError       | 401                                          | application/json                             |
| Models::Errors::ForbiddenError               | 403                                          | application/json                             |
| Models::Errors::MediaOrPlaybackNotFoundError | 404                                          | application/json                             |
| Models::Errors::ValidationErrorResponse      | 422                                          | application/json                             |
| Errors::APIError                             | 4XX, 5XX                                     | \*/\*                                        |