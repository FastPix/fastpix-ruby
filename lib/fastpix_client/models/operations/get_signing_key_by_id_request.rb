# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class GetSigningKeyByIdRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # When creating the signing key, FastPix assigns a universally unique identifier with a maximum length of 255 characters. 
        field :signing_key_id, ::String, { 'path_param': { 'field_name': 'signingKeyId', 'style': 'simple', 'explode': false } }

        sig { params(signing_key_id: ::String).void }
        def initialize(signing_key_id:)
          @signing_key_id = signing_key_id
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @signing_key_id == other.signing_key_id
          true
        end
      end
    end
  end
end
