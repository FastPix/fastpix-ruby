# MetricsTimeseriesDataDetails

The metrics value at specific time intervals.


## Fields

| Field                                                                           | Type                                                                            | Required                                                                        | Description                                                                     | Example                                                                         |
| ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------- |
| `interval_time`                                                                 | [Date](https://ruby-doc.org/stdlib-2.6.1/libdoc/date/rdoc/Date.html)            | :heavy_minus_sign:                                                              | The timestamp for the data point indicating when the metric value was recorded. | 2023-12-04T14:00:00.000Z                                                        |
| `metric_value`                                                                  | *T.nilable(::Float)*                                                            | :heavy_minus_sign:                                                              | The value of the specified metric at the given interval.                        | 0.793110142151515                                                               |
| `number_of_views`                                                               | *T.nilable(::Integer)*                                                          | :heavy_minus_sign:                                                              | The total number of views recorded during that interval.                        | 143244                                                                          |