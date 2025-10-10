
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class DeleteAPlaylistResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # HTTP response content type for this operation
        field :content_type, ::String
        # HTTP response status code for this operation
        field :status_code, ::Integer
        # Raw HTTP response; suitable for custom response parsing
        field :raw_response, ::Faraday::Response
        # Playlist deleted successfully
        field :success_response, Crystalline::Nilable.new(Models::Components::SuccessResponse)

        sig { params(content_type: ::String, status_code: ::Integer, raw_response: ::Faraday::Response, success_response: T.nilable(Models::Components::SuccessResponse)).void }
        def initialize(content_type:, status_code:, raw_response:, success_response: nil)
          @content_type = content_type
          @status_code = status_code
          @raw_response = raw_response
          @success_response = success_response
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @content_type == other.content_type
          return false unless @status_code == other.status_code
          return false unless @raw_response == other.raw_response
          return false unless @success_response == other.success_response
          true
        end
      end
    end
  end
end
