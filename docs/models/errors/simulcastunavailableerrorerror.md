# SimulcastUnavailableErrorError

Returns the problem that has occured.



## Fields

| Field                                                                          | Type                                                                           | Required                                                                       | Description                                                                    | Example                                                                        |
| ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ | ------------------------------------------------------------------------------ |
| `code`                                                                         | *T.nilable(::Integer)*                                                         | :heavy_minus_sign:                                                             | An error code indicating the type of the error.<br/>                           | 400                                                                            |
| `message`                                                                      | *T.nilable(::String)*                                                          | :heavy_minus_sign:                                                             | A descriptive message providing more details for the error<br/>                | Simulcast is not available for trial streams                                   |
| `description`                                                                  | *T.nilable(::String)*                                                          | :heavy_minus_sign:                                                             | A detailed explanation of the possible causes for the error.<br/>              | The requested resource (eg:streamId/playbackId) doesn't exist in the workspace |