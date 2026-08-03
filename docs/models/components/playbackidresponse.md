# PlaybackIdResponse

A collection of Playback ID objects utilized for crafting HLS playback urls.


## Fields

| Field                                                                             | Type                                                                              | Required                                                                          | Description                                                                       | Example                                                                           |
| --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| `id`                                                                              | *T.nilable(::String)*                                                             | :heavy_minus_sign:                                                                | Unique identifier for the playbackId                                              | your-playback-id                                                                  |
| `access_policy`                                                                   | *T.nilable(::String)*                                                             | :heavy_minus_sign:                                                                | Determines if access to the streamed content is kept private or available to all. | public                                                                            |