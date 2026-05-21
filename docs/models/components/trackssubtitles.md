# TracksSubtitles


## Fields

| Field                                                           | Type                                                            | Required                                                        | Description                                                     | Example                                                         |
| --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- | --------------------------------------------------------------- |
| `status`                                                        | *T.nilable(::String)*                                           | :heavy_minus_sign:                                              | Current status of the generated subtitle track.                 | preparing                                                       |
| `url`                                                           | *T.nilable(::String)*                                           | :heavy_minus_sign:                                              | URL of the generated subtitle file (VTT). Null while preparing. | https://stream.fastpix.com/subtitles/abc123.vtt                  |