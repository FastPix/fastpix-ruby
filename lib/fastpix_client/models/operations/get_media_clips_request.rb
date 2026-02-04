# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class GetMediaClipsRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier assigned to the media when created. The value must be a valid UUID.
        field :media_id, ::String, { 'path_param': { 'field_name': 'mediaId', 'style': 'simple', 'explode': false } }
        # Offset determines the starting point for data retrieval within a paginated list.
        field :offset, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'offset', 'style': 'form', 'explode': true } }
        # The number of media clips to retrieve per request.
        field :limit, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'limit', 'style': 'form', 'explode': true } }
        # The values in the list can be arranged in two ways DESC (Descending) or ASC (Ascending).
        field :order_by, Crystalline::Nilable.new(Models::Components::SortOrder), { 'query_param': { 'field_name': 'orderBy', 'style': 'form', 'explode': true } }

        sig { params(media_id: ::String, offset: T.nilable(::Integer), limit: T.nilable(::Integer), order_by: T.nilable(Models::Components::SortOrder)).void }
        def initialize(media_id:, offset: 1, limit: 10, order_by: Models::Components::SortOrder::DESC)
          @media_id = media_id
          @offset = offset
          @limit = limit
          @order_by = order_by
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @media_id == other.media_id
          return false unless @offset == other.offset
          return false unless @limit == other.limit
          return false unless @order_by == other.order_by
          true
        end
      end
    end
  end
end
