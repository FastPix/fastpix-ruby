
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GetDataViewlistCurrentViewsGetTimeseriesViewsData
        extend T::Sig
        include Crystalline::MetadataFields

        # The timestamp for the interval (ISO 8601 format).
        field :interval_time, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('intervalTime'), 'decoder': Utils.datetime_from_iso_format(true) } }
        # Number of concurrent viewers at the given interval.
        field :number_of_views, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('numberOfViews') } }
        # Reserved for future metric values (currently null).
        field :metric_value, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metricValue') } }

        sig { params(interval_time: T.nilable(::DateTime), number_of_views: T.nilable(::Integer), metric_value: T.nilable(::Integer)).void }
        def initialize(interval_time: nil, number_of_views: nil, metric_value: nil)
          @interval_time = interval_time
          @number_of_views = number_of_views
          @metric_value = metric_value
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @interval_time == other.interval_time
          return false unless @number_of_views == other.number_of_views
          return false unless @metric_value == other.metric_value
          true
        end
      end
    end
  end
end
