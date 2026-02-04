# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # The metrics value at specific time intervals.
      class MetricsTimeseriesDataDetails
        extend T::Sig
        include Crystalline::MetadataFields

        # The timestamp for the data point indicating when the metric value was recorded.
        field :interval_time, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('intervalTime'), 'decoder': Utils.datetime_from_iso_format(true) } }
        # The value of the specified metric at the given interval.
        field :metric_value, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metricValue') } }
        # The total number of views recorded during that interval.
        field :number_of_views, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('numberOfViews') } }

        sig { params(interval_time: T.nilable(::DateTime), metric_value: T.nilable(::Float), number_of_views: T.nilable(::Integer)).void }
        def initialize(interval_time: nil, metric_value: nil, number_of_views: nil)
          @interval_time = interval_time
          @metric_value = metric_value
          @number_of_views = number_of_views
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @interval_time == other.interval_time
          return false unless @metric_value == other.metric_value
          return false unless @number_of_views == other.number_of_views
          true
        end
      end
    end
  end
end
