
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class ListLiveClipsRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The stream Id is unique identifier assigned to the live stream.
        field :livestream_id, ::String, { 'path_param': { 'field_name': 'livestreamId', 'style': 'simple', 'explode': false } }
        # Limit specifies the maximum number of items to display per page.
        field :limit, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'limit', 'style': 'form', 'explode': true } }
        # Offset determines the starting point for data retrieval within a paginated list.
        field :offset, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'offset', 'style': 'form', 'explode': true } }
        # The values in the list can be arranged in two ways: DESC (Descending) or ASC (Ascending).
        field :order_by, Crystalline::Nilable.new(Models::Components::SortOrder), { 'query_param': { 'field_name': 'orderBy', 'style': 'form', 'explode': true } }

        sig { params(livestream_id: ::String, limit: T.nilable(::Integer), offset: T.nilable(::Integer), order_by: T.nilable(Models::Components::SortOrder)).void }
        def initialize(livestream_id:, limit: 10, offset: 1, order_by: Models::Components::SortOrder::DESC)
          @livestream_id = livestream_id
          @limit = limit
          @offset = offset
          @order_by = order_by
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @livestream_id == other.livestream_id
          return false unless @limit == other.limit
          return false unless @offset == other.offset
          return false unless @order_by == other.order_by
          true
        end
      end
    end
  end
end
