# ListErrorsData

Displays the result of the request.


## Fields

| Field                                                                                                              | Type                                                                                                               | Required                                                                                                           | Description                                                                                                        |
| ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------ |
| `errors`                                                                                                           | T::Array<[Models::Components::ErrorDetails](../../models/shared/errordetails.md)>                                  | :heavy_minus_sign:                                                                                                 | Retrieves a list of errors that have occurred in the system.                                                       |
| `top_errors`                                                                                                       | T::Array<[Models::Components::TopErrorDetails](../../models/shared/toperrordetails.md)>                            | :heavy_minus_sign:                                                                                                 | Retrieves a list of errors that have occurred most frequently in the system, ranked by their count of occurrences. |