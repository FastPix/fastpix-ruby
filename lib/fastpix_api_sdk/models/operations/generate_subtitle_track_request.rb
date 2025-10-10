
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GenerateSubtitleTrackRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # A universally unique identifier (UUID) assigned to the media by FastPix.
        field :media_id, ::String, { 'path_param': { 'field_name': 'mediaId', 'style': 'simple', 'explode': false } }
        # A universally unique identifier (UUID) assigned to the specific track for which subtitles should be generated.
        field :track_id, ::String, { 'path_param': { 'field_name': 'trackId', 'style': 'simple', 'explode': false } }

        field :track_subtitles_generate_request, Models::Components::TrackSubtitlesGenerateRequest, { 'request': { 'media_type': 'application/json' } }

        sig { params(media_id: ::String, track_id: ::String, track_subtitles_generate_request: Models::Components::TrackSubtitlesGenerateRequest).void }
        def initialize(media_id:, track_id:, track_subtitles_generate_request:)
          @media_id = media_id
          @track_id = track_id
          @track_subtitles_generate_request = track_subtitles_generate_request
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @media_id == other.media_id
          return false unless @track_id == other.track_id
          return false unless @track_subtitles_generate_request == other.track_subtitles_generate_request
          true
        end
      end
    end
  end
end
