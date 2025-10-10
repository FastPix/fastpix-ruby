
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class CreateAPlaylistResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # HTTP response content type for this operation
        field :content_type, ::String
        # HTTP response status code for this operation
        field :status_code, ::Integer
        # Raw HTTP response; suitable for custom response parsing
        field :raw_response, ::Faraday::Response
        # Playlist created successfully
        field :playlist_created_response, Crystalline::Nilable.new(Models::Components::PlaylistCreatedResponse)

        sig { params(content_type: ::String, status_code: ::Integer, raw_response: ::Faraday::Response, playlist_created_response: T.nilable(Models::Components::PlaylistCreatedResponse)).void }
        def initialize(content_type:, status_code:, raw_response:, playlist_created_response: nil)
          @content_type = content_type
          @status_code = status_code
          @raw_response = raw_response
          @playlist_created_response = playlist_created_response
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @content_type == other.content_type
          return false unless @status_code == other.status_code
          return false unless @raw_response == other.raw_response
          return false unless @playlist_created_response == other.playlist_created_response
          true
        end
      end
    end
  end
end
