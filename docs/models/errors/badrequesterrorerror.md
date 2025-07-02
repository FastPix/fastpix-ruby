# BadRequestErrorError

Displays details about the reasons behind the request's failure.


## Fields

| Field                                                         | Type                                                          | Required                                                      | Description                                                   | Example                                                       |
| ------------------------------------------------------------- | ------------------------------------------------------------- | ------------------------------------------------------------- | ------------------------------------------------------------- | ------------------------------------------------------------- |
| `code`                                                        | *T.nilable(::Float)*                                          | :heavy_minus_sign:                                            | Displays the error code indicating the type of the error.     | 400                                                           |
| `message`                                                     | *T.nilable(::String)*                                         | :heavy_minus_sign:                                            | A descriptive message providing more details for the error.   | Bad Request                                                   |
| `description`                                                 | *T.nilable(::String)*                                         | :heavy_minus_sign:                                            | A detailed explanation of the possible causes for the error.<br/> | trial plan limits reached. Please upgrade plan to continue    |