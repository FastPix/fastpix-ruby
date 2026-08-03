# UpdatedMediaRequestBody


## Fields

| Field                                                     | Type                                                      | Required                                                  | Description                                               | Example                                                   |
| --------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- | --------------------------------------------------------- |
| `metadata`                                                | T::Hash[Symbol, *::String*]                               | :heavy_minus_sign:                                        | N/A                                                       | {<br/>"user": "fastpix_admin"<br/>}                       |
| `title`                                                   | *T.nilable(::String)*                                     | :heavy_minus_sign:                                        | Title of the media file.                                  | My Video Title                                            |
| `creator_id`                                              | *T.nilable(::String)*                                     | :heavy_minus_sign:                                        | The unique identifier of the user who created this media. | your-creator-id                                           |