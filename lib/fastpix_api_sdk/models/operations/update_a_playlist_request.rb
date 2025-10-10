
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class UpdateAPlaylistRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique id of the playlist you want to retrieve.
        field :playlist_id, ::String, { 'path_param': { 'field_name': 'playlistId', 'style': 'simple', 'explode': false } }

        field :update_playlist_request, Models::Components::UpdatePlaylistRequest, { 'request': { 'media_type': 'application/json' } }

        sig { params(playlist_id: ::String, update_playlist_request: Models::Components::UpdatePlaylistRequest).void }
        def initialize(playlist_id:, update_playlist_request:)
          @playlist_id = playlist_id
          @update_playlist_request = update_playlist_request
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @playlist_id == other.playlist_id
          return false unless @update_playlist_request == other.update_playlist_request
          true
        end
      end
    end
  end
end
