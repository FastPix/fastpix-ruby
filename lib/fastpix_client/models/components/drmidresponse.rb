# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class DrmIdResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier of the DRM configuration.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('id') } }

        sig { params(id: T.nilable(::String)).void }
        def initialize(id: nil)
          @id = id
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          true
        end
      end
    end
  end
end
