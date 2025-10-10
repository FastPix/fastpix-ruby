# SigningKeyNotFoundErrorError

Displays details about the reasons behind the request's failure.


## Fields

| Field                                                       | Type                                                        | Required                                                    | Description                                                 | Example                                                     |
| ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- | ----------------------------------------------------------- |
| `code`                                                      | *T.nilable(::Integer)*                                      | :heavy_minus_sign:                                          | An error code indicating the type of the error.             | 4O4                                                         |
| `message`                                                   | *T.nilable(::String)*                                       | :heavy_minus_sign:                                          | A descriptive message providing more details for the error. | Signing key Not Found                                       |