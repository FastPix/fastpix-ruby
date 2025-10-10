
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GetAllPlaylistsRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The number of playlists to return (default is 10, max is 50).
        field :limit, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'limit', 'style': 'form', 'explode': true } }
        # The page number to retrieve, starting from 1. Used for paginating the playlist results.
        field :offset, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'offset', 'style': 'form', 'explode': true } }

        sig { params(limit: T.nilable(::Integer), offset: T.nilable(::Integer)).void }
        def initialize(limit: 10, offset: 1)
          @limit = limit
          @offset = offset
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @limit == other.limit
          return false unless @offset == other.offset
          true
        end
      end
    end
  end
end
