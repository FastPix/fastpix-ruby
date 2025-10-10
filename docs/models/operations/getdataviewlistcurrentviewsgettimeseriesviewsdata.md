# GetDataViewlistCurrentViewsGetTimeseriesViewsData


## Fields

| Field                                                                | Type                                                                 | Required                                                             | Description                                                          |
| -------------------------------------------------------------------- | -------------------------------------------------------------------- | -------------------------------------------------------------------- | -------------------------------------------------------------------- |
| `interval_time`                                                      | [Date](https://ruby-doc.org/stdlib-2.6.1/libdoc/date/rdoc/Date.html) | :heavy_minus_sign:                                                   | The timestamp for the interval (ISO 8601 format).                    |
| `metric_value`                                                       | *T.nilable(::Integer)*                                               | :heavy_minus_sign:                                                   | Reserved for future metric values (currently null).                  |
| `number_of_views`                                                    | *T.nilable(::Integer)*                                               | :heavy_minus_sign:                                                   | Number of concurrent viewers at the given interval.                  |