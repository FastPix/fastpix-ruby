# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class AddMediaToPlaylistRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique id of the playlist you want to perform the operation on.
        field :playlist_id, ::String, { 'path_param': { 'field_name': 'playlistId', 'style': 'simple', 'explode': false } }

        field :body, Models::Components::MediaIdsRequest, { 'request': { 'media_type': 'application/json' } }

        sig { params(playlist_id: ::String, body: Models::Components::MediaIdsRequest).void }
        def initialize(playlist_id:, body:)
          @playlist_id = playlist_id
          @body = body
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @playlist_id == other.playlist_id
          return false unless @body == other.body
          true
        end
      end
    end
  end
end
