# Views

## Overview

Operations involving views

### Available Operations

* [list_video_views](#list_video_views) - List video views
* [get_video_view_details](#get_video_view_details) - Get details of video view
* [list_by_top_content](#list_by_top_content) - List by top content

## list_video_views

Retrieves a list of video views that fall within the specified filters and have been completed within a defined timespan. It lets you to analyse viewer interactions with your video content effectively. 


#### How it works

  1. Send a `GET` request to this endpoint with the desired query parameters. 

  2. Specify the timespan for which you want to retrieve the video views using the `timespan[]` parameter. 

  3. Filter the views based on dimensions such as browser, device, video title, viewer ID, etc., using the `filterby[]` parameter. Get the dimensions by calling <a href="https://fastpix.com/docs/video-data-api/dimensions/list-dimensions">list the dimensions</a> endpoint. 

  4. Paginate the results using the `limit` and `offset` parameters. 

  5. You can also filter by `viewerId`, `errorCode`, `orderBy` a specific field, and `sortOrder` in ascending or descending order. 

  6. You receive a response containing the list of video views matching the specified criteria.

Each view in the response includes a unique `viewId`. You can use this `viewId` with the  <a href="https://fastpix.com/docs/video-data-api/views/get-video-view-details">Get Video View Details</a> endpoint to retrieve more detailed information about that specific view.


#### Example

If you manage a video streaming service and want to analyze content performance across devices and browsers. By calling the List Video Views endpoint with filters such as `browser_name` and `device_type`, you can identify which platforms are most popular with your audience. This information helps optimize content for widely used platforms and troubleshoot playback issues on less common devices.


  Related guide: <a href="https://fastpix.com/docs/concepts/audience-metrics">Audience metrics</a>, <a href="https://fastpix.com/docs/working-with-video-data/explore-the-dashboard#1-views-dashboard">Views dashboard</a>

### Example Usage

<!-- UsageSnippet language="ruby" operationID="list_video_views" method="get" path="/data/viewlist" -->
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

req = Models::Operations::ListVideoViewsRequest.new(
  timespan: Models::Operations::ListVideoViewsTimespan::TWENTY_FOURHOURS,
  filterby: 'browser_name:Chrome',
  viewer_id: 'your-viewer-id',
  error_code: '1002',
)

res = s.views.list_video_views(request: req)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                     | Type                                                                                          | Required                                                                                      | Description                                                                                   |
| --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------- |
| `request`                                                                                     | [Models::Operations::ListVideoViewsRequest](../../models/operations/listvideoviewsrequest.md) | :heavy_check_mark:                                                                            | The request object to use for the request.                                                    |

### Response

**[T.nilable(Models::Operations::ListVideoViewsResponse)](../../models/operations/listvideoviewsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## get_video_view_details

Retrieves detailed information about a specific video view using its unique `viewId`. This provides insights into individual viewer interactions with your video content, helping you enhance user experience and improve engagement with your videos. 

To use this endpoint, send `GET` request with the `viewId`. The response includes detailed metrics and attributes related to the specified video view. 


#### Example

If a developer receives a report of a poor viewing experience for a specific user. By using this endpoint with the users `viewId`, the developer can retrieve metrics like buffering duration, playback errors, and session length. This data allows the developer to pinpoint issues (such as poor connectivity or a browser-specific problem) and take steps to improve the user experience.


Related guide: <a href="https://fastpix.com/docs/concepts/what-video-data-do-we-capture#/">What Video Data do we capture?</a>

### Example Usage

<!-- UsageSnippet language="ruby" operationID="get_video_view_details" method="get" path="/data/viewlist/{viewId}" -->
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

res = s.views.get_video_view_details(view_id: 'your-view-id')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter          | Type               | Required           | Description        |
| ------------------ | ------------------ | ------------------ | ------------------ |
| `view_id`          | *::String*         | :heavy_check_mark: | Pass View Id       |

### Response

**[T.nilable(Models::Operations::GetVideoViewDetailsResponse)](../../models/operations/getvideoviewdetailsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## list_by_top_content

Retrieves a list of the top video views that fall within the specified filters and have been completed within a defined timespan. It lets you to identify the most popular content based on viewer interactions. 

#### How it works

  1. Send a `GET` request to this endpoint with the desired query parameters. 

  2. Specify the timespan for which you want to retrieve the top content using the `timespan[]` parameter. 

  3. Filter the views based on dimensions such as browser, device, video title, etc., using the `filterby[]` parameter. 

  4. You can use `Limit` to control number of top views returned. 

  5. You receive a response containing the list of top video views matching the specified criteria.


  Related guide: <a href="https://fastpix.com/docs/working-with-video-data/identify-top-performing-content">Get top-performing content</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="list_by_top_content" method="get" path="/data/viewlist/top-content" -->
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

res = s.views.list_by_top_content(timespan: Models::Operations::ListByTopContentTimespan::TWENTY_FOURHOURS, filterby: 'browser_name:Chrome', limit: 10)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                                                                         | Type                                                                                                                                                                                                                                                                                                                                                                                                                              | Required                                                                                                                                                                                                                                                                                                                                                                                                                          | Description                                                                                                                                                                                                                                                                                                                                                                                                                       | Example                                                                                                                                                                                                                                                                                                                                                                                                                           |
| --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `timespan`                                                                                                                                                                                                                                                                                                                                                                                                                        | [T.nilable(Models::Operations::ListByTopContentTimespan)](../../models/operations/listbytopcontenttimespan.md)                                                                                                                                                                                                                                                                                                                    | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                | This parameter specifies the time span between which the video views list must be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.<br/><br/>**Accepted formats are:**<br/><br/>array of epoch timestamps for example  <br/>`timespan[]=1498867200&timespan[]=1498953600`<br/><br/>duration string for example  <br/>`timespan[]=24:hours` or `timespan[]=7:days`<br/> | 24:hours                                                                                                                                                                                                                                                                                                                                                                                                                          |
| `filterby`                                                                                                                                                                                                                                                                                                                                                                                                                        | *T.nilable(::String)*                                                                                                                                                                                                                                                                                                                                                                                                             | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                | Pass the dimensions and their corresponding values you want to filter the views by. For excluding the values in the filter we can pass "!" before the filter value. The list of filters can be obtained from list of dimensions endpoint.<br/>Example Values : [ browser_name:Chrome , os_name:macOS , !device_name:Galaxy ]<br/>                                                                                                 | browser_name:Chrome                                                                                                                                                                                                                                                                                                                                                                                                               |
| `limit`                                                                                                                                                                                                                                                                                                                                                                                                                           | *T.nilable(::Integer)*                                                                                                                                                                                                                                                                                                                                                                                                            | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                                | Pass the limit to display only the rows specified by the value.<br/>                                                                                                                                                                                                                                                                                                                                                              | 10                                                                                                                                                                                                                                                                                                                                                                                                                                |

### Response

**[T.nilable(Models::Operations::ListByTopContentResponse)](../../models/operations/listbytopcontentresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |