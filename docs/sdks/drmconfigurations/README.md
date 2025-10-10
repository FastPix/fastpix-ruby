# DRMConfigurations
(*drm_configurations*)

## Overview

### Available Operations

* [get_drm_configuration](#get_drm_configuration) - Get list of DRM configuration IDs
* [get_drm_configuration_by_id](#get_drm_configuration_by_id) - Get DRM configuration by ID

## get_drm_configuration


This endpoint retrieves the DRM configuration (DRM ID) associated with a workspace. It returns a list of DRM configurations, identified by a unique DRM ID, which is used for creating DRM encrypted asset.

**How it works:**
1. Make a GET request to this endpoint.  
2. Optionally use the `offset` and `limit` query parameters to paginate through the list of DRM configurations.  
3. The response includes a list of DRM IDs and pagination metadata.

**Example:**  
A media service provider may retrieve DRM configuration for a workspace to create DRM content.

Related guide: <a href="https://docs.fastpix.io/docs/secure-playback-with-drm">Manage DRM configuration</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="getDrmConfiguration" method="get" path="/on-demand/drm-configurations" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.drm_configurations.get_drm_configuration(offset: 1, limit: 10)

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                                                        | Type                                                                             | Required                                                                         | Description                                                                      | Example                                                                          |
| -------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- | -------------------------------------------------------------------------------- |
| `offset`                                                                         | *T.nilable(::Integer)*                                                           | :heavy_minus_sign:                                                               | Offset determines the starting point for data retrieval within a paginated list. | 1                                                                                |
| `limit`                                                                          | *T.nilable(::Integer)*                                                           | :heavy_minus_sign:                                                               | Limit specifies the maximum number of items to display per page.                 | 10                                                                               |

### Response

**[T.nilable(Models::Operations::GetDrmConfigurationResponse)](../../models/operations/getdrmconfigurationresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::BadRequestError         | 400                                     | application/json                        |
| Models::Errors::InvalidPermissionError  | 401                                     | application/json                        |
| Models::Errors::ForbiddenError          | 403                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |

## get_drm_configuration_by_id


This endpoint retrieves a DRM configuration ID. It is used to fetch the DRM-related ID for a workspace, typically required when validating or applying DRM policies to video assets.

**How it works:**
1. Make a GET request to this endpoint, replacing `{drmConfigurationId}` with the UUID of the DRM configuration.  
2. The response will contain the associated DRM configuration ID.

Related guide: <a href="https://docs.fastpix.io/docs/secure-playback-with-drm">Manage DRM configuration</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="getDrmConfigurationById" method="get" path="/on-demand/drm-configurations/{drmConfigurationId}" -->
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

res = s.drm_configurations.get_drm_configuration_by_id(drm_configuration_id: '4fa85f64-5717-4562-b3fc-2c963f66afa6')

unless res.object.nil?
  # handle response
end

```

### Parameters

| Parameter                                       | Type                                            | Required                                        | Description                                     | Example                                         |
| ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- | ----------------------------------------------- |
| `drm_configuration_id`                          | *::String*                                      | :heavy_check_mark:                              | The unique identifier of the DRM configuration. | 4fa85f64-5717-4562-b3fc-2c963f66afa6            |

### Response

**[T.nilable(Models::Operations::GetDrmConfigurationByIdResponse)](../../models/operations/getdrmconfigurationbyidresponse.md)**

### Errors

| Error Type                              | Status Code                             | Content Type                            |
| --------------------------------------- | --------------------------------------- | --------------------------------------- |
| Models::Errors::BadRequestError         | 400                                     | application/json                        |
| Models::Errors::InvalidPermissionError  | 401                                     | application/json                        |
| Models::Errors::ForbiddenError          | 403                                     | application/json                        |
| Models::Errors::MediaNotFoundError      | 404                                     | application/json                        |
| Models::Errors::ValidationErrorResponse | 422                                     | application/json                        |
| Errors::APIError                        | 4XX, 5XX                                | \*/\*                                   |