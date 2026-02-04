# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class ListSigningKeysRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Limit specifies the maximum number of items to display per page.
        field :limit, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'limit', 'style': 'form', 'explode': true } }
        # It is used for pagination, indicating the starting point for fetching data.  
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
