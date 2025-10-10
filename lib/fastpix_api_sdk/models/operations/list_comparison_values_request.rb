
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class ListComparisonValuesRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # This parameter specifies the time span between which the video views list should be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.
        # 
        field :timespan, Models::Operations::ListComparisonValuesTimespan, { 'query_param': { 'field_name': 'timespan[]', 'style': 'form', 'explode': true } }
        # Pass the dimensions and their corresponding values you want to filter the views by. For excluding the values in the filter we can pass '!' before the filter value. The list of filters can be obtained from list of dimensions endpoint.
        # Example Values : [ browser_name:Chrome , os_name:macOS , device_name:Galaxy ]
        # 
        field :filterby, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'filterby[]', 'style': 'form', 'explode': true } }
        # The dimension id in which the views are watched.
        # 
        field :dimension, Crystalline::Nilable.new(Models::Operations::ListComparisonValuesDimension), { 'query_param': { 'field_name': 'dimension', 'style': 'form', 'explode': true } }
        # The value for the selected dimension. 
        # For example:
        #  If `dimension` is `browser_name`, the value could be  `Chrome` `,` `Firefox` `etc` .
        #  If `dimension` is `os_name`, the value could be `macOS` `,` `Windows` `etc` .
        # 
        field :value, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'value', 'style': 'form', 'explode': true } }

        sig { params(timespan: Models::Operations::ListComparisonValuesTimespan, filterby: T.nilable(::String), dimension: T.nilable(Models::Operations::ListComparisonValuesDimension), value: T.nilable(::String)).void }
        def initialize(timespan:, filterby: nil, dimension: nil, value: nil)
          @timespan = timespan
          @filterby = filterby
          @dimension = dimension
          @value = value
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @timespan == other.timespan
          return false unless @filterby == other.filterby
          return false unless @dimension == other.dimension
          return false unless @value == other.value
          true
        end
      end
    end
  end
end
