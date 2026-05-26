# Playlist

## Overview

Operations for playlist management

### Available Operations

* [create_a_playlist](#create_a_playlist) - Create a new playlist
* [get_all_playlists](#get_all_playlists) - Get all playlists
* [get_playlist_by_id](#get_playlist_by_id) - Get a playlist by ID
* [update_a_playlist](#update_a_playlist) - Update a playlist by ID
* [delete_a_playlist](#delete_a_playlist) - Delete a playlist by ID
* [add_media_to_playlist](#add_media_to_playlist) - Add media to a playlist by ID
* [change_media_order_in_playlist](#change_media_order_in_playlist) - Change media order in a playlist by ID
* [delete_media_from_playlist](#delete_media_from_playlist) - Delete media in a playlist by ID

## create_a_playlist

This endpoint creates a new playlist within a specified workspace. A playlist acts as a container for organizing media items either manually or based on filters and metadata. <br> <br>
### Playlists can be created in two modes
- **Manual:** Creates an empty playlist without any initial media items. Use this mode for manual curation, where you add items later in a user-defined sequence.
- **Smart:** Auto-populates the playlist at creation time based on the filter criteria (for example, a video creation date range) that you provide in the request.

For more details, see <a href="https://fastpix.com/docs/playback-and-delivery/create-and-manage-playlists">Create and manage playlist</a>.

#### How it works 

 - When you send a `POST` request to this endpoint, FastPix creates a playlist and returns a playlist ID, using which items can be added later in a user-defined sequence.
 - You can create a smart playlist that is auto-populated based on the metadata in the request body.


#### Example
An e-learning platform creates a new playlist titled Beginner Python Series through the API. The response returns a unique playlist ID. The platform uses this ID to add a series of video tutorials to the playlist in a defined order. The playlist appears on the frontend as a structured learning path for learners.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="create-a-playlist" method="post" path="/on-demand/playlists" -->
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

req = Models::Components::CreatePlaylistRequestSmart.new(
  name: 'playlist name',
  reference_id: 'a1',
  type: Models::Components::CreatePlaylistRequestSmartType::SMART,
  description: 'This is a playlist',
  play_order: Models::Components::PlaylistOrder::CREATED_DATE_ASC,
  limit: 20,
  metadata: Models::Components::Metadata.new(
    created_date: Models::Components::DateRange.new(
      start_date: '2024-11-11',
      end_date: '2024-12-12',
    ),
    updated_date: Models::Components::DateRange.new(
      start_date: '2024-11-11',
      end_date: '2024-12-12',
    ),
  ),
)

res = s.playlist.create_a_playlist(request: req)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                                                              | Type                                                                                                                                                   | Required                                                                                                                                               | Description                                                                                                                                            |
| ------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `request`                                                                                                                                              | [T.any(Models::Components::CreatePlaylistRequestManual, Models::Components::CreatePlaylistRequestSmart)](../../models/shared/createplaylistrequest.md) | :heavy_check_mark:                                                                                                                                     | The request object to use for the request.                                                                                                             |

### Response

**[T.nilable(Models::Operations::CreateAPlaylistResponse)](../../models/operations/createaplaylistresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## get_all_playlists

This endpoint retrieves all playlists in a specified workspace. It allows you to view the collection of manual and smart playlists along with their associated metadata.
#### How it works

 - When a user sends a GET request to this endpoint, FastPix returns a list of all playlists in the workspace, including details such as playlist IDs, titles, creation mode (manual or smart), and other relevant metadata.

#### Example

  An e-learning platform requests all playlists within a workspace to display an overview of available learning paths. The response includes multiple playlists like "Beginner Python Series" and "Advanced Java Tutorials," enabling the platform to show users a catalog of curated content collections.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-all-playlists" method="get" path="/on-demand/playlists" -->
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

res = s.playlist.get_all_playlists(limit: 1, offset: 1)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                          | Type                                                                                               | Required                                                                                           | Description                                                                                        | Example                                                                                            |
| -------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------- |
| `limit`                                                                                            | *T.nilable(::Integer)*                                                                             | :heavy_minus_sign:                                                                                 | The number of playlists to return (default is 10, max is 50).                                      | 1                                                                                                  |
| `offset`                                                                                           | *T.nilable(::Integer)*                                                                             | :heavy_minus_sign:                                                                                 | The page number to retrieve, starting from 1. Use this parameter to paginate the playlist results. | 1                                                                                                  |

### Response

**[T.nilable(Models::Operations::GetAllPlaylistsResponse)](../../models/operations/getallplaylistsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## get_playlist_by_id

This endpoint retrieves detailed information about a specific playlist using its unique `playlistId`. It provides comprehensive metadata about the playlist, including its title, creation mode (manual or smart), media items along with the metadata of each media in the playlist.


#### Example
An e-learning platform requests details for the playlist "Beginner Python Series" by providing its unique `playlistId`. The response includes the playlist"s title, creation mode, and the ordered list of video tutorials contained within, enabling the platform to present the full learning path to users.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-playlist-by-id" method="get" path="/on-demand/playlists/{playlistId}" -->
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

res = s.playlist.get_playlist_by_id(playlist_id: 'your-playlist-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                           | Type                                                | Required                                            | Description                                         |
| --------------------------------------------------- | --------------------------------------------------- | --------------------------------------------------- | --------------------------------------------------- |
| `playlist_id`                                       | *::String*                                          | :heavy_check_mark:                                  | The unique id of the playlist you want to retrieve. |

### Response

**[T.nilable(Models::Operations::GetPlaylistByIdResponse)](../../models/operations/getplaylistbyidresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## update_a_playlist

This endpoint allows you to update the name and description of an existing playlist. It enables modifications to the playlist's metadata without altering the media items or playlist structure.
#### How it works

 - When a user sends a PUT request to this endpoint with the `playlistId` and updated name and description in the request body, FastPix updates the playlist metadata accordingly and returns the updated playlist details.

#### Example
An e-learning platform updates the playlist titled "Beginner Python Series" to rename it as "Python Basics" and add a more detailed description. The updated metadata is reflected when retrieving the playlist, helping users better understand the playlist content.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-a-playlist" method="put" path="/on-demand/playlists/{playlistId}" -->
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

res = s.playlist.update_a_playlist(playlist_id: 'your-playlist-id', body: Models::Components::UpdatePlaylistRequest.new(
  name: 'updated name',
  description: 'updated description',
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
| `playlist_id`                                                                             | *::String*                                                                                | :heavy_check_mark:                                                                        | The unique id of the playlist you want to retrieve.                                       |                                                                                           |
| `body`                                                                                    | [Models::Components::UpdatePlaylistRequest](../../models/shared/updateplaylistrequest.md) | :heavy_check_mark:                                                                        | N/A                                                                                       | {<br/>"name": "updated name",<br/>"description": "updated description"<br/>}              |

### Response

**[T.nilable(Models::Operations::UpdateAPlaylistResponse)](../../models/operations/updateaplaylistresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## delete_a_playlist

This endpoint allows you to delete an existing playlist from the workspace. After deleted, the playlist and its metadata are permanently removed and cannot be recovered.
#### How it works
 - When a user sends a DELETE request to this endpoint with the `playlistId`, FastPix removes the specified playlist from the workspace and returns a confirmation of successful deletion.

#### Example
An e-learning platform deletes an outdated playlist titled "Old Python Tutorials" by providing its unique playlist ID. The platform receives confirmation that the playlist has been removed, ensuring learners no longer see the obsolete content.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="delete-a-playlist" method="delete" path="/on-demand/playlists/{playlistId}" -->
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

res = s.playlist.delete_a_playlist(playlist_id: 'your-playlist-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                         | Type                                              | Required                                          | Description                                       |
| ------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------- | ------------------------------------------------- |
| `playlist_id`                                     | *::String*                                        | :heavy_check_mark:                                | The unique id of the playlist you want to delete. |

### Response

**[T.nilable(Models::Operations::DeleteAPlaylistResponse)](../../models/operations/deleteaplaylistresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## add_media_to_playlist

This endpoint allows you to add one or more media items to an existing playlist. By passing the media ID(s) in the request, the specified media items are appended to the playlist in the order provided.
#### How it works

 - When a user sends a PATCH request to this endpoint with the `playlistId` as path parameter and a list of media ID(s) in the request body, FastPix adds the specified media items to the playlist and returns the updated playlist details.

#### Example
An e-learning platform adds new video tutorials to the "Beginner Python Series" playlist by sending their media IDs in the request. The playlist is updated with the new content, ensuring learners have access to the latest tutorials in sequence.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="add-media-to-playlist" method="patch" path="/on-demand/playlists/{playlistId}/media" -->
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

res = s.playlist.add_media_to_playlist(playlist_id: 'your-playlist-id', body: Models::Components::MediaIdsRequest.new(
  media_ids: [
    'your-media-id-1',
    'your-media-id-2',
    'your-media-id-3',
  ],
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

| Parameter                                                                     | Type                                                                          | Required                                                                      | Description                                                                   |
| ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `playlist_id`                                                                 | *::String*                                                                    | :heavy_check_mark:                                                            | The unique id of the playlist you want to perform the operation on.           |
| `body`                                                                        | [Models::Components::MediaIdsRequest](../../models/shared/mediaidsrequest.md) | :heavy_check_mark:                                                            | N/A                                                                           |

### Response

**[T.nilable(Models::Operations::AddMediaToPlaylistResponse)](../../models/operations/addmediatoplaylistresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## change_media_order_in_playlist

This endpoint allows you to change the order of media items within a playlist. By passing the complete list of media IDs in the desired sequence, the playlist's play order is updated accordingly.
#### How it works

 - When a user sends a PUT request to this endpoint with the `playlistId` as path parameter and the reordered list of all media IDs in the request body, FastPix updates the playlist to reflect the new media sequence and returns the updated playlist details.

#### Example
An e-learning platform rearranges the "Beginner Python Series" playlist by submitting a reordered list of media IDs. The playlist now follows the new sequence, providing learners with a better structured learning path.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="change-media-order-in-playlist" method="put" path="/on-demand/playlists/{playlistId}/media" -->
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

res = s.playlist.change_media_order_in_playlist(playlist_id: 'your-playlist-id', body: Models::Components::MediaIdsRequest.new(
  media_ids: [
    'your-media-id-1',
    'your-media-id-2',
    'your-media-id-3',
  ],
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

| Parameter                                                                     | Type                                                                          | Required                                                                      | Description                                                                   |
| ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `playlist_id`                                                                 | *::String*                                                                    | :heavy_check_mark:                                                            | The unique id of the playlist you want to perform the operation on.           |
| `body`                                                                        | [Models::Components::MediaIdsRequest](../../models/shared/mediaidsrequest.md) | :heavy_check_mark:                                                            | N/A                                                                           |

### Response

**[T.nilable(Models::Operations::ChangeMediaOrderInPlaylistResponse)](../../models/operations/changemediaorderinplaylistresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## delete_media_from_playlist

This endpoint allows you to delete one or more media items from an existing playlist. By passing the media ID(s) in the request, the specified media items are removed from the playlist.
#### How it works

 - When a user sends a DELETE request to this endpoint with the playlist ID as the path parameter and the media ID(s) to be removed in the request body, FastPix deletes the specified media items from the playlist and returns the updated playlist details.

#### Example
An e-learning platform removes outdated video tutorials from the "Beginner Python Series" playlist by specifying their media IDs in the request. The playlist is updated to exclude these items, ensuring learners only access relevant content.

### Example Usage

<!-- UsageSnippet language="ruby" operationID="delete-media-from-playlist" method="delete" path="/on-demand/playlists/{playlistId}/media" -->
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

res = s.playlist.delete_media_from_playlist(playlist_id: 'your-playlist-id', body: Models::Components::MediaIdsRequest.new(
  media_ids: [
    'your-media-id-1',
    'your-media-id-2',
    'your-media-id-3',
  ],
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

| Parameter                                                                     | Type                                                                          | Required                                                                      | Description                                                                   |
| ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- | ----------------------------------------------------------------------------- |
| `playlist_id`                                                                 | *::String*                                                                    | :heavy_check_mark:                                                            | The unique id of the playlist you want to perform the operation on.           |
| `body`                                                                        | [Models::Components::MediaIdsRequest](../../models/shared/mediaidsrequest.md) | :heavy_check_mark:                                                            | N/A                                                                           |

### Response

**[T.nilable(Models::Operations::DeleteMediaFromPlaylistResponse)](../../models/operations/deletemediafromplaylistresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |