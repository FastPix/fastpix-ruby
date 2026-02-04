# InVideoAIFeatures

## Overview

Operations for AI-powered video features

### Available Operations

* [update_media_summary](#update_media_summary) - Generate video summary
* [update_media_chapters](#update_media_chapters) - Generate video chapters
* [update_media_named_entities](#update_media_named_entities) - Generate named entities
* [update_media_moderation](#update_media_moderation) - Enable video moderation

## update_media_summary

This endpoint allows you to generate the summary for an existing media.

#### How it works
1. Send a `PATCH` request to this endpoint, replacing `<mediaId>` with the ID of the media you want to summarize.
2. Include the `generate` parameter in the request body.
3. Include the `summaryLength` parameter, specify the desired length of the summary in words (for example, 120 words), this determines how concise or detailed the summary will be. If no specific summary length is provided, the default length will be 100 words.
4. The response includes the updated media data and confirmation of the changes applied.

You can use the <a href="https://docs.fastpix.io/docs/ai-events#videomediaaisummaryready">video.mediaAI.summary.ready</a> webhook event to track and notify about the summary generation.





**Use case**: This is particularly useful when a user uploads a video and later chooses to generate a summary without needing to re-upload the video.

Related guide: <a href="https://docs.fastpix.io/docs/generate-video-summary">Video summary</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-media-summary" method="patch" path="/on-demand/{mediaId}/summary" -->
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

res = s.in_video_ai_features.update_media_summary(media_id: 'your-media-id', body: Models::Operations::UpdateMediaSummaryRequestBody.new(
  generate: true,
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

| Parameter                                                                                                     | Type                                                                                                          | Required                                                                                                      | Description                                                                                                   | Example                                                                                                       |
| ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `media_id`                                                                                                    | *::String*                                                                                                    | :heavy_check_mark:                                                                                            | The unique identifier assigned to the media when created. The value must be a valid UUID.<br/>                | your-media-id                                                                          |
| `body`                                                                                                        | [Models::Operations::UpdateMediaSummaryRequestBody](../../models/operations/updatemediasummaryrequestbody.md) | :heavy_check_mark:                                                                                            | N/A                                                                                                           | {<br/>"generate": true,<br/>"summaryLength": 100<br/>}                                                        |

### Response

**[T.nilable(Models::Operations::UpdateMediaSummaryResponse)](../../models/operations/updatemediasummaryresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## update_media_chapters

This endpoint enables you to generate chapters for an existing media file.

#### How it works
1. Make a `PATCH` request to this endpoint, replacing `<mediaId>` with the ID of the media for which you want to generate chapters.
2. Include the `chapters` parameter in the request body to enable.
3. The response contains the updated media data, confirming the changes made.

You can use the <a href="https://docs.fastpix.io/docs/ai-events#videomediaaichaptersready">video.mediaAI.chapters.ready</a> webhook event to track and notify about the chapters generation.

**Use case:** This is particularly useful when a user uploads a video and later decides to enable chapters without re-uploading the entire video.

Related guide: <a href="https://docs.fastpix.io/docs/generate-video-chapters">Video chapters</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-media-chapters" method="patch" path="/on-demand/{mediaId}/chapters" -->
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

res = s.in_video_ai_features.update_media_chapters(media_id: 'your-media-id', body: Models::Operations::UpdateMediaChaptersRequestBody.new())

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
| `body`                                                                                                          | [Models::Operations::UpdateMediaChaptersRequestBody](../../models/operations/updatemediachaptersrequestbody.md) | :heavy_check_mark:                                                                                              | N/A                                                                                                             | {<br/>"chapters": true<br/>}                                                                                    |

### Response

**[T.nilable(Models::Operations::UpdateMediaChaptersResponse)](../../models/operations/updatemediachaptersresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## update_media_named_entities

This endpoint allows you to extract named entities from an existing media.
Named Entity Recognition (NER) is a fundamental natural language processing (NLP) technique that identifies and classifies key information (entities) in text into predefined categories. For instance:

  - Organizations (for example, "Microsoft", "United Nations")
  - Locations (for example, "Paris", "Mount Everest")
  - Product names (for example, "iPhone", "Coca-Cola")

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
require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.in_video_ai_features.update_media_named_entities(media_id: 'your-media-id', body: Models::Operations::UpdateMediaNamedEntitiesRequestBody.new(
  named_entities: true,
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
| `media_id`                                                                                                                | *::String*                                                                                                                | :heavy_check_mark:                                                                                                        | The unique identifier assigned to the media when created. The value must be a valid UUID.<br/>                            | your-media-id                                                                                      |
| `body`                                                                                                                    | [Models::Operations::UpdateMediaNamedEntitiesRequestBody](../../models/operations/updatemedianamedentitiesrequestbody.md) | :heavy_check_mark:                                                                                                        | N/A                                                                                                                       | {<br/>"namedEntities": true<br/>}                                                                                         |

### Response

**[T.nilable(Models::Operations::UpdateMediaNamedEntitiesResponse)](../../models/operations/updatemedianamedentitiesresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## update_media_moderation

This endpoint enables moderation features, such as NSFW and profanity filtering, to detect inappropriate content in existing media.

#### How it works
1. Make a `PATCH` request to this endpoint, replacing `<mediaId>` with the ID of the media you want to update.
2. Include the `moderation` object and provide the requried `type` parameter in the request body to specify the media type (for example, video/audio/av).
4. The response contains the updated media data, confirming the changes made.

You can use the <a href="https://docs.fastpix.io/docs/ai-events#videomediaaimoderationready">video.mediaAI.moderation.ready</a> webhook event to track and notify about the detected moderation results.

**Use case:** This is particularly useful when a user uploads a video and later decides to enable moderation detection without the need to re-upload it.

Related guide: <a href="https://docs.fastpix.io/docs/using-nsfw-and-profanity-filter-for-video-moderation">Moderate NSFW & Profanity</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="update-media-moderation" method="patch" path="/on-demand/{mediaId}/moderation" -->
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

res = s.in_video_ai_features.update_media_moderation(media_id: 'your-media-id', body: Models::Operations::UpdateMediaModerationRequestBody.new(
  moderation: Models::Operations::UpdateMediaModerationModeration.new(
    type: Models::Components::MediaType::VIDEO,
  ),
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
| `media_id`                                                                                                          | *::String*                                                                                                          | :heavy_check_mark:                                                                                                  | The unique identifier assigned to the media when created. The value must be a valid UUID.<br/>                      | your-media-id                                                                                |
| `body`                                                                                                              | [Models::Operations::UpdateMediaModerationRequestBody](../../models/operations/updatemediamoderationrequestbody.md) | :heavy_check_mark:                                                                                                  | N/A                                                                                                                 | {<br/>"moderation": {<br/>"type": "video"<br/>}<br/>}                                                               |

### Response

**[T.nilable(Models::Operations::UpdateMediaModerationResponse)](../../models/operations/updatemediamoderationresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |