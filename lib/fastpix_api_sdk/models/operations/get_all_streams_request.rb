
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GetAllStreamsRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Limit specifies the maximum number of items to display per page.
        field :limit, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'limit', 'style': 'form', 'explode': true } }
        # Offset determines the starting point for data retrieval within a paginated list.
        field :offset, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'offset', 'style': 'form', 'explode': true } }
        # The list of value can be order in two ways DESC (Descending) or ASC (Ascending). In case not specified, by default it will be DESC.
        field :order_by, Crystalline::Nilable.new(Models::Operations::OrderBy), { 'query_param': { 'field_name': 'orderBy', 'style': 'form', 'explode': true } }

        sig { params(limit: T.nilable(::Integer), offset: T.nilable(::Integer), order_by: T.nilable(Models::Operations::OrderBy)).void }
        def initialize(limit: 10, offset: 1, order_by: Models::Operations::OrderBy::DESC)
          @limit = limit
          @offset = offset
          @order_by = order_by
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @limit == other.limit
          return false unless @offset == other.offset
          return false unless @order_by == other.order_by
          true
        end
      end
    end
  end
end
