# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class UpdateMediaTrackRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier assigned to the media when created. The value must be a valid UUID.
        field :track_id, ::String, { 'path_param': { 'field_name': 'trackId', 'style': 'simple', 'explode': false } }
        # The unique identifier assigned to the media when created. The value must be a valid UUID.
        field :media_id, ::String, { 'path_param': { 'field_name': 'mediaId', 'style': 'simple', 'explode': false } }

        field :body, Models::Components::UpdateTrackRequest, { 'request': { 'media_type': 'application/json' } }

        sig { params(track_id: ::String, media_id: ::String, body: Models::Components::UpdateTrackRequest).void }
        def initialize(track_id:, media_id:, body:)
          @track_id = track_id
          @media_id = media_id
          @body = body
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @track_id == other.track_id
          return false unless @media_id == other.media_id
          return false unless @body == other.body
          true
        end
      end
    end
  end
end
