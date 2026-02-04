# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Displays the result of the request.
      class GetPublicPemUsingSigningKeyIdResponseDTOData
        extend T::Sig
        include Crystalline::MetadataFields

        # FastPix generates a unique identifier for each workspace.
        field :workspace_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('workspaceId') } }

        field :signing_key_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('signingKeyId') } }
        # A public key is a byte encoded key used to create a signed JSON Web Token (JWT) for authentication.
        field :public_key, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('publicKey') } }

        sig { params(workspace_id: T.nilable(::String), signing_key_id: T.nilable(::String), public_key: T.nilable(::String)).void }
        def initialize(workspace_id: nil, signing_key_id: nil, public_key: nil)
          @workspace_id = workspace_id
          @signing_key_id = signing_key_id
          @public_key = public_key
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @workspace_id == other.workspace_id
          return false unless @signing_key_id == other.signing_key_id
          return false unless @public_key == other.public_key
          true
        end
      end
    end
  end
end
