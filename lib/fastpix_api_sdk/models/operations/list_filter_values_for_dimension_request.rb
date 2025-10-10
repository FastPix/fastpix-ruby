
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class ListFilterValuesForDimensionRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Pass Dimensions id
        # 
        field :dimensions_id, Models::Operations::DimensionsId, { 'path_param': { 'field_name': 'dimensionsId', 'style': 'simple', 'explode': false } }
        # This parameter specifies the time span between which the video views list should be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.
        # 
        field :timespan, Models::Operations::ListFilterValuesForDimensionTimespan, { 'query_param': { 'field_name': 'timespan[]', 'style': 'form', 'explode': true } }
        # Pass the dimensions and their corresponding values you want to filter the views by. For excluding the values in the filter we can pass '!' before the filter value. The list of filters can be obtained from list of dimensions endpoint.
        # Example Values : [ browser_name:Chrome , os_name:macOS , device_name:Galaxy ]
        # 
        field :filterby, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'filterby[]', 'style': 'form', 'explode': true } }

        sig { params(dimensions_id: Models::Operations::DimensionsId, timespan: Models::Operations::ListFilterValuesForDimensionTimespan, filterby: T.nilable(::String)).void }
        def initialize(dimensions_id:, timespan:, filterby: nil)
          @dimensions_id = dimensions_id
          @timespan = timespan
          @filterby = filterby
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @dimensions_id == other.dimensions_id
          return false unless @timespan == other.timespan
          return false unless @filterby == other.filterby
          true
        end
      end
    end
  end
end
