
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GetSigningKeyByIdResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # HTTP response content type for this operation
        field :content_type, ::String
        # HTTP response status code for this operation
        field :status_code, ::Integer
        # Raw HTTP response; suitable for custom response parsing
        field :raw_response, ::Faraday::Response
        # successfully fetched signing key
        field :get_public_pem_using_signing_key_id_response_dto, Crystalline::Nilable.new(Models::Components::GetPublicPemUsingSigningKeyIdResponseDTO)

        sig { params(content_type: ::String, status_code: ::Integer, raw_response: ::Faraday::Response, get_public_pem_using_signing_key_id_response_dto: T.nilable(Models::Components::GetPublicPemUsingSigningKeyIdResponseDTO)).void }
        def initialize(content_type:, status_code:, raw_response:, get_public_pem_using_signing_key_id_response_dto: nil)
          @content_type = content_type
          @status_code = status_code
          @raw_response = raw_response
          @get_public_pem_using_signing_key_id_response_dto = get_public_pem_using_signing_key_id_response_dto
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @content_type == other.content_type
          return false unless @status_code == other.status_code
          return false unless @raw_response == other.raw_response
          return false unless @get_public_pem_using_signing_key_id_response_dto == other.get_public_pem_using_signing_key_id_response_dto
          true
        end
      end
    end
  end
end
