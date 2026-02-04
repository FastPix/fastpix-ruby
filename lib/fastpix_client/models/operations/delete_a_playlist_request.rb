# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class DeleteAPlaylistRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique id of the playlist you want to delete.
        field :playlist_id, ::String, { 'path_param': { 'field_name': 'playlistId', 'style': 'simple', 'explode': false } }

        sig { params(playlist_id: ::String).void }
        def initialize(playlist_id:)
          @playlist_id = playlist_id
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @playlist_id == other.playlist_id
          true
        end
      end
    end
  end
end
