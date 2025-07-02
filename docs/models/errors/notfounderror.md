# NotFoundError


## Fields

| Field                                                                                      | Type                                                                                       | Required                                                                                   | Description                                                                                |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------ |
| `success`                                                                                  | *T.nilable(T::Boolean)*                                                                    | :heavy_minus_sign:                                                                         | Demonstrates whether the request is successful or not.                                     |
| `error`                                                                                    | [T.nilable(Models::Errors::NotFoundErrorError)](../../models/errors/notfounderrorerror.md) | :heavy_minus_sign:                                                                         | Displays details about the reasons behind the request's failure.                           |