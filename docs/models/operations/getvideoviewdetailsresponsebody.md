# GetVideoViewDetailsResponseBody

Get a video view by id


## Fields

| Field                                                                     | Type                                                                      | Required                                                                  | Description                                                               |
| ------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ------------------------------------------------------------------------- | ------------------------------------------------------------------------- |
| `success`                                                                 | *T.nilable(T::Boolean)*                                                   | :heavy_minus_sign:                                                        | Shows the request status. Returns true for success and false for failure. |
| `data`                                                                    | [T.nilable(Models::Components::Views)](../../models/shared/views.md)      | :heavy_minus_sign:                                                        | Displays the result of the request.                                       |