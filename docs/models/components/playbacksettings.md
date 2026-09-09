# PlaybackSettings

Displays the result of the playback settings.


## Fields

| Field                                                                                        | Type                                                                                         | Required                                                                                     | Description                                                                                  |
| -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| `access_policy`                                                                              | [T.nilable(Models::Components::BasicAccessPolicy)](../../models/shared/basicaccesspolicy.md) | :heavy_minus_sign:                                                                           | Basic access policy for media content                                                        |
| `access_restrictions` | [T.nilable(Models::Components::PlaybackIdAccessRestrictions)](../../models/components/playbackidaccessrestrictions.md) | :heavy_minus_sign: | Domain and user-agent access restrictions applied to the live playback ID. |
