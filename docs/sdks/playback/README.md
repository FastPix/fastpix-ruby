# Playback
(*playback*)

## Overview

### Available Operations

* [create_media_playback_id](#create_media_playback_id) - Create a playback ID
* [delete_media_playback_id](#delete_media_playback_id) - Delete a playback ID
* [get_playback_id](#get_playback_id) - Get a playback ID

## create_media_playback_id

You can create a new playback ID for a specific media asset. If you have already retrieved an existing `playbackId` using the <a href="https://docs.fastpix.io/reference/get-media">Get Media by ID</a> endpoint for a media asset, you can use this endpoint to generate a new playback ID with a specified access policy. 



If you want to create a private playback ID for a media asset that already has a public playback ID, this endpoint also allows you to do so by specifying the desired access policy. 

#### How it works

1. Make a `POST` request to this endpoint, replacing `<mediaId>` with the `uploadId` or `id` of the media asset. 

2. Include the `accessPolicy` in the request body with `private` or `public` as the value. 

3. Receive a response containing the newly created playback ID with the requested access level. 


#### Example
A video streaming service generates playback IDs for each media file when users request to view specific content. The playback ID is then used by the video player to stream the video.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="create-media-playback-id" method="post" path="/on-demand/{mediaId}/playback-ids" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.playback.create_media_playback_id(media_id: 'dbb8a39a-e4a5-4120-9f22-22f603f1446e', request_body: Models::Operations::CreateMediaPlaybackIdRequestBody.new(
  access_policy: Models::Components::AccessPolicy::PUBLIC,
  drm_configuration_id: '123e4567-e89b-12d3-a456-426614174000',
  resolution: Models::Operations::Resolution::ONE_THOUSAND_AND_EIGHTYP,
))

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                      | Type                                                                                                                           | Required                                                                                                                       | Description                                                                                                                    | Example                                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------ |
| `media_id`                                                                                                                     | *::String*                                                                                                                     | :heavy_check_mark:                                                                                                             | When creating the media, FastPix assigns a universally unique identifier with a maximum length of 255 characters.              | dbb8a39a-e4a5-4120-9f22-22f603f1446e                                                                                           |
| `request_body`                                                                                                                 | [T.nilable(Models::Operations::CreateMediaPlaybackIdRequestBody)](../../models/operations/createmediaplaybackidrequestbody.md) | :heavy_minus_sign:                                                                                                             | Request body for creating playback id for an media                                                                             |                                                                                                                                |

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

This endpoint allows you to remove a specific playback ID associated with a media asset. Deleting a `playbackId` will revoke access to the media content linked to that ID. 


#### How it works

1. Make a `DELETE` request to this endpoint, replacing `<mediaId>` with the unique ID of the media asset from which you want to delete the playback ID. 

2. Specify the `playbackId` you wish to delete in the request body. 

#### Example

Your platform offers limited-time access to premium content. When the subscription expires, you can revoke access to the content by deleting the associated playback ID, preventing users from streaming the video further.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="delete-media-playback-id" method="delete" path="/on-demand/{mediaId}/playback-ids" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.playback.delete_media_playback_id(media_id: 'dbb8a39a-e4a5-4120-9f22-22f603f1446e', playback_id: 'dbb8a39a-e4a5-4120-9f22-22f603f1446e')

unless res.object.nil?
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

## get_playback_id

This endpoint retrieves details about a specific playback ID associated with a media asset. This endpoint is commonly used to check the access policy (e.g., public or private) with the specific playback ID.

**How it works:**
1. Make a GET request to the endpoint, replacing `{mediaId}` with the `id` of the media, and `{playbackId}` with the specific playback ID.
2. Useful for auditing or validation before granting playback access in your application.

**Example:**
A media platform might use this endpoint to verify if a playback ID is public or private before embedding the video in a frontend player or allowing access to a restricted group.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-playback-id" method="get" path="/on-demand/{mediaId}/playback-ids/{playbackId}" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.playback.get_playback_id(media_id: '4fa85f64-5717-4562-b3fc-2c963f66afa6', playback_id: '4fa85f64-5717-4562-b3fc-2c963f66afa6')

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                            | Type                                 | Required                             | Description                          | Example                              |
| ------------------------------------ | ------------------------------------ | ------------------------------------ | ------------------------------------ | ------------------------------------ |
| `media_id`                           | *::String*                           | :heavy_check_mark:                   | N/A                                  | 4fa85f64-5717-4562-b3fc-2c963f66afa6 |
| `playback_id`                        | *::String*                           | :heavy_check_mark:                   | N/A                                  | 4fa85f64-5717-4562-b3fc-2c963f66afa6 |

### Response

**[T.nilable(Models::Operations::GetPlaybackIdResponse)](../../models/operations/getplaybackidresponse.md)**

### Errors

| Error Type                                   | Status Code                                  | Content Type                                 |
| -------------------------------------------- | -------------------------------------------- | -------------------------------------------- |
| Models::Errors::InvalidPermissionError       | 401                                          | application/json                             |
| Models::Errors::ForbiddenError               | 403                                          | application/json                             |
| Models::Errors::MediaOrPlaybackNotFoundError | 404                                          | application/json                             |
| Models::Errors::ValidationErrorResponse      | 422                                          | application/json                             |
| Errors::APIError                             | 4XX, 5XX                                     | \*/\*                                        |