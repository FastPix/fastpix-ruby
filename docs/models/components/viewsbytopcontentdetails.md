# ViewsByTopContentDetails

Retrieves a list of the top video views


## Fields

| Field                                                             | Type                                                              | Required                                                          | Description                                                       | Example                                                           |
| ----------------------------------------------------------------- | ----------------------------------------------------------------- | ----------------------------------------------------------------- | ----------------------------------------------------------------- | ----------------------------------------------------------------- |
| `video_title`                                                     | *T.nilable(::String)*                                             | :heavy_minus_sign:                                                | Title of the video                                                | example video title                                               |
| `views`                                                           | *T.nilable(::Integer)*                                            | :heavy_minus_sign:                                                | Total count of view sessions for a paricular video content.       | 44                                                                |
| `unique_views`                                                    | *T.nilable(::Integer)*                                            | :heavy_minus_sign:                                                | Total count of unique video viewers for particular video content. | 40                                                                |