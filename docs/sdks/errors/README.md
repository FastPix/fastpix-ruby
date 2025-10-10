# Errors
(*errors*)

## Overview

### Available Operations

* [list_errors](#list_errors) - List errors

## list_errors

This endpoint returns the total number of playback errors that occurred, along with the total number of views captured, based on the specified timespan and filters. It provides insights into the overall playback quality and helps identify potential issues that may impact viewer experience. 


#### Key fields in response

* **percentage:** The percentage of views affected by the specific error. 
* **uniqueViewersEffectedPercentage:** The percentage of unique viewers affected by the specific error (available only in the topErrors section). 
* **notes:** Additional notes or information about the specific error. 
* **message:** The error message or description. 
* **lastSeen:** The timestamp of when the error was last observed. 
* **id:** The unique identifier for the specific error. 
* **description:** A description of the specific error. 
* **count:** The number of occurrences of the specific error. 
* **code:** The error code associated with the specific error. 


Related guide: <a href="https://docs.fastpix.io/docs/track-playback-errors">Troubleshoot errors</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="list_errors" method="get" path="/data/errors" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.errors.list_errors(timespan: Models::Operations::ListErrorsTimespan::SEVENDAYS, filterby: 'browser_name:Chrome', limit: 1)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                                                                                                                                                                                                                                                                | Type                                                                                                                                                                                                                                                                                                                     | Required                                                                                                                                                                                                                                                                                                                 | Description                                                                                                                                                                                                                                                                                                              | Example                                                                                                                                                                                                                                                                                                                  |
| ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `timespan`                                                                                                                                                                                                                                                                                                               | [Models::Operations::ListErrorsTimespan](../../models/operations/listerrorstimespan.md)                                                                                                                                                                                                                                  | :heavy_check_mark:                                                                                                                                                                                                                                                                                                       | This parameter specifies the time span between which the video views list should be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.<br/>                                                                                | 7:days                                                                                                                                                                                                                                                                                                                   |
| `filterby`                                                                                                                                                                                                                                                                                                               | *T.nilable(::String)*                                                                                                                                                                                                                                                                                                    | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                       | Pass the dimensions and their corresponding values you want to filter the views by. For excluding the values in the filter we can pass '!' before the filter value. The list of filters can be obtained from list of dimensions endpoint.<br/>Example Values : [ browser_name:Chrome , os_name:macOS , device_name:Galaxy ]<br/> | browser_name:Chrome                                                                                                                                                                                                                                                                                                      |
| `limit`                                                                                                                                                                                                                                                                                                                  | *T.nilable(::Integer)*                                                                                                                                                                                                                                                                                                   | :heavy_minus_sign:                                                                                                                                                                                                                                                                                                       | Pass the limit to display only the rows specified by the value for top errors.<br/>                                                                                                                                                                                                                                      | 1                                                                                                                                                                                                                                                                                                                        |

### Response

**[T.nilable(Models::Operations::ListErrorsResponse)](../../models/operations/listerrorsresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::InvalidPermissionError  | 401                                     | application/json                        |
| Models::Errors::ViewNotFoundError       | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |