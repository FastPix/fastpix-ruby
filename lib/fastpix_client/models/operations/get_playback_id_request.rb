# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class GetPlaybackIdRequest
        extend T::Sig
        include Crystalline::MetadataFields


        field :media_id, ::String, { 'path_param': { 'field_name': 'mediaId', 'style': 'simple', 'explode': false } }

        field :playback_id, ::String, { 'path_param': { 'field_name': 'playbackId', 'style': 'simple', 'explode': false } }

        sig { params(media_id: ::String, playback_id: ::String).void }
        def initialize(media_id:, playback_id:)
          @media_id = media_id
          @playback_id = playback_id
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @media_id == other.media_id
          return false unless @playback_id == other.playback_id
          true
        end
      end
    end
  end
end
