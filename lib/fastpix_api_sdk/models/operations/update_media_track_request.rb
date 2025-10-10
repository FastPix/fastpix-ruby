
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class UpdateMediaTrackRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # When creating the media, FastPix assigns a universally unique identifier with a maximum length of 255 characters.
        field :track_id, ::String, { 'path_param': { 'field_name': 'trackId', 'style': 'simple', 'explode': false } }
        # When creating the media, FastPix assigns a universally unique identifier with a maximum length of 255 characters.
        field :media_id, ::String, { 'path_param': { 'field_name': 'mediaId', 'style': 'simple', 'explode': false } }

        field :update_track_request, Models::Components::UpdateTrackRequest, { 'request': { 'media_type': 'application/json' } }

        sig { params(track_id: ::String, media_id: ::String, update_track_request: Models::Components::UpdateTrackRequest).void }
        def initialize(track_id:, media_id:, update_track_request:)
          @track_id = track_id
          @media_id = media_id
          @update_track_request = update_track_request
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @track_id == other.track_id
          return false unless @media_id == other.media_id
          return false unless @update_track_request == other.update_track_request
          true
        end
      end
    end
  end
end
