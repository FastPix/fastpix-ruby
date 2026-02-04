# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class AudioInput
        extend T::Sig
        include Crystalline::MetadataFields

        # Type of overlay (currently only supports "audio").
        field :type, Models::Components::AudioInputType, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type'), required: true, 'decoder': Utils.enum_from_string(Models::Components::AudioInputType, false) } }
        # URL of the audio track to replace the existing audio in the video.
        field :swap_track_url, ::String, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('swapTrackUrl'), required: true } }
        # List of additional audio tracks to overlay on the video.
        field :impose_tracks, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::ImposeTrack)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('imposeTracks') } }

        sig { params(type: Models::Components::AudioInputType, swap_track_url: ::String, impose_tracks: T.nilable(T::Array[Models::Components::ImposeTrack])).void }
        def initialize(type:, swap_track_url:, impose_tracks: nil)
          @type = type
          @swap_track_url = swap_track_url
          @impose_tracks = impose_tracks
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @type == other.type
          return false unless @swap_track_url == other.swap_track_url
          return false unless @impose_tracks == other.impose_tracks
          true
        end
      end
    end
  end
end
