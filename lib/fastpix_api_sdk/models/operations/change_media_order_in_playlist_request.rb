
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class ChangeMediaOrderInPlaylistRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique id of the playlist you want to perform the operation on.
        field :playlist_id, ::String, { 'path_param': { 'field_name': 'playlistId', 'style': 'simple', 'explode': false } }

        field :media_ids_request, Models::Components::MediaIdsRequest, { 'request': { 'media_type': 'application/json' } }

        sig { params(playlist_id: ::String, media_ids_request: Models::Components::MediaIdsRequest).void }
        def initialize(playlist_id:, media_ids_request:)
          @playlist_id = playlist_id
          @media_ids_request = media_ids_request
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @playlist_id == other.playlist_id
          return false unless @media_ids_request == other.media_ids_request
          true
        end
      end
    end
  end
end
