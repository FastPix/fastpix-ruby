
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GetDrmConfigurationRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Offset determines the starting point for data retrieval within a paginated list.
        field :offset, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'offset', 'style': 'form', 'explode': true } }
        # Limit specifies the maximum number of items to display per page.
        field :limit, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'limit', 'style': 'form', 'explode': true } }

        sig { params(offset: T.nilable(::Integer), limit: T.nilable(::Integer)).void }
        def initialize(offset: 1, limit: 10)
          @offset = offset
          @limit = limit
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @offset == other.offset
          return false unless @limit == other.limit
          true
        end
      end
    end
  end
end
