# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class DeleteMediaTrackRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier assigned to the media when created. The value must be a valid UUID.
        field :media_id, ::String, { 'path_param': { 'field_name': 'mediaId', 'style': 'simple', 'explode': false } }
        # The unique identifier assigned to the media when created. The value must be a valid UUID.
        field :track_id, ::String, { 'path_param': { 'field_name': 'trackId', 'style': 'simple', 'explode': false } }

        sig { params(media_id: ::String, track_id: ::String).void }
        def initialize(media_id:, track_id:)
          @media_id = media_id
          @track_id = track_id
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @media_id == other.media_id
          return false unless @track_id == other.track_id
          true
        end
      end
    end
  end
end
