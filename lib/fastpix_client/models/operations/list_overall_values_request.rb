# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class ListOverallValuesRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Pass metric Id
        # 
        field :metric_id, Models::Operations::ListOverallValuesMetricId, { 'path_param': { 'field_name': 'metricId', 'style': 'simple', 'explode': false } }
        # This parameter specifies the time span between which the video views list must be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.
        # 
        # **Accepted formats are:**
        # 
        # array of epoch timestamps for example 
        # `timespan[]=1498867200&timespan[]=1498953600`
        # 
        # duration string for example  
        # `timespan[]=24:hours` or `timespan[]=7:days`
        # 
        field :timespan, Crystalline::Nilable.new(Models::Operations::ListOverallValuesTimespan), { 'query_param': { 'field_name': 'timespan[]', 'style': 'form', 'explode': true } }
        # Pass the dimensions and their corresponding values you want to filter the views by. For excluding the values in the filter we can pass "!" before the filter value. The list of filters can be obtained from list of dimensions endpoint.
        # Example Values : [ browser_name:Chrome , os_name:macOS , !device_name:Galaxy ]
        # 
        field :filterby, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'filterby[]', 'style': 'form', 'explode': true } }
        # The measurement for the given metrics.
        # Possible Values : [95th, median, avg, count or sum]
        # 
        field :measurement, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'measurement', 'style': 'form', 'explode': true } }

        sig { params(metric_id: Models::Operations::ListOverallValuesMetricId, timespan: T.nilable(Models::Operations::ListOverallValuesTimespan), filterby: T.nilable(::String), measurement: T.nilable(::String)).void }
        def initialize(metric_id:, timespan: nil, filterby: nil, measurement: 'avg')
          @metric_id = metric_id
          @timespan = timespan
          @filterby = filterby
          @measurement = measurement
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @metric_id == other.metric_id
          return false unless @timespan == other.timespan
          return false unless @filterby == other.filterby
          return false unless @measurement == other.measurement
          true
        end
      end
    end
  end
end
