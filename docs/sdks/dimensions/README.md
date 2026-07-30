# Dimensions

## Overview

Operations involving dimensions

### Available Operations

* [list_dimensions](#list_dimensions) - List the dimensions
* [list_filter_values_for_dimension](#list_filter_values_for_dimension) - List the filter values for a dimension

## list_dimensions

Retrieves a list of dimensions that can be used as query parameters across various data endpoints. Each dimension has a unique id that can be used to filter data effectively. 

The dimensions retrieved from this endpoint can be used in conjunction with the <a href="https://fastpix.com/docs/video-data-api/views/list-video-views">list video views</a> and <a href="https://fastpix.com/docs/video-data-api/views/list-by-top-content">list by top content</a> endpoints to filter results based on specific criteria. For example, you can filter views by `browser_name`, `os_name`, `device_type`, and more.

Related guides: <a href="https://fastpix.com/docs/video-data/what-video-data-do-we-capture">What Video Data do we capture?</a> ,   <a href="https://fastpix.com/docs/video-data/pass-custom-metadata-to-metrics">Use passable dimensions</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="list_dimensions" method="get" path="/data/dimensions" -->
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

res = s.dimensions.list_dimensions()

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Response

**[T.nilable(Models::Operations::ListDimensionsResponse)](../../models/operations/listdimensionsresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## list_filter_values_for_dimension

This endpoint returns the filter values associated with a specific dimension, along with the total number of video views for each value. For example, it can list all `browser_name` (dimension) and show how many views occurred for all available browsers like Chrome, Safari (filter values). 


In order to use the <a href="https://fastpix.com/docs/video-data/use-custom-dimensions">Custom Dimensions</a>, you must enable them in the dashboard under settings option based on the plan you have opted for.


#### Example

A developer wants to know how their video content performs across different browsers. By calling this endpoint for the `device_type` dimension, they can retrieve a breakdown of video views by each device (for example, Desktop, Mobile, Tablet). This data helps the developer understand where optimizations or troubleshooting is necessary.


Related guide: <a href="https://fastpix.com/docs/video-data/explore-the-dashboard#filters-and-timeframes">Filters and timespan</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="list_filter_values_for_dimension" method="get" path="/data/dimensions/{dimensionsId}" -->
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

res = s.dimensions.list_filter_values_for_dimension(dimensions_id: Models::Operations::DimensionsId::BROWSER_NAME, timespan: Models::Operations::ListFilterValuesForDimensionTimespan::TWENTY_FOURHOURS, filterby: 'browser_name:Chrome')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                                                                        | Type                                                                                                                                                                                                                                                                                                                                                                                                                             | Required                                                                                                                                                                                                                                                                                                                                                                                                                         | Description                                                                                                                                                                                                                                                                                                                                                                                                                      | Example                                                                                                                                                                                                                                                                                                                                                                                                                          |
| -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `dimensions_id`                                                                                                                                                                                                                                                                                                                                                                                                                  | [Models::Operations::DimensionsId](../../models/operations/dimensionsid.md)                                                                                                                                                                                                                                                                                                                                                      | :heavy_check_mark:                                                                                                                                                                                                                                                                                                                                                                                                               | Pass Dimensions Id<br/>                                                                                                                                                                                                                                                                                                                                                                                                          | browser_name                                                                                                                                                                                                                                                                                                                                                                                                                     |
| `timespan`                                                                                                                                                                                                                                                                                                                                                                                                                       | [T.nilable(Models::Operations::ListFilterValuesForDimensionTimespan)](../../models/operations/listfiltervaluesfordimensiontimespan.md)                                                                                                                                                                                                                                                                                           | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                               | This parameter specifies the time span between which the video views list must be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.<br/><br/>**Accepted formats are:**<br/><br/>array of epoch timestamps for example <br/>`timespan[]=1498867200&timespan[]=1498953600`<br/><br/>duration string for example  <br/>`timespan[]=24:hours` or `timespan[]=7:days`<br/> | 24:hours                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `filterby`                                                                                                                                                                                                                                                                                                                                                                                                                       | *T.nilable(::String)*                                                                                                                                                                                                                                                                                                                                                                                                            | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                               | Pass the dimensions and their corresponding values you want to filter the views by. For excluding the values in the filter we can pass "!" before the filter value. The list of filters can be obtained from list of dimensions endpoint.<br/>Example Values : [ browser_name:Chrome , os_name:macOS , !device_name:Galaxy ]<br/>                                                                                                | browser_name:Chrome                                                                                                                                                                                                                                                                                                                                                                                                              |

### Response

**[T.nilable(Models::Operations::ListFilterValuesForDimensionResponse)](../../models/operations/listfiltervaluesfordimensionresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |