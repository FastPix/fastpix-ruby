# DataPagination

Pagination organizes content into pages for better readability and navigation.


## Fields

| Field                                                        | Type                                                         | Required                                                     | Description                                                  | Example                                                      |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| `total_records`                                              | *T.nilable(::Integer)*                                       | :heavy_minus_sign:                                           | The total number of records retrieved within the timeframe.<br/> | 2                                                            |
| `current_offset`                                             | *T.nilable(::Integer)*                                       | :heavy_minus_sign:                                           | The current offset value. <br/><br/>Default: 1<br/>          | 1                                                            |
| `offset_count`                                               | *T.nilable(::Integer)*                                       | :heavy_minus_sign:                                           | The total number of offsets based on limit.<br/>             | 1                                                            |