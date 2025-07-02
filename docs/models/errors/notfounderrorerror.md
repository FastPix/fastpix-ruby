# NotFoundErrorError

Displays details about the reasons behind the request's failure.


## Fields

| Field                                                               | Type                                                                | Required                                                            | Description                                                         | Example                                                             |
| ------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------- | ------------------------------------------------------------------- |
| `code`                                                              | *T.nilable(::Float)*                                                | :heavy_minus_sign:                                                  | Displays the error code indicating the type of the error.           | 404                                                                 |
| `message`                                                           | *T.nilable(::String)*                                               | :heavy_minus_sign:                                                  | A descriptive message providing more details for the error.         | stream not found                                                    |
| `description`                                                       | *T.nilable(::String)*                                               | :heavy_minus_sign:                                                  | A detailed explanation of the possible causes for the error.<br/>   | The requested resource (eg:streamId) doesn't exist in the workspace |