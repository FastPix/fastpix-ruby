# SigningKeysPagination

Pagination organizes content into pages for better readability and navigation.


## Fields

| Field                                                                           | Type                                                                            | Required                                                                        | Description                                                                     | Example                                                                         |
| ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| `total_records`                                                                 | *T.nilable(::Integer)*                                                          | :heavy_minus_sign:                                                              | It gives the total number of Signing keys that are created by a user.           | 1                                                                               |
| `current_offset`                                                                | *T.nilable(::Integer)*                                                          | :heavy_minus_sign:                                                              | Offset determines the current point for data retrieval within a paginated list. | 1                                                                               |
| `offset_count`                                                                  | *T.nilable(::Integer)*                                                          | :heavy_minus_sign:                                                              | The offset count is expressed as total records by limit                         | 10                                                                              |