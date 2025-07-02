# ListMediaResponseBody

List of video media


## Fields

| Field                                                                          | Type                                                                           | Required                                                                       | Description                                                                    | Example                                                                        |
| ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ |
| `success`                                                                      | *T.nilable(T::Boolean)*                                                        | :heavy_minus_sign:                                                             | Demonstrates whether the request is successful or not.                         | true                                                                           |
| `data`                                                                         | T::Array<[Models::Components::Media](../../models/shared/media.md)>            | :heavy_minus_sign:                                                             | Displays the result of the request.                                            |                                                                                |
| `pagination`                                                                   | [T.nilable(Models::Components::Pagination)](../../models/shared/pagination.md) | :heavy_minus_sign:                                                             | Pagination organizes content into pages for better readability and navigation. |                                                                                |