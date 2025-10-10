# ViewNotFoundError

Returns the problem that has occured


## Fields

| Field                                                       | Type                                                        | Required                                                    | Description                                                 | Example                                                     |
| ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- |
| `code`                                                      | *T.nilable(::Float)*                                        | :heavy_minus_sign:                                          | An error code indicating the type of the error.             | 404                                                         |
| `message`                                                   | *T.nilable(::String)*                                       | :heavy_minus_sign:                                          | A descriptive message providing more details for the error. | View not found                                              |