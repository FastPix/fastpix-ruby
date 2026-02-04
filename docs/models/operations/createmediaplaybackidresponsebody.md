# CreateMediaPlaybackIdResponseBody

Playback ID for a media content.


## Fields

| Field                                                                                      | Type                                                                                       | Required                                                                                   | Description                                                                                | Example                                                                                    |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| `success`                                                                                  | *T.nilable(T::Boolean)*                                                                    | :heavy_minus_sign:                                                                         | Shows the request status. Returns true for success and false for failure.                  | true                                                                                       |
| `data`                                                                                     | [T.nilable(Models::Components::CreatePlaybackId)](../../models/shared/createplaybackid.md) | :heavy_minus_sign:                                                                         | A collection of Playback ID objects utilized for crafting HLS playback urls.               |                                                                                            |