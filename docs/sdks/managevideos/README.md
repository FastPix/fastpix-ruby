# ManageVideos

## Overview

Operations for managing video media

### Available Operations

* [list_media](#list_media) - Get list of all media
* [list_live_clips](#list_live_clips) - Get all clips of a live stream
* [get_media](#get_media) - Get a media by ID
* [updated_media](#updated_media) - Update a media by ID
* [delete_media](#delete_media) - Delete a media by ID
* [add_media_track](#add_media_track) - Add audio / subtitle track
* [cancel_upload](#cancel_upload) - Cancel ongoing upload
* [update_media_track](#update_media_track) - Update audio / subtitle track
* [delete_media_track](#delete_media_track) - Delete audio / subtitle track
* [generate_subtitle_track](#generate_subtitle_track) - Generate track subtitle
* [get_media_summary](#get_media_summary) - Get the summary of a video
* [updated_source_access](#updated_source_access) - Update the source access of a media by ID
* [updated_mp4_support](#updated_mp4_support) - Update the mp4Support of a media by ID
* [retrieve_media_input_info](#retrieve_media_input_info) - Get info of media inputs
* [list_uploads](#list_uploads) - Get all unused upload URLs
* [get_media_clips](#get_media_clips) - Get all clips of a media

## list_media

This endpoint returns a list of all media files uploaded to FastPix within a specific workspace. Each media entry contains data such as the media `id`, `createdAt`, `status`, `type` and more. It allows you to retrieve an overview of your media assets, making it easier to manage and review them. 


#### How it works

Use the access token and secret key related to the workspace in the request header. When called, the API provides a paginated response containing all the media items in that specific workspace. This is helpful for retrieving a large volume of media and managing content in bulk. 



#### Example
If you manage a video platform and need to review all uploaded media in your library to ensure that outdated or low-quality content isn’t being served, you can use this endpoint to retrieve a complete list of media. You can then filter, sort, or update items as needed.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="list-media" method="get" path="/on-demand" -->
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

res = s.manage_videos.list_media(limit: 20, offset: 1, order_by: Models::Components::SortOrder::DESC)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               | Example                                                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `limit`                                                                                   | *T.nilable(::Integer)*                                                                    | :heavy_minus_sign:                                                                        | Limit specifies the maximum number of items to display per page.                          | 20                                                                                        |
| `offset`                                                                                  | *T.nilable(::Integer)*                                                                    | :heavy_minus_sign:                                                                        | Offset determines the starting point for data retrieval within a paginated list.          | 1                                                                                         |
| `order_by`                                                                                | [T.nilable(Models::Components::SortOrder)](../../models/shared/sortorder.md)              | :heavy_minus_sign:                                                                        | The values in the list can be arranged in two ways: DESC (Descending) or ASC (Ascending). | desc                                                                                      |

### Response

**[T.nilable(Models::Operations::ListMediaResponse)](../../models/operations/listmediaresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## list_live_clips

Retrieves a list of all media clips generated from a specific livestream. Each media entry includes metadata such as the clip media IDs, and other relevant details. A media clip is a segmented portion of an original media file (source live stream). Clips are often created for various purposes such as previews, highlights, or customized edits.
#### How it works
1. Provide the livestreamId as a parameter when calling this endpoint.

2. The API returns a paginated list of media clips created from the specified livestream.

3. Pagination helps maintain performance and usability when handling large sets of media files, making it easier to organize and manage content in bulk.

#### Use case
Suppose you’re hosting a live gaming event and want to showcase key moments from the stream — such as top plays or final match highlights. You can use this endpoint to fetch all clips generated from that livestream, display them in your dashboard, or use them for post-event editing and sharing.

Related guide: <a href="https://fastpix.com/docs/live-streaming/clip-moments-from-a-live-stream">Instant live clipping</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="list-live-clips" method="get" path="/on-demand/{livestreamId}/live-clips" -->
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

res = s.manage_videos.list_live_clips(livestream_id: 'your-livestream-id', limit: 20, offset: 1, order_by: Models::Components::SortOrder::DESC)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               | Example                                                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `livestream_id`                                                                           | *::String*                                                                                | :heavy_check_mark:                                                                        | The stream Id is unique identifier assigned to the live stream.                           | your-livestream-id                                                          |
| `limit`                                                                                   | *T.nilable(::Integer)*                                                                    | :heavy_minus_sign:                                                                        | Limit specifies the maximum number of items to display per page.                          | 20                                                                                        |
| `offset`                                                                                  | *T.nilable(::Integer)*                                                                    | :heavy_minus_sign:                                                                        | Offset determines the starting point for data retrieval within a paginated list.          | 1                                                                                         |
| `order_by`                                                                                | [T.nilable(Models::Components::SortOrder)](../../models/shared/sortorder.md)              | :heavy_minus_sign:                                                                        | The values in the list can be arranged in two ways: DESC (Descending) or ASC (Ascending). | desc                                                                                      |

### Response

**[T.nilable(Models::Operations::ListLiveClipsResponse)](../../models/operations/listliveclipsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## get_media

By calling this endpoint, you can retrieve detailed information about a specific media item, including its current `status` and a `playbackId`. This is particularly useful for retrieving specific media details when managing large content libraries. 



#### How it works

1. Send a GET request to this endpoint. Use the `<mediaId>` you received after uploading the media file.

2. The response includes details about the media:
   - **status** – Indicates whether the media is still *Processing* or has transitioned to *Ready*.
   - **playbackId** – A unique identifier that allows you to stream the media once it is *Ready*.  
     You can construct the stream URL as follows:  
     `https://stream.fastpix.com/<playbackId>.m3u8`

#### Example

If your platform provides users with a dashboard to manage uploaded content, a user might want to check whether a video has finished processing and is ready for playback. You can use the media ID to retrieve the information from FastPix and display it in the user’s dashboard.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-media" method="get" path="/on-demand/{mediaId}" -->
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

res = s.manage_videos.get_media(media_id: 'your-media-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               | Example                                                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `media_id`                                                                                | *::String*                                                                                | :heavy_check_mark:                                                                        | The unique identifier assigned to the media when created. The value must be a valid UUID. | your-media-id                                                      |

### Response

**[T.nilable(Models::Operations::GetMediaDetailResponse)](../../models/operations/getmediadetailresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## updated_media

This endpoint allows you to update specific parameters of an existing media file. You can modify the key-value pairs of the metadata that were provided in the payload during the creation of media from a URL or when uploading the media directly from device. 


#### How it works

1. Make a PATCH request to this endpoint. Replace `<mediaId>` with the unique ID (`uploadId` or `id`) of the media you received after uploading to FastPix

2. Include the updated parameters in the request body.

3. The response returns the updated media data, confirming the changes. 

4. Monitor the <a href="https://fastpix.com/docs/webhooks/media-events#videomediaupdated">video.media.updated</a> webhook event to track the update status in your system.

#### Example
If a user uploads a video and later needs to change the title, add a new description, or update tags, you can use this endpoint to update the media metadata without re-uploading the entire video.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="updated-media" method="patch" path="/on-demand/{mediaId}" -->
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

res = s.manage_videos.updated_media(media_id: 'your-media-id', body: Models::Operations::UpdatedMediaRequestBody.new(
  metadata: {
    "user": 'fastpix_admin',
  },
  title: 'test title',
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

| Parameter                                                                                         | Type                                                                                              | Required                                                                                          | Description                                                                                       | Example                                                                                           |
| ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                        | *::String*                                                                                        | :heavy_check_mark:                                                                                | The unique identifier assigned to the media when created. The value must be a valid UUID.         | your-media-id                                                              |
| `body`                                                                                            | [Models::Operations::UpdatedMediaRequestBody](../../models/operations/updatedmediarequestbody.md) | :heavy_check_mark:                                                                                | N/A                                                                                               |                                                                                                   |

### Response

**[T.nilable(Models::Operations::UpdatedMediaResponse)](../../models/operations/updatedmediaresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## delete_media

This endpoint allows you to permanently delete a a specific video or audio media file along with all associated data. If you wish to remove a media from FastPix storage, use this endpoint with the `mediaId` (either `uploadId` or `id`) received during the media's creation or upload. 


#### How it works


1. Send a DELETE request to this endpoint. Replace `<mediaId>` with the `uploadId` or the `id` of the media you want to delete. 

2. This action is irreversible. Make sure you no longer need the media before proceeding. Once deleted, the media can’t be retrieved or played back. 

3. Monitor the following webhook event: <a href="https://fastpix.com/docs/webhooks/media-events#videomediadeleted">video.media.deleted</a>

#### Example
A user on a video-sharing platform decides to remove an old video from their profile, or suppose you're running a content moderation system, and one of the videos uploaded by a user violates your platform's policies. Using this endpoint, the media is permanently deleted from your library, ensuring it's no longer accessible or viewable by other users.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="delete-media" method="delete" path="/on-demand/{mediaId}" -->
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

res = s.manage_videos.delete_media(media_id: 'your-media-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               | Example                                                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `media_id`                                                                                | *::String*                                                                                | :heavy_check_mark:                                                                        | The unique identifier assigned to the media when created. The value must be a valid UUID. | your-media-id                                                      |

### Response

**[T.nilable(Models::Operations::DeleteMediaResponse)](../../models/operations/deletemediaresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## add_media_track

This endpoint allows you to add an audio or subtitle track to an existing media file using its `mediaId`. You need to provide the track `url` along with its `type` (audio or subtitle), `languageName` and `languageCode` in the request payload.


#### How it works

1. Send a POST request to this endpoint, replacing `{mediaId}` with the media ID (`uploadId` or `id`).

2. Provide the necessary details in the request body.

3. Receive a response containing a unique track ID and the details of the newly added track.


#### Webhook events

1. After successfully adding a track, your system must receive the webhook event <a href="https://fastpix.com/docs/webhooks/transform-media-events#videomediatrackcreated">video.media.track.created</a>.

2. Once the track is processed and ready, you must receive the webhook event <a href="https://fastpix.com/docs/webhooks/transform-media-events#videomediatrackready">video.media.track.ready</a>.

3. Finally, an update event <a href="https://fastpix.com/docs/webhooks/media-events#videomediaupdated">video.media.updated</a> must notify your system about the media's updated status.


#### Example
Suppose you have a video uploaded to the FastPix platform, and you want to add an Italian audio track to it. By calling this API, you can attach an external audio file (https://static.fastpix.com/music-1.mp3) to the media file. Similarly, if you need to add subtitles in different languages, you can specify type: `subtitle` with the corresponding subtitle `url`, `languageCode` and `languageName`.

Related guides: <a href="https://fastpix.com/docs/video-on-demand/add-subtitles-to-a-video">Add own subtitle tracks</a>, <a href="https://fastpix.com/docs/video-on-demand/add-audio-to-a-video">Add own audio tracks</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="Add-media-track" method="post" path="/on-demand/{mediaId}/tracks" -->
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

res = s.manage_videos.add_media_track(media_id: 'your-media-id', body: Models::Operations::AddMediaTrackRequestBody.new(
  tracks: Models::Components::AddTrackRequest.new(),
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

| Parameter                                                                                           | Type                                                                                                | Required                                                                                            | Description                                                                                         | Example                                                                                             |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                          | *::String*                                                                                          | :heavy_check_mark:                                                                                  | The unique identifier assigned to the media when created. The value must be a valid UUID.           | your-media-id                                                                |
| `body`                                                                                              | [Models::Operations::AddMediaTrackRequestBody](../../models/operations/addmediatrackrequestbody.md) | :heavy_check_mark:                                                                                  | N/A                                                                                                 |                                                                                                     |

### Response

**[T.nilable(Models::Operations::AddMediaTrackResponse)](../../models/operations/addmediatrackresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## cancel_upload

This endpoint allows you to cancel ongoing upload by its `uploadId`. Once cancelled, the upload is marked as cancelled. Use this if a user aborts an upload or if you want to programmatically stop an in-progress upload.

#### How it works

1. Make a PUT request to this endpoint, replacing `{uploadId}` with the unique upload ID received after starting the upload.
2. The response confirms the cancellation and provide the status of the upload.

#### Webhook Events

Once the upload is cancelled, you must receive the webhook event <a href="https://fastpix.com/docs/webhooks/media-events#videomediauploadcancelled">video.media.upload.cancelled</a>.

#### Example

Suppose a user starts uploading a large video file but decides to cancel before completion. By calling this API, you can immediately stop the upload and free up resources.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="cancel-upload" method="put" path="/on-demand/upload/{uploadId}/cancel" -->
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

res = s.manage_videos.cancel_upload(upload_id: 'your-upload-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                          | Type                                                                                                               | Required                                                                                                           | Description                                                                                                        | Example                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| `upload_id`                                                                                                        | *::String*                                                                                                         | :heavy_check_mark:                                                                                                 | When uploading the media, FastPix assigns a universally unique identifier with a maximum length of 255 characters. | your-upload-id                                                                               |

### Response

**[T.nilable(Models::Operations::CancelUploadResponse)](../../models/operations/canceluploadresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## update_media_track

This endpoint allows you to update an existing audio or subtitle track associated with a media file. When updating a track, you must provide the new track `url`, `languageName`, and `languageCode`, ensuring all three parameters are included in the request.


#### How it works

1. Send a PATCH request to this endpoint, replacing `{mediaId}` with the media ID, and `{trackId}` with the ID of the track you want to update.

2. Provide the necessary details in the request body.

3. Receive a response confirming the track update.

#### Webhook Events

After updating a track, your system must receive webhook notifications:

1. After successfully updating a track, your system must receive the webhook event <a href="https://fastpix.com/docs/webhooks/transform-media-events#videomediatrackupdated">video.media.track.updated</a>.

2. Once the new track is processed and ready, you must receive the webhook event <a href="https://fastpix.com/docs/webhooks/transform-media-events#videomediatrackready">video.media.track.ready</a>.

3. Once the media file is updated with the new track details, a <a href="https://fastpix.com/docs/webhooks/media-events#videomediaupdated">video.media.updated</a> event must be triggered.


#### Example
Suppose you previously added a French subtitle track to a video but now need to update it with a different file. By calling this API, you can replace the existing subtitle file (.vtt) with a new one while keeping the same track ID. This is useful when:

  - The original track file has errors and needs correction.
  - You want to improve subtitle translations or replace an audio track with a better-quality version.

Related guides: <a href="https://fastpix.com/docs/video-on-demand/add-subtitles-to-a-video">Add own subtitle tracks</a>, <a href="https://fastpix.com/docs/video-on-demand/add-audio-to-a-video">Add own audio tracks</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-media-track" method="patch" path="/on-demand/{mediaId}/tracks/{trackId}" -->
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

res = s.manage_videos.update_media_track(track_id: 'your-track-id', media_id: 'your-media-id', body: Models::Components::UpdateTrackRequest.new(
  language_name: 'french',
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

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               | Example                                                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `track_id`                                                                                | *::String*                                                                                | :heavy_check_mark:                                                                        | The unique identifier assigned to the track. The value must be a valid UUID. | your-track-id                                                      |
| `media_id`                                                                                | *::String*                                                                                | :heavy_check_mark:                                                                        | The unique identifier assigned to the media when created. The value must be a valid UUID. | your-media-id                                                      |
| `body`                                                                                    | [Models::Components::UpdateTrackRequest](../../models/shared/updatetrackrequest.md)       | :heavy_check_mark:                                                                        | N/A                                                                                       |                                                                                           |

### Response

**[T.nilable(Models::Operations::UpdateMediaTrackResponse)](../../models/operations/updatemediatrackresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## delete_media_track

This endpoint allows you to delete an existing audio or subtitle track from a media file. Once deleted, the track must no longer be available for playback.


#### How it works


1. Send a DELETE request to this endpoint, replacing `{mediaId}` with the media ID, and `{trackId}` with the ID of the track you want to remove.

2. The track gets deleted from the media file, and you must receive a confirmation response.

#### Webhook events

1. After successfully deleting a track, your system must receive the webhook event **video.media.track.deleted**.

2. Once the media file is updated to reflect the track removal, a <a href="https://fastpix.com/docs/webhooks/media-events#videomediaupdated">video.media.updated</a> event must be triggered.

#### Example
Suppose you uploaded an audio track in Italian for a video but later realize it's incorrect or no longer needed. By calling this API, you can remove the specific track while keeping the rest of the media file unchanged. This is useful when:

  - A track was mistakenly added and needs to be removed.
  - The content owner requests the removal of a specific subtitle or audio track.
  - A new version of the track gets uploaded to replace the existing one.

Related guides: <a href="https://fastpix.com/docs/video-on-demand/add-subtitles-to-a-video">Add own subtitle tracks</a>, <a href="https://fastpix.com/docs/video-on-demand/add-audio-to-a-video">Add own audio tracks</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="delete-media-track" method="delete" path="/on-demand/{mediaId}/tracks/{trackId}" -->
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

res = s.manage_videos.delete_media_track(media_id: 'your-media-id', track_id: 'your-track-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               | Example                                                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `media_id`                                                                                | *::String*                                                                                | :heavy_check_mark:                                                                        | The unique identifier assigned to the media when created. The value must be a valid UUID. | your-media-id                                                      |
| `track_id`                                                                                | *::String*                                                                                | :heavy_check_mark:                                                                        | The unique identifier assigned to the track. The value must be a valid UUID. | your-track-id                                                      |

### Response

**[T.nilable(Models::Operations::DeleteMediaTrackResponse)](../../models/operations/deletemediatrackresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## generate_subtitle_track

This endpoint allows you to generate subtitles for an existing audio track in a media file. By calling this API, you can generate subtitles automatically using speech recognition

#### How it works

1. Send a `POST` request to this endpoint, replacing `{mediaId}` with the media ID and `{trackId}` with the track ID.

2. Provide the necessary details in the request body, including the languageName and languageCode.

3. You receive a response containing a unique subtitle track ID and its details.

#### Webhook Events

1. After the subtitle track is generated and ready, you receive the webhook event <a href="https://fastpix.com/docs/webhooks/transform-media-events#videomediasubtitlegenerated">video.media.subtitle.generated</a>.

2. Finally the <a href="https://fastpix.com/docs/webhooks/media-events#videomediaupdated">video.media.updated</a> event notifies your system about the media’s updated status.

</br> Related guide: <a href="https://fastpix.com/docs/video-on-demand/generate-subtitles-automatically">Add auto-generated subtitles</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="Generate-subtitle-track" method="post" path="/on-demand/{mediaId}/tracks/{trackId}/generate-subtitles" -->
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

res = s.manage_videos.generate_subtitle_track(media_id: 'your-media-id', track_id: 'your-track-id', body: Models::Components::TrackSubtitlesGenerateRequest.new(
  language_name: 'Italian',
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

| Parameter                                                                                                    | Type                                                                                                         | Required                                                                                                     | Description                                                                                                  | Example                                                                                                      |
| ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------ |
| `media_id`                                                                                                   | *::String*                                                                                                   | :heavy_check_mark:                                                                                           | The unique identifier assigned to the media when created. The value must be a valid UUID.                    | your-media-id                                                                         |
| `track_id`                                                                                                   | *::String*                                                                                                   | :heavy_check_mark:                                                                                           | A universally unique identifier (UUID) assigned to the specific track for which subtitles must be generated. | your-track-id                                                                         |
| `body`                                                                                                       | [Models::Components::TrackSubtitlesGenerateRequest](../../models/shared/tracksubtitlesgeneraterequest.md)    | :heavy_check_mark:                                                                                           | N/A                                                                                                          |                                                                                                              |

### Response

**[T.nilable(Models::Operations::GenerateSubtitleTrackResponse)](../../models/operations/generatesubtitletrackresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## get_media_summary

This endpoint returns the generated summary of a video.  

The summary is created using the **InVideo Summary** feature, which processes the video content and produces a textual summary.  

To use this endpoint, you must first generate the video summary using the Generate Video Summary endpoint. This endpoint can return the summary only after that process is complete. 

Typical use cases include:  
- Providing viewers with a quick preview of the video's main content.  
- Enabling search or recommendation systems to surface summarized insights.  
- Supporting accessibility and content discovery without requiring users to watch the full video.  

If the summary has not been generated or the feature is disabled for the requested media, the endpoint returns an error indicating that the summary is unavailable. 


### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-media-summary" method="get" path="/on-demand/{mediaId}/summary" -->
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

res = s.manage_videos.get_media_summary(media_id: 'your-media-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               | Example                                                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `media_id`                                                                                | *::String*                                                                                | :heavy_check_mark:                                                                        | The unique identifier assigned to the media when created. The value must be a valid UUID. | your-media-id                                                      |

### Response

**[T.nilable(Models::Operations::GetMediaSummaryResponse)](../../models/operations/getmediasummaryresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## updated_source_access

This endpoint allows you to update the `sourceAccess` setting of an existing media file. The `sourceAccess` parameter determines whether the original media file is accessible or restricted. Setting this to `true` enables access to the media source, while setting it to `false` restricts access. 

#### How it works

1. Make a `PATCH` request to this endpoint, replacing `{mediaId}` with the ID of the media you want to update.

2. Include the updated `sourceAccess` parameter in the request body.

3. You receive a response confirming the update to the media’s source access status.
4. Webhook events: <a href="https://fastpix.com/docs/webhooks/transform-media-events#videomediasourceready">video.media.source.ready</a>, <a href="https://fastpix.com/docs/webhooks/transform-media-events#videomediasourcedeleted">video.media.source.deleted</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="updated-source-access" method="patch" path="/on-demand/{mediaId}/source-access" -->
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

res = s.manage_videos.updated_source_access(media_id: 'your-media-id', body: Models::Operations::UpdatedSourceAccessRequestBody.new(
  source_access: true,
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

| Parameter                                                                                                       | Type                                                                                                            | Required                                                                                                        | Description                                                                                                     | Example                                                                                                         |
| --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                                      | *::String*                                                                                                      | :heavy_check_mark:                                                                                              | The unique identifier assigned to the media when created. The value must be a valid UUID.<br/>                  | your-media-id                                                                            |
| `body`                                                                                                          | [Models::Operations::UpdatedSourceAccessRequestBody](../../models/operations/updatedsourceaccessrequestbody.md) | :heavy_check_mark:                                                                                              | N/A                                                                                                             | {<br/>"sourceAccess": true<br/>}                                                                                |

### Response

**[T.nilable(Models::Operations::UpdatedSourceAccessResponse)](../../models/operations/updatedsourceaccessresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## updated_mp4_support

This endpoint allows you to update the `mp4Support` setting of an existing media file using its media ID. You can specify the MP4 support level, such as `none`, `capped_4k`, `audioOnly`, or a combination of `audioOnly`, `capped_4k`, in the request payload.

#### How it works

1. Send a PATCH request to this endpoint, replacing `{mediaId}` with the media ID.

2. Provide the desired `mp4Support` value in the request body.

3. You receive a response confirming the update, including the media’s updated MP4 support status.

#### MP4 Support Options

- `none` – MP4 support is disabled for this media.

- `capped_4k` – Generates MP4 renditions up to 4K resolution.

- `audioOnly` – Generates an M4A file that contains only the audio track.

- `audioOnly,capped_4k` – Generates both an audio-only M4A file and MP4 renditions up to 4K resolution.

#### Webhook events

- <a href="https://fastpix.com/docs/webhooks/transform-media-events#videomediamp4supportready">video.media.mp4Support.ready</a> – Triggered when the MP4 support setting is successfully updated.

#### Example
Suppose you have a video uploaded to the FastPix platform, and you want to allow users to download the video in MP4 format. By setting "mp4Support": "capped_4k", the system generates an MP4 rendition of the video up to 4K resolution, making it available for download through the stream URL(`https://stream.fastpix.com/{playbackId}/{capped-4k.mp4 | audio.m4a}`). If you want users to stream only the audio from the media file, you can set "mp4Support": "audioOnly". This provides an audio-only stream URL that allows users to listen to the media without video. By setting "mp4Support": "audioOnly,capped_4k", both options are enabled. Users can download the MP4 video and also stream just the audio version of the media. 


Related guide: <a href="https://fastpix.com/docs/video-on-demand/enable-mp4-support-for-offline-viewing">Use MP4 support for offline viewing</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="updated-mp4Support" method="patch" path="/on-demand/{mediaId}/update-mp4Support" -->
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

res = s.manage_videos.updated_mp4_support(media_id: 'your-media-id', body: Models::Operations::UpdatedMp4SupportRequestBody.new())

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                   | Type                                                                                                        | Required                                                                                                    | Description                                                                                                 | Example                                                                                                     |
| ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                                  | *::String*                                                                                                  | :heavy_check_mark:                                                                                          | The unique identifier assigned to the media when created. The value must be a valid UUID.<br/>              | your-media-id                                                                        |
| `body`                                                                                                      | [Models::Operations::UpdatedMp4SupportRequestBody](../../models/operations/updatedmp4supportrequestbody.md) | :heavy_check_mark:                                                                                          | N/A                                                                                                         | {<br/>"mp4Support": "capped_4k"<br/>}                                                                       |

### Response

**[T.nilable(Models::Operations::UpdatedMp4SupportResponse)](../../models/operations/updatedmp4supportresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## retrieve_media_input_info

This endpoint lets you retrieve detailed information about the media inputs associated with a specific media item. You can use it to verify the media file’s input URL, track its creation status, and check its container format. You must provide the mediaId (either the uploadId or the id) to fetch this information.


#### How it works

Upon making a `GET` request with the mediaId, FastPix returns a response with: 

* The public storage input `url` of the uploaded media file. 

* Information about the media’s video and audio tracks, including whether they were successfully created.

* The container format of the uploaded media file (for example, MP4, MKV).

This endpoint is particularly useful for ensuring that all necessary tracks (video and audio) have been correctly associated with the media during the upload or media creation process.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="retrieveMediaInputInfo" method="get" path="/on-demand/{mediaId}/input-info" -->
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

res = s.manage_videos.retrieve_media_input_info(media_id: 'your-media-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               | Example                                                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `media_id`                                                                                | *::String*                                                                                | :heavy_check_mark:                                                                        | Pass the list of the input objects used to create the media, along with applied settings. | your-media-id                                                      |

### Response

**[T.nilable(Models::Operations::RetrieveMediaInputInfoResponse)](../../models/operations/retrievemediainputinforesponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## list_uploads

This endpoint retrieves a paginated list of all unused upload signed URLs within your organization. It provides comprehensive metadata including upload IDs, creation dates, status, and URLs, helping you manage your media resources efficiently.

An unused upload URL is a signed URL that gets generated when an user initiates upload but never completed the upload process. This can happen due to reasons like network issues, manual cancellation of upload, browser/app crashes or session timeouts.These URLs remain in the system as "unused" since they were created but never resulted in a successful media file upload.

#### How it works

 - The endpoint returns metadata for all unused upload URLs in your organization's library.
 - Results are paginated to manage large datasets effectively.
 - Signed URLs expire after 24 hours from creation.
 - Each entry includes full metadata about the unused upload.



#### Example

A video management team at a media organization regularly uploads content but often forgets to delete or use unused uploads. These unused uploads have signed URLs that expire after 24 hours and need to be managed efficiently. By using this API, the team can retrieve metadata for all unused uploads, identify expired signed URLs, and decide whether to regenerate URLs, reuse the uploads, or delete them.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="list-uploads" method="get" path="/on-demand/uploads" -->
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

res = s.manage_videos.list_uploads(limit: 20, offset: 1, order_by: Models::Components::SortOrder::DESC)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               | Example                                                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `limit`                                                                                   | *T.nilable(::Integer)*                                                                    | :heavy_minus_sign:                                                                        | Limit specifies the maximum number of items to display per page.                          | 20                                                                                        |
| `offset`                                                                                  | *T.nilable(::Integer)*                                                                    | :heavy_minus_sign:                                                                        | Offset determines the starting point for data retrieval within a paginated list.          | 1                                                                                         |
| `order_by`                                                                                | [T.nilable(Models::Components::SortOrder)](../../models/shared/sortorder.md)              | :heavy_minus_sign:                                                                        | The values in the list can be arranged in two ways: DESC (Descending) or ASC (Ascending). | desc                                                                                      |

### Response

**[T.nilable(Models::Operations::ListUploadsResponse)](../../models/operations/listuploadsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## get_media_clips

This endpoint retrieves a list of all media clips associated with a given source media ID. It helps you organize and manage media efficiently by providing metadata such as clip media IDs and other relevant details.

A media clip is a segmented portion of an original media file (source media). Clips are often created for various purposes such as previews, highlights, or customized edits. This API allows you to fetch all such clips linked to a specific source media, making it easier to track and manage clips.


#### How it works

- The endpoint returns metadata for all media clips associated with the given `mediaId`.
- Results are paginated to efficiently handle large datasets.
- Each entry includes detailed metadata such as media `id`, `duration`, and `status`.
- Helps in organizing clips effectively by providing structured information.


#### Example

Imagine you’re managing a video editing platform where users upload full-length videos and create short clips for social media sharing. To keep track of all clips linked to a particular video, you call this API with the sourceMediaId. The response provides a list of all associated clips, allowing you to manage, edit, or repurpose them as needed.

Related guide: <a href="https://fastpix.com/docs/video-on-demand/clip-and-trim-videos">Create clips from existing media</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-media-clips" method="get" path="/on-demand/{mediaId}/media-clips" -->
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

res = s.manage_videos.get_media_clips(media_id: 'your-media-id', offset: 5, limit: 20, order_by: Models::Components::SortOrder::DESC)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                 | Type                                                                                      | Required                                                                                  | Description                                                                               | Example                                                                                   |
| ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------- |
| `media_id`                                                                                | *::String*                                                                                | :heavy_check_mark:                                                                        | The unique identifier assigned to the media when created. The value must be a valid UUID. | your-media-id                                                      |
| `offset`                                                                                  | *T.nilable(::Integer)*                                                                    | :heavy_minus_sign:                                                                        | Offset determines the starting point for data retrieval within a paginated list.          | 5                                                                                         |
| `limit`                                                                                   | *T.nilable(::Integer)*                                                                    | :heavy_minus_sign:                                                                        | The number of media clips to retrieve per request.                                        | 20                                                                                        |
| `order_by`                                                                                | [T.nilable(Models::Components::SortOrder)](../../models/shared/sortorder.md)              | :heavy_minus_sign:                                                                        | The values in the list can be arranged in two ways DESC (Descending) or ASC (Ascending).  | desc                                                                                      |

### Response

**[T.nilable(Models::Operations::GetMediaClipsResponse)](../../models/operations/getmediaclipsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |