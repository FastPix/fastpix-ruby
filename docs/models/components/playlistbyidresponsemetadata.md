# PlaylistByIdResponseMetadata

Required when the playlist type is `smart`. Media created between `startDate` and `endDate` of `createdDate` is added. Optionally, you can include media based on `updatedDate`.


## Fields

| Field                                                                        | Type                                                                         | Required                                                                     | Description                                                                  |
| ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| `created_date`                                                               | [T.nilable(Models::Components::DateRange)](../../models/shared/daterange.md) | :heavy_minus_sign:                                                           | Date range with start and end dates.                                         |
| `updated_date`                                                               | [T.nilable(Models::Components::DateRange)](../../models/shared/daterange.md) | :heavy_minus_sign:                                                           | Date range with start and end dates.                                         |