# MediaClipResponsePagination


## Fields

| Field                                                 | Type                                                  | Required                                              | Description                                           | Example                                               |
| ----------------------------------------------------- | ----------------------------------------------------- | ----------------------------------------------------- | ----------------------------------------------------- | ----------------------------------------------------- |
| `total_records`                                       | *T.nilable(::Integer)*                                | :heavy_minus_sign:                                    | Total number of records available.                    | 4                                                     |
| `current_offset`                                      | *T.nilable(::Integer)*                                | :heavy_minus_sign:                                    | The starting offset of the current result set.        | 1                                                     |
| `offset_count`                                        | *T.nilable(::Integer)*                                | :heavy_minus_sign:                                    | The number of items returned in the current response. | 4                                                     |