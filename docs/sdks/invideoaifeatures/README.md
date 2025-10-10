# InVideoAIFeatures
(*in_video_ai_features*)

## Overview

### Available Operations

* [update_media_summary](#update_media_summary) - Generate video summary
* [update_media_chapters](#update_media_chapters) - Generate video chapters
* [update_media_named_entities](#update_media_named_entities) - Generate named entities
* [update_media_moderation](#update_media_moderation) - Enable video moderation

## update_media_summary

This endpoint allows you to generate the summary for an existing media.

#### How it works
1. Send a PATCH request to this endpoint, replacing `<mediaId>` with the unique ID of the media for which you wish to generate a summary.
2. Include the `generate` parameter in the request body.
3. Include the `summaryLength` parameter, specify the desired length of the summary in words (e.g., 120 words), this determines how concise or detailed the summary will be. If no specific summary length is provided, the default length will be 100 words. 
4. The response will include the updated media data and confirmation of the changes applied.

You can use the <a href="https://docs.fastpix.io/docs/ai-events#videomediaaisummaryready">video.mediaAI.summary.ready</a> webhook event to track and notify about the summary generation.





**Use case**: This is particularly useful when a user uploads a video and later chooses to generate a summary without needing to re-upload the video.

Related guide: <a href="https://docs.fastpix.io/docs/generate-video-summary">Video summary</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-media-summary" method="patch" path="/on-demand/{mediaId}/summary" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.in_video_ai_features.update_media_summary(media_id: '4fa85f64-5717-4562-b3fc-2c963f66afa6', request_body: Models::Operations::UpdateMediaSummaryRequestBody.new(
  generate: true,
))

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                     | Type                                                                                                          | Required                                                                                                      | Description                                                                                                   | Example                                                                                                       |
| ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                                    | *::String*                                                                                                    | :heavy_check_mark:                                                                                            | The unique identifier assigned to the media when created. The value should be a valid UUID.<br/>              | 4fa85f64-5717-4562-b3fc-2c963f66afa6                                                                          |
| `request_body`                                                                                                | [Models::Operations::UpdateMediaSummaryRequestBody](../../models/operations/updatemediasummaryrequestbody.md) | :heavy_check_mark:                                                                                            | N/A                                                                                                           | {<br/>"generate": true,<br/>"summaryLength": 100<br/>}                                                        |

### Response

**[T.nilable(Models::Operations::UpdateMediaSummaryResponse)](../../models/operations/updatemediasummaryresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::InvalidPermissionError  | 401                                     | application/json                        |
| Models::Errors::ForbiddenError          | 403                                     | application/json                        |
| Models::Errors::MediaNotFoundError      | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |

## update_media_chapters

This endpoint enables you to generate chapters for an existing media file.

#### How it works
1. Make a `PATCH` request to this endpoint, replacing `<mediaId>` with the ID of the media for which you want to generate chapters.
2. Include the `chapters` parameter in the request body to enable.
3. The response will contain the updated media data, confirming the changes made.

You can use the <a href="https://docs.fastpix.io/docs/ai-events#videomediaaichaptersready">video.mediaAI.chapters.ready</a> webhook event to track and notify about the chapters generation.

**Use case:** This is particularly useful when a user uploads a video and later decides to enable chapters without re-uploading the entire video.

Related guide: <a href="https://docs.fastpix.io/reference/update-media-chapters">Video chapters</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-media-chapters" method="patch" path="/on-demand/{mediaId}/chapters" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.in_video_ai_features.update_media_chapters(media_id: '4fa85f64-5717-4562-b3fc-2c963f66afa6', request_body: Models::Operations::UpdateMediaChaptersRequestBody.new(
  chapters: true,
))

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                       | Type                                                                                                            | Required                                                                                                        | Description                                                                                                     | Example                                                                                                         |
| --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                                      | *::String*                                                                                                      | :heavy_check_mark:                                                                                              | The unique identifier assigned to the media when created. The value should be a valid UUID.<br/>                | 4fa85f64-5717-4562-b3fc-2c963f66afa6                                                                            |
| `request_body`                                                                                                  | [Models::Operations::UpdateMediaChaptersRequestBody](../../models/operations/updatemediachaptersrequestbody.md) | :heavy_check_mark:                                                                                              | N/A                                                                                                             | {<br/>"chapters": true<br/>}                                                                                    |

### Response

**[T.nilable(Models::Operations::UpdateMediaChaptersResponse)](../../models/operations/updatemediachaptersresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::InvalidPermissionError  | 401                                     | application/json                        |
| Models::Errors::ForbiddenError          | 403                                     | application/json                        |
| Models::Errors::MediaNotFoundError      | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |

## update_media_named_entities

This endpoint allows you to extract named entities from an existing media.
Named Entity Recognition (NER) is a fundamental natural language processing (NLP) technique that identifies and classifies key information (entities) in text into predefined categories. For instance:

  - Organizations (e.g., "Microsoft", "United Nations")
  - Locations (e.g., "Paris", "Mount Everest")
  - Product names (e.g., "iPhone", "Coca-Cola")

#### How it works
1. Make a PATCH request to this endpoint, replacing `<mediaId>` with the ID of the media you want to extract named-entities.
2. Include the `namedEntities` parameter in the request body to enable.
3. Receive a response containing the updated media data, confirming the changes made.

You can use the <a href="https://docs.fastpix.io/docs/ai-events#videomediaainamedentitiesready">video.mediaAI.named-entities.ready</a> webhook event to track and notify about the named entities extraction.

**Use case:** If a user uploads a video and later decides to enable named entity extraction without re-uploading the entire video.

Related guide: <a href="https://docs.fastpix.io/docs/generate-named-entities">Named entities</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-media-named-entities" method="patch" path="/on-demand/{mediaId}/named-entities" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.in_video_ai_features.update_media_named_entities(media_id: '0cec3c88-c69d-4232-9b96-f0976327fa2d', request_body: Models::Operations::UpdateMediaNamedEntitiesRequestBody.new(
  named_entities: true,
))

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                 | Type                                                                                                                      | Required                                                                                                                  | Description                                                                                                               | Example                                                                                                                   |
| ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                                                | *::String*                                                                                                                | :heavy_check_mark:                                                                                                        | The unique identifier assigned to the media when created. The value should be a valid UUID.<br/>                          | 0cec3c88-c69d-4232-9b96-f0976327fa2d                                                                                      |
| `request_body`                                                                                                            | [Models::Operations::UpdateMediaNamedEntitiesRequestBody](../../models/operations/updatemedianamedentitiesrequestbody.md) | :heavy_check_mark:                                                                                                        | N/A                                                                                                                       | {<br/>"namedEntities": true<br/>}                                                                                         |

### Response

**[T.nilable(Models::Operations::UpdateMediaNamedEntitiesResponse)](../../models/operations/updatemedianamedentitiesresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::InvalidPermissionError  | 401                                     | application/json                        |
| Models::Errors::ForbiddenError          | 403                                     | application/json                        |
| Models::Errors::MediaNotFoundError      | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |

## update_media_moderation

This endpoint enables moderation features, such as NSFW and profanity filtering, to detect inappropriate content in existing media.

#### How it works
1. Make a PATCH request to this endpoint, replacing `<mediaId>` with the ID of the media you want to update.
2. Include the `moderation` object and provide the requried `type` parameter in the request body to specify the media type (e.g., video/audio/av).
4. The response will contain the updated media data, confirming the changes made.

You can use the <a href="https://docs.fastpix.io/docs/ai-events#videomediaaimoderationready">video.mediaAI.moderation.ready</a> webhook event to track and notify about the detected moderation results.

**Use case:** This is particularly useful when a user uploads a video and later decides to enable moderation detection without the need to re-upload it.

Related guide: <a href="https://docs.fastpix.io/docs/using-nsfw-and-profanity-filter-for-video-moderation">Moderate NSFW & Profanity</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-media-moderation" method="patch" path="/on-demand/{mediaId}/moderation" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.in_video_ai_features.update_media_moderation(media_id: '0cec3c88-c69d-4232-9b96-f0976327fa2d', request_body: Models::Operations::UpdateMediaModerationRequestBody.new(
  moderation: Models::Operations::UpdateMediaModerationModeration.new(
    type: Models::Components::MediaType::VIDEO,
  ),
))

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                           | Type                                                                                                                | Required                                                                                                            | Description                                                                                                         | Example                                                                                                             |
| ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                                          | *::String*                                                                                                          | :heavy_check_mark:                                                                                                  | The unique identifier assigned to the media when created. The value should be a valid UUID.<br/>                    | 0cec3c88-c69d-4232-9b96-f0976327fa2d                                                                                |
| `request_body`                                                                                                      | [Models::Operations::UpdateMediaModerationRequestBody](../../models/operations/updatemediamoderationrequestbody.md) | :heavy_check_mark:                                                                                                  | N/A                                                                                                                 | {<br/>"moderation": {<br/>"type": "video"<br/>}<br/>}                                                               |

### Response

**[T.nilable(Models::Operations::UpdateMediaModerationResponse)](../../models/operations/updatemediamoderationresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::InvalidPermissionError  | 401                                     | application/json                        |
| Models::Errors::ForbiddenError          | 403                                     | application/json                        |
| Models::Errors::MediaNotFoundError      | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |