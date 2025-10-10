
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GetTimeseriesDataRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Pass metric Id
        # 
        field :metric_id, Models::Operations::GetTimeseriesDataMetricId, { 'path_param': { 'field_name': 'metricId', 'style': 'simple', 'explode': false } }
        # This parameter specifies the time span between which the video views list should be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.
        # 
        field :timespan, Models::Operations::GetTimeseriesDataTimespan, { 'query_param': { 'field_name': 'timespan[]', 'style': 'form', 'explode': true } }
        # Pass the dimensions and their corresponding values you want to filter the views by. For excluding the values in the filter we can pass '!' before the filter value. The list of filters can be obtained from list of dimensions endpoint.
        # Example Values : [ browser_name:Chrome , os_name:macOS , device_name:Galaxy ]
        # 
        field :filterby, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'filterby[]', 'style': 'form', 'explode': true } }
        # Pass this value to group the metrics list by.
        # 
        field :group_by, Crystalline::Nilable.new(Models::Operations::GroupBy), { 'query_param': { 'field_name': 'groupBy', 'style': 'form', 'explode': true } }
        # The order direction to sort the metrics list by.
        # 
        field :sort_order, Crystalline::Nilable.new(Models::Operations::GetTimeseriesDataSortOrder), { 'query_param': { 'field_name': 'sortOrder', 'style': 'form', 'explode': true } }
        # The measurement for the given metrics.
        # Possible Values : [95th, median, avg, count or sum]
        # 
        field :measurement, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'measurement', 'style': 'form', 'explode': true } }

        sig { params(metric_id: Models::Operations::GetTimeseriesDataMetricId, timespan: Models::Operations::GetTimeseriesDataTimespan, filterby: T.nilable(::String), group_by: T.nilable(Models::Operations::GroupBy), sort_order: T.nilable(Models::Operations::GetTimeseriesDataSortOrder), measurement: T.nilable(::String)).void }
        def initialize(metric_id:, timespan:, filterby: nil, group_by: Models::Operations::GroupBy::MINUTE, sort_order: Models::Operations::GetTimeseriesDataSortOrder::ASC, measurement: 'avg')
          @metric_id = metric_id
          @timespan = timespan
          @filterby = filterby
          @group_by = group_by
          @sort_order = sort_order
          @measurement = measurement
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @metric_id == other.metric_id
          return false unless @timespan == other.timespan
          return false unless @filterby == other.filterby
          return false unless @group_by == other.group_by
          return false unless @sort_order == other.sort_order
          return false unless @measurement == other.measurement
          true
        end
      end
    end
  end
end
