# CreatePlaylistRequestMetadata

Required when playlist type is smart - media created between startDate and endDate of createdDate will be add, similarily updatedDate (Optional)


## Fields

| Field                                                                        | Type                                                                         | Required                                                                     | Description                                                                  |
| ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| `created_date`                                                               | [T.nilable(Models::Components::DateRange)](../../models/shared/daterange.md) | :heavy_minus_sign:                                                           | Date range with start and end dates.                                         |
| `updated_date`                                                               | [T.nilable(Models::Components::DateRange)](../../models/shared/daterange.md) | :heavy_minus_sign:                                                           | Date range with start and end dates.                                         |