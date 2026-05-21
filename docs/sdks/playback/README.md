# Playback

## Overview

Operations for video playback management

### Available Operations

* [create_media_playback_id](#create_media_playback_id) - Create a playback ID
* [list_playback_ids](#list_playback_ids) - Get all playback IDs details for a media
* [delete_media_playback_id](#delete_media_playback_id) - Delete a playback ID
* [get_playback_id](#get_playback_id) - Get a playback ID
* [update_domain_restrictions](#update_domain_restrictions) - Update domain restrictions for a playback ID
* [update_user_agent_restrictions](#update_user_agent_restrictions) - Update user-agent restrictions for a playback ID

## create_media_playback_id

You can create a new playback ID for a specific media asset. If you have already retrieved an existing `playbackId` using the <a href="https://fastpix.com/docs/video-on-demand-api/manage-videos/get-media">Get Media by ID</a> endpoint for a media asset, you can use this endpoint to generate a new playback ID with a specified access policy. 



If you want to create a private playback ID for a media asset that already has a public playback ID, this endpoint also allows you to do so by specifying the desired access policy. 

#### How it works

1. Make a `POST` request to this endpoint, replacing `<mediaId>` with the `uploadId` or `id` of the media asset. 

2. Include the `accessPolicy` in the request body with `private` or `public` as the value. 

3. You receive a response containing the newly created playback ID with the specified access level.


#### Example
A video streaming service generates playback IDs for each media file when users request to view specific content. The video player then uses the playback ID to stream the video.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="create-media-playback-id" method="post" path="/on-demand/{mediaId}/playback-ids" -->
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

res = s.playback.create_media_playback_id(media_id: 'your-media-id', body: Models::Operations::CreateMediaPlaybackIdRequestBody.new(
  access_policy: Models::Components::AccessPolicy::PUBLIC,
  drm_configuration_id: 'your-drm-configuration-id',
  resolution: Models::Operations::Resolution::ONE_THOUSAND_AND_EIGHTYP,
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

| Parameter                                                                                                           | Type                                                                                                                | Required                                                                                                            | Description                                                                                                         | Example                                                                                                             |
| ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                                          | *::String*                                                                                                          | :heavy_check_mark:                                                                                                  | The unique identifier assigned to the media when created. The value must be a valid UUID.                           | your-media-id                                                                                |
| `body`                                                                                                              | [Models::Operations::CreateMediaPlaybackIdRequestBody](../../models/operations/createmediaplaybackidrequestbody.md) | :heavy_check_mark:                                                                                                  | Request body for creating playback id for an media                                                                  |                                                                                                                     |

### Response

**[T.nilable(Models::Operations::CreateMediaPlaybackIdResponse)](../../models/operations/createmediaplaybackidresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## list_playback_ids

Retrieves all playback IDs associated with a given media asset, including each playback ID’s access policy and detailed access restrictions such as allowed or denied domains and user agents.

**How it works:**
1. Send a `GET` request to this endpoint with the target `mediaId`.
2. The response includes an array of playback ID records with their respective access controls.

**Use case:**
Useful for validating and managing playback permissions programmatically, reviewing restriction settings, or powering an access control dashboard.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="list-playback-ids" method="get" path="/on-demand/{mediaId}/playback-ids" -->
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

res = s.playback.list_playback_ids(media_id: 'your-media-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                            | Type                                 | Required                             | Description                          | Example                              |
| ------------------------------------ | ------------------------------------ | ------------------------------------ | ------------------------------------ | ------------------------------------ |
| `media_id`                           | *::String*                           | :heavy_check_mark:                   | N/A                                  | your-media-id |

### Response

**[T.nilable(Models::Operations::ListPlaybackIdsResponse)](../../models/operations/listplaybackidsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## delete_media_playback_id

This endpoint deletes a specific playback ID associated with a media asset. Deleting a `playback ID` revokes access to the media content linked to that ID.


#### How it works

1. Make a `DELETE` request to this endpoint, replacing `<mediaId>` with the unique ID of the media asset from which you want to delete the playback ID. 

2. Include the `playbackId` you want to delete in the request body.

#### Example

Your platform offers limited-time access to premium content. When the subscription expires, you can revoke access to the content by deleting the associated playback ID, preventing users from streaming the video further.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="delete-media-playback-id" method="delete" path="/on-demand/{mediaId}/playback-ids" -->
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

res = s.playback.delete_media_playback_id(media_id: 'your-media-id', playback_id: 'your-playback-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                             | Type                                                                                                  | Required                                                                                              | Description                                                                                           | Example                                                                                               |
| ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                            | *::String*                                                                                            | :heavy_check_mark:                                                                                    | The unique identifier assigned to the media when created. The value must be a valid UUID.             | your-media-id                                                                  |
| `playback_id`                                                                                         | *::String*                                                                                            | :heavy_check_mark:                                                                                    | Return the universal unique identifier for playbacks  which can contain a maximum of 255 characters.  | your-playback-id                                                                  |

### Response

**[T.nilable(Models::Operations::DeleteMediaPlaybackIdResponse)](../../models/operations/deletemediaplaybackidresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## get_playback_id

This endpoint retrieves details about a specific playback ID associated with a media asset. Use it to check the access policy for that specific playback ID, such as whether it is public or private.

**How it works:**
1. Make a GET request to the endpoint, replacing `{mediaId}` with the media ID and `{playbackId}` with the playback ID.
2. This request is useful for auditing or validation before granting playback access in your application.

**Example:**
A media platform might use this endpoint to verify if a playback ID is public or private before embedding the video in a frontend player or allowing access to a restricted group.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="get-playback-id" method="get" path="/on-demand/{mediaId}/playback-ids/{playbackId}" -->
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

res = s.playback.get_playback_id(media_id: 'your-media-id', playback_id: 'your-playback-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                            | Type                                 | Required                             | Description                          | Example                              |
| ------------------------------------ | ------------------------------------ | ------------------------------------ | ------------------------------------ | ------------------------------------ |
| `media_id`                           | *::String*                           | :heavy_check_mark:                   | N/A                                  | your-media-id |
| `playback_id`                        | *::String*                           | :heavy_check_mark:                   | N/A                                  | your-playback-id |

### Response

**[T.nilable(Models::Operations::GetPlaybackIdResponse)](../../models/operations/getplaybackidresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## update_domain_restrictions

This endpoint updates domain-level restrictions for a specific playback ID associated with a media asset.
It allows you to restrict playback to specific domains or block known unauthorized domains.

**How it works:**
1. Make a `PATCH` request to this endpoint with your desired domain access configuration.
2. Set a default policy (`allow` or `deny`) and specify domain names in the `allow` or `deny` lists.
3. This is commonly used to restrict video playback to your website or approved client domains.

**Example:**
A streaming service can allow playback only from `example.com` and deny all others by setting: `"defaultPolicy": "deny"` and `"allow": ["example.com"]`.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-domain-restrictions" method="patch" path="/on-demand/{mediaId}/playback-ids/{playbackId}/domains" -->
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

res = s.playback.update_domain_restrictions(media_id: 'your-media-id', playback_id: 'your-playback-id', body: Models::Operations::UpdateDomainRestrictionsRequestBody.new(
  allow: [
    'yourdomain.com',
    'sampledomain.com',
  ],
  deny: [
    'yourworkdomain.com',
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

| Parameter                                                                                                                 | Type                                                                                                                      | Required                                                                                                                  | Description                                                                                                               | Example                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                                                | *::String*                                                                                                                | :heavy_check_mark:                                                                                                        | N/A                                                                                                                       | your-media-id                                                                                      |
| `playback_id`                                                                                                             | *::String*                                                                                                                | :heavy_check_mark:                                                                                                        | N/A                                                                                                                       | your-playback-id                                                                                      |
| `body`                                                                                                                    | [Models::Operations::UpdateDomainRestrictionsRequestBody](../../models/operations/updatedomainrestrictionsrequestbody.md) | :heavy_check_mark:                                                                                                        | N/A                                                                                                                       |                                                                                                                           |

### Response

**[T.nilable(Models::Operations::UpdateDomainRestrictionsResponse)](../../models/operations/updatedomainrestrictionsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## update_user_agent_restrictions

This endpoint allows updating user-agent restrictions for a specific playback ID associated with a media asset. 
It can be used to allow or deny specific user-agents during playback request evaluation.

**How it works:**
1. Make a `PATCH` request to this endpoint with your desired user-agent access configuration.
2. Specify a default policy (`allow` or `deny`) and provide specific `allow` or `deny` lists.
3. Use this to restrict access to specific browsers, devices, or bots.

**Example:**
A developer may configure a playback ID to deny access from known scraping user-agents while allowing all others by default.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-user-agent-restrictions" method="patch" path="/on-demand/{mediaId}/playback-ids/{playbackId}/user-agents" -->
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

res = s.playback.update_user_agent_restrictions(media_id: 'your-media-id', playback_id: 'your-playback-id', body: Models::Operations::UpdateUserAgentRestrictionsRequestBody.new(
  allow: [
    'Mozilla/55.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36',
  ],
  deny: [
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/53745.36 (KHTML, like Gecko) Chrome/138.0.0.0 Mobile Safari/537.36',
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

| Parameter                                                                                                                       | Type                                                                                                                            | Required                                                                                                                        | Description                                                                                                                     | Example                                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                                                      | *::String*                                                                                                                      | :heavy_check_mark:                                                                                                              | N/A                                                                                                                             | your-media-id                                                                                            |
| `playback_id`                                                                                                                   | *::String*                                                                                                                      | :heavy_check_mark:                                                                                                              | N/A                                                                                                                             | your-playback-id                                                                                            |
| `body`                                                                                                                          | [Models::Operations::UpdateUserAgentRestrictionsRequestBody](../../models/operations/updateuseragentrestrictionsrequestbody.md) | :heavy_check_mark:                                                                                                              | N/A                                                                                                                             |                                                                                                                                 |

### Response

**[T.nilable(Models::Operations::UpdateUserAgentRestrictionsResponse)](../../models/operations/updateuseragentrestrictionsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |