# Metrics

## Overview

Operations involving metrics

### Available Operations

* [list_breakdown_values](#list_breakdown_values) - List breakdown values
* [list_overall_values](#list_overall_values) - List overall values
* [get_timeseries_data](#get_timeseries_data) - Get timeseries data
* [list_comparison_values](#list_comparison_values) - List comparison values

## list_breakdown_values

Retrieves breakdown values for a specified metric and timespan, allowing you to analyze the performance of your content based on various dimensions. It provides insights into how different factors contribute to the overall metrics. 

#### How it works

  1. Before using this endpoint, you can call the <a href="https://fastpix.com/docs/video-data-api/dimensions/list-dimensions">List Dimensions</a> endpoint to retrieve all available dimensions that can be used in your query. 

  2. Send a `GET` request to this endpoint with the required `metricId` and other query parameters. 

  3. You receive a response containing the breakdown values for the specified metric, grouped and filtered according to your parameters. 

  4. Upon successful retrieval, the response includes the breakdown values based on the specified parameters. Note that the time values ( `totalWatchTime` and `totalPlayingTime` ) are in milliseconds 


#### Example


A developer wants to analyze how watch time varies across different device types. By calling this endpoint for the `playing_time` metric and filtering by `device_type`, they can understand how engagement differs between mobile, desktop, and tablet users. This data guides optimization efforts for different platforms.

#### Key fields in response


  * **views:** The count of views based based on the applied filters.

  * **value:** The specific metric value calculated based on the applied filters. 
  * **totalWatchTime:** Total time watched across all views, represented in milliseconds. 

  * **totalPlayTime:** Total time spent playing the video, represented in milliseconds. 
  * **field:** The grouping field value based on the groupBy parameter. 

Related guide: <a href="https://fastpix.com/docs/video-data/understand-data-definitions">Understand data definitions</a>



### Example Usage

<!-- UsageSnippet language="ruby" operationID="list_breakdown_values" method="get" path="/data/metrics/{metricId}/breakdown" -->
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

req = Models::Operations::ListBreakdownValuesRequest.new(
  metric_id: Models::Operations::ListBreakdownValuesMetricId::QUALITY_OF_EXPERIENCE_SCORE,
  timespan: Models::Operations::ListBreakdownValuesTimespan::TWENTY_FOURHOURS,
  filterby: 'browser_name:Chrome',
  group_by: 'browser_name',
)

res = s.metrics.list_breakdown_values(request: req)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                               | Type                                                                                                    | Required                                                                                                | Description                                                                                             |
| ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------- |
| `request`                                                                                               | [Models::Operations::ListBreakdownValuesRequest](../../models/operations/listbreakdownvaluesrequest.md) | :heavy_check_mark:                                                                                      | The request object to use for the request.                                                              |

### Response

**[T.nilable(Models::Operations::ListBreakdownValuesResponse)](../../models/operations/listbreakdownvaluesresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## list_overall_values

Retrieves overall values for a specified metric, providing summary statistics that help you understand the performance of your content. The response includes key metrics such as `totalWatchTime`, `uniqueViews`, `totalPlayTime` and `totalViews`. 

#### How it works

  1. Before using this endpoint, you can call the <a href="https://fastpix.com/docs/video-data-api/dimensions/list-dimensions">list dimensions</a> endpoint to retrieve all available dimensions that can be used in your query. 

  2. Send a `GET` request to this endpoint with the required `metricId` and other query parameters. 

  3. You receive a response containing the overall values for the specified metric, which may vary based on the applied filters. 






#### Key fields in response


  * **value:** The specific metric value calculated based on the applied filters. 
  * **totalWatchTime:** Total time watched across all views, represented in milliseconds. 
  * **uniqueViews:** The count of unique viewers who interacted with the content. 
  * **totalViews:** The total number of views recorded. 
  * **totalPlayTime:** Total time spent playing the video, represented in milliseconds. 
  * **globalValue:** A global metric value that reflects the overall performance of the specified metric across the entire dataset for the given timespan. This value is not affected by specific filters. 


  Related guide: <a href="https://fastpix.com/docs/video-data/understand-data-definitions">Understand data definitions</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="list_overall_values" method="get" path="/data/metrics/{metricId}/overall" -->
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

res = s.metrics.list_overall_values(metric_id: Models::Operations::ListOverallValuesMetricId::QUALITY_OF_EXPERIENCE_SCORE, measurement: 'avg', timespan: Models::Operations::ListOverallValuesTimespan::TWENTY_FOURHOURS, filterby: 'browser_name:Chrome')

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
| `metric_id`                                                                                                                                                                                                                                                                                                                                                                                                                      | [Models::Operations::ListOverallValuesMetricId](../../models/operations/listoverallvaluesmetricid.md)                                                                                                                                                                                                                                                                                                                            | :heavy_check_mark:                                                                                                                                                                                                                                                                                                                                                                                                               | Pass metric Id<br/>                                                                                                                                                                                                                                                                                                                                                                                                              | quality_of_experience_score                                                                                                                                                                                                                                                                                                                                                                                                      |
| `measurement`                                                                                                                                                                                                                                                                                                                                                                                                                    | *T.nilable(::String)*                                                                                                                                                                                                                                                                                                                                                                                                            | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                               | The measurement for the given metrics.<br/>Possible Values : [95th, median, avg, count or sum]<br/>                                                                                                                                                                                                                                                                                                                              | avg                                                                                                                                                                                                                                                                                                                                                                                                                              |
| `timespan`                                                                                                                                                                                                                                                                                                                                                                                                                       | [T.nilable(Models::Operations::ListOverallValuesTimespan)](../../models/operations/listoverallvaluestimespan.md)                                                                                                                                                                                                                                                                                                                 | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                               | This parameter specifies the time span between which the video views list must be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.<br/><br/>**Accepted formats are:**<br/><br/>array of epoch timestamps for example <br/>`timespan[]=1498867200&timespan[]=1498953600`<br/><br/>duration string for example  <br/>`timespan[]=24:hours` or `timespan[]=7:days`<br/> | 24:hours                                                                                                                                                                                                                                                                                                                                                                                                                         |
| `filterby`                                                                                                                                                                                                                                                                                                                                                                                                                       | *T.nilable(::String)*                                                                                                                                                                                                                                                                                                                                                                                                            | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                               | Pass the dimensions and their corresponding values you want to filter the views by. For excluding the values in the filter we can pass "!" before the filter value. The list of filters can be obtained from list of dimensions endpoint.<br/>Example Values : [ browser_name:Chrome , os_name:macOS , !device_name:Galaxy ]<br/>                                                                                                | browser_name:Chrome                                                                                                                                                                                                                                                                                                                                                                                                              |

### Response

**[T.nilable(Models::Operations::ListOverallValuesResponse)](../../models/operations/listoverallvaluesresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## get_timeseries_data

This endpoint retrieves timeseries data for a specified metric, providing insights into how the metric values change over time. The response includes an array of data points, each representing the metrics value at specific intervals. 

#### Key fields in response

* **intervalTime:** The timestamp for the data point indicating when the metric value was recorded. 
* **metricValue:** The value of the specified metric at the given interval, reflecting the performance or engagement level during that time. 
* **numberOfViews:** The total number of views recorded during that interval, providing context for the metric value.


### Example Usage

<!-- UsageSnippet language="ruby" operationID="get_timeseries_data" method="get" path="/data/metrics/{metricId}/timeseries" -->
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

req = Models::Operations::GetTimeseriesDataRequest.new(
  metric_id: Models::Operations::GetTimeseriesDataMetricId::QUALITY_OF_EXPERIENCE_SCORE,
  timespan: Models::Operations::GetTimeseriesDataTimespan::TWENTY_FOURHOURS,
  filterby: 'browser_name:Chrome',
)

res = s.metrics.get_timeseries_data(request: req)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                           | Type                                                                                                | Required                                                                                            | Description                                                                                         |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| `request`                                                                                           | [Models::Operations::GetTimeseriesDataRequest](../../models/operations/gettimeseriesdatarequest.md) | :heavy_check_mark:                                                                                  | The request object to use for the request.                                                          |

### Response

**[T.nilable(Models::Operations::GetTimeseriesDataResponse)](../../models/operations/gettimeseriesdataresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## list_comparison_values

This endpoint lets you to compare multiple metrics across specified dimensions. You can specify the metrics you want to compare in the query parameters, and the response includes the relevant metrics for the specified dimensions.

#### Key fields in response 

* **value:** The specific metric value calculated based on the applied filters.
* **type:** The data unit or format type (for example, "number", "milliseconds", "percentage").
* **name:** The display name of the metric (for example, "Views", "Overall Score").
* **metric:** The metric field represents the name of the Key Performance Indicator (KPI) being tracked or analyzed. It identifies a specific measurable aspect of the video playback experience, such as buffering time, video start failure rate, or playback quality.
* **items:** Nested breakdown of related metrics for more detailed analysis.
* **measurement:** Defines the aggregation type (for example, "avg", "sum", "median", "95th").

#### How it works 

  1. Before making a request to this endpoint, call the <a href="https://fastpix.com/docs/video-data-api/dimensions/list-dimensions">list dimensions</a> endpoint to obtain all available dimensions that can be used for comparison. 

  2. Send a `GET` request to this endpoint with the desired metrics specified in the query parameters. 

  3. You Receive a response containing the comparison values for the specified metrics across the selected dimensions. 


  Related guide: <a href="https://fastpix.com/docs/video-data/explore-the-dashboard#compare-metrics">Compare metrics in dashboard</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="list_comparison_values" method="get" path="/data/metrics/comparison" -->
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

res = s.metrics.list_comparison_values(timespan: Models::Operations::ListComparisonValuesTimespan::TWENTY_FOURHOURS, filterby: 'browser_name:Chrome', dimension: Models::Operations::Dimension::BROWSER_NAME, value: 'Chrome')

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                                                                                                                       | Type                                                                                                                                                                                                                                                                                                                                                                                                                            | Required                                                                                                                                                                                                                                                                                                                                                                                                                        | Description                                                                                                                                                                                                                                                                                                                                                                                                                     | Example                                                                                                                                                                                                                                                                                                                                                                                                                         |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `timespan`                                                                                                                                                                                                                                                                                                                                                                                                                      | [T.nilable(Models::Operations::ListComparisonValuesTimespan)](../../models/operations/listcomparisonvaluestimespan.md)                                                                                                                                                                                                                                                                                                          | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                              | This parameter specifies the time span between which the video views list must be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.<br/><br/>**Accepted formats are:**<br/><br/>array of epoch timestamps for example <br/>`timespan[]=1498867200&timespan[]=1498953600`<br/><br/>duration string for example <br/>`timespan[]=24:hours` or `timespan[]=7:days`<br/> | 24:hours                                                                                                                                                                                                                                                                                                                                                                                                                        |
| `filterby`                                                                                                                                                                                                                                                                                                                                                                                                                      | *T.nilable(::String)*                                                                                                                                                                                                                                                                                                                                                                                                           | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                              | Pass the dimensions and their corresponding values you want to filter the views by. For excluding the values in the filter we can pass "!" before the filter value. The list of filters can be obtained from list of dimensions endpoint.<br/>Example Values : [ browser_name:Chrome , os_name:macOS , !device_name:Galaxy ]<br/>                                                                                               | browser_name:Chrome                                                                                                                                                                                                                                                                                                                                                                                                             |
| `dimension`                                                                                                                                                                                                                                                                                                                                                                                                                     | [T.nilable(Models::Operations::Dimension)](../../models/operations/dimension.md)                                                                                                                                                                                                                                                                                                                                                | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                              | The dimension id in which the views are watched.<br/>                                                                                                                                                                                                                                                                                                                                                                           | browser_name                                                                                                                                                                                                                                                                                                                                                                                                                    |
| `value`                                                                                                                                                                                                                                                                                                                                                                                                                         | *T.nilable(::String)*                                                                                                                                                                                                                                                                                                                                                                                                           | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                                                                                                                              | The value for the selected dimension. <br/>For example:<br/> If `dimension` is `browser_name`, the value could be  `Chrome` `,` `Firefox` `etc` .<br/> If `dimension` is `os_name`, the value could be `macOS` `,` `Windows` `etc` .<br/>                                                                                                                                                                                       | Chrome                                                                                                                                                                                                                                                                                                                                                                                                                          |

### Response

**[T.nilable(Models::Operations::ListComparisonValuesResponse)](../../models/operations/listcomparisonvaluesresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |