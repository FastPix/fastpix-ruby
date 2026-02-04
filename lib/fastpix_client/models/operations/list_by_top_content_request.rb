# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class ListByTopContentRequest
        extend T::Sig
        include Crystalline::MetadataFields

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
        field :timespan, Crystalline::Nilable.new(Models::Operations::ListByTopContentTimespan), { 'query_param': { 'field_name': 'timespan[]', 'style': 'form', 'explode': true } }
        # Pass the dimensions and their corresponding values you want to filter the views by. For excluding the values in the filter we can pass "!" before the filter value. The list of filters can be obtained from list of dimensions endpoint.
        # Example Values : [ browser_name:Chrome , os_name:macOS , !device_name:Galaxy ]
        # 
        field :filterby, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'filterby[]', 'style': 'form', 'explode': true } }
        # Pass the limit to display only the rows specified by the value.
        # 
        field :limit, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'limit', 'style': 'form', 'explode': true } }

        sig { params(timespan: T.nilable(Models::Operations::ListByTopContentTimespan), filterby: T.nilable(::String), limit: T.nilable(::Integer)).void }
        def initialize(timespan: nil, filterby: nil, limit: 10)
          @timespan = timespan
          @filterby = filterby
          @limit = limit
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @timespan == other.timespan
          return false unless @filterby == other.filterby
          return false unless @limit == other.limit
          true
        end
      end
    end
  end
end
