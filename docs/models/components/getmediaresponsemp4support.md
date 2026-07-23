# GetMediaResponseMp4Support

One MP4 rendition generated for the media when MP4 support is requested.


## Fields

| Field | Type | Required | Description |
| ----- | ---- | -------- | ----------- |
| `type` | *T.nilable(::String)* | :heavy_minus_sign: | The MP4 rendition type. `capped_4k` is a downloadable MP4 video capped at 4K resolution, `audioOnly` is a downloadable m4a audio-only file. |
| `status` | *T.nilable(::String)* | :heavy_minus_sign: | Generation status of this MP4 rendition. One of `preparing`, `ready`, or `failed`. |
| `height` | *T.nilable(::Integer)* | :heavy_minus_sign: | Pixel height of the rendition. Omitted for the `audioOnly` type. |
| `width` | *T.nilable(::Integer)* | :heavy_minus_sign: | Pixel width of the rendition. Omitted for the `audioOnly` type. |
| `ext` | *T.nilable(::String)* | :heavy_minus_sign: | File extension of the downloadable rendition. |
