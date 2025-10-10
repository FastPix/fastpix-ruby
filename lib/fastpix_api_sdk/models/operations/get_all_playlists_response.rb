
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GetAllPlaylistsResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # HTTP response content type for this operation
        field :content_type, ::String
        # HTTP response status code for this operation
        field :status_code, ::Integer
        # Raw HTTP response; suitable for custom response parsing
        field :raw_response, ::Faraday::Response
        # Successfully retrieved all playlists
        field :get_all_playlists_response, Crystalline::Nilable.new(Models::Components::GetAllPlaylistsResponse)

        sig { params(content_type: ::String, status_code: ::Integer, raw_response: ::Faraday::Response, get_all_playlists_response: T.nilable(Models::Components::GetAllPlaylistsResponse)).void }
        def initialize(content_type:, status_code:, raw_response:, get_all_playlists_response: nil)
          @content_type = content_type
          @status_code = status_code
          @raw_response = raw_response
          @get_all_playlists_response = get_all_playlists_response
        end

        # Alias for get_all_playlists_response to match test expectations
        sig { returns(T.nilable(Models::Components::GetAllPlaylistsResponse)) }
        def object
          @get_all_playlists_response
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @content_type == other.content_type
          return false unless @status_code == other.status_code
          return false unless @raw_response == other.raw_response
          return false unless @get_all_playlists_response == other.get_all_playlists_response
          true
        end
      end
    end
  end
end
