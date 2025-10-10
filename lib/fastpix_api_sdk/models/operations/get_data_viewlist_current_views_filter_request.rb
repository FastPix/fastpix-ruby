
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GetDataViewlistCurrentViewsFilterRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The dimension to group and breakdown the concurrent viewers data by.
        # This determines how the results will be categorized and aggregated.
        # Choose from geographic, content, technical, or behavioral dimensions.
        # 
        field :dimension, Crystalline::Nilable.new(Models::Operations::GetDataViewlistCurrentViewsFilterDimension), { 'query_param': { 'field_name': 'dimension', 'style': 'form', 'explode': true } }
        # Maximum number of results to return. Controls the number of dimension values
        # that will be included in the response. Useful for pagination and performance.
        # Higher limits provide more detailed breakdowns but may impact response time.
        # 
        field :limit, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'limit', 'style': 'form', 'explode': true } }

        sig { params(dimension: T.nilable(Models::Operations::GetDataViewlistCurrentViewsFilterDimension), limit: T.nilable(::Integer)).void }
        def initialize(dimension: nil, limit: 10)
          @dimension = dimension
          @limit = limit
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @dimension == other.dimension
          return false unless @limit == other.limit
          true
        end
      end
    end
  end
end
