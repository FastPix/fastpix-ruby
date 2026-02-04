# PatchResponseDTO

Displays the result of the request.


## Fields

| Field                                                                                        | Type                                                                                         | Required                                                                                     | Description                                                                                  | Example                                                                                      |
| -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| `success`                                                                                    | *T.nilable(T::Boolean)*                                                                      | :heavy_minus_sign:                                                                           | Shows the request status. Returns true for success and false for failure.                    | true                                                                                         |
| `data`                                                                                       | [T.nilable(Models::Components::PatchResponseData)](../../models/shared/patchresponsedata.md) | :heavy_minus_sign:                                                                           | Displays the result of the request.                                                          |                                                                                              |