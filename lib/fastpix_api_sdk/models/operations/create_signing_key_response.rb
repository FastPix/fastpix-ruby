
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class CreateSigningKeyResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # HTTP response content type for this operation
        field :content_type, ::String
        # HTTP response status code for this operation
        field :status_code, ::Integer
        # Raw HTTP response; suitable for custom response parsing
        field :raw_response, ::Faraday::Response
        # created a signing key successfully
        field :create_response, Crystalline::Nilable.new(Models::Components::CreateResponse)

        sig { params(content_type: ::String, status_code: ::Integer, raw_response: ::Faraday::Response, create_response: T.nilable(Models::Components::CreateResponse)).void }
        def initialize(content_type:, status_code:, raw_response:, create_response: nil)
          @content_type = content_type
          @status_code = status_code
          @raw_response = raw_response
          @create_response = create_response
        end

        # Alias for create_response to match test expectations
        sig { returns(T.nilable(Models::Components::CreateResponse)) }
        def object
          @create_response
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @content_type == other.content_type
          return false unless @status_code == other.status_code
          return false unless @raw_response == other.raw_response
          return false unless @create_response == other.create_response
          true
        end
      end
    end
  end
end
