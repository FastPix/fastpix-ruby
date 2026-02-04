# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Contains metadata and structural details about the media file.
      class File
        extend T::Sig
        include Crystalline::MetadataFields

        # Specifies the container format that encapsulates audio, video, subtitles, and metadata.
        field :container_format, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('containerFormat') } }
        # A list of all media tracks including video, audio, and subtitles.
        field :tracks, Crystalline::Nilable.new(Crystalline::Array.new(Crystalline::Union.new(Models::Components::VideoTrack, Models::Components::AudioTrack, Models::Components::SubtitleTrack))), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('tracks') } }

        sig { params(container_format: T.nilable(::String), tracks: T.nilable(T::Array[T.any(Models::Components::VideoTrack, Models::Components::AudioTrack, Models::Components::SubtitleTrack)])).void }
        def initialize(container_format: nil, tracks: nil)
          @container_format = container_format
          @tracks = tracks
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @container_format == other.container_format
          return false unless @tracks == other.tracks
          true
        end
      end
    end
  end
end
