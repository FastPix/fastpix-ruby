
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class MediaClipResponseData
        extend T::Sig
        include Crystalline::MetadataFields

        # A video thumbnail that acts as a preview image for the video.
        field :thumbnail, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('thumbnail') } }
        # The unique identifier assigned to the media by FastPix.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('id') } }
        # The ID of the original source media.
        field :source_media_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('sourceMediaId') } }
        # The unique identifier for the workspace associated with the media.
        field :workspace_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('workspaceId') } }
        # Tag a video in "key" : "value" pairs for searchable metadata. Maximum 10 entries, 255 characters each.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }
        # The maximum resolution specified for the media.
        field :max_resolution, Crystalline::Nilable.new(Models::Components::MediaClipResponseMaxResolution), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('maxResolution'), 'decoder': Utils.enum_from_string(Models::Components::MediaClipResponseMaxResolution, true) } }
        # The actual resolution of the uploaded media.
        field :source_resolution, Crystalline::Nilable.new(Models::Components::MediaClipResponseSourceResolution), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('sourceResolution'), 'decoder': Utils.enum_from_string(Models::Components::MediaClipResponseSourceResolution, true) } }
        # The current processing status of the media.
        field :status, Crystalline::Nilable.new(Models::Components::Status), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('status'), 'decoder': Utils.enum_from_string(Models::Components::Status, true) } }
        # Indicates whether the original media file is accessible.
        field :source_access, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('sourceAccess') } }

        field :playback_ids, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::MediaClipResponsePlaybackId)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playbackIds') } }

        field :tracks, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::MediaClipResponseTrack)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('tracks') } }
        # Generated subtitle tracks associated with the media.
        field :generated_subtitles, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::GeneratedSubtitle)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('generatedSubtitles') } }
        # Indicates whether the media contains only audio.
        field :is_audio_only, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('isAudioOnly') } }
        # Indicates whether subtitles are available for the media.
        field :subtitle_available, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('subtitleAvailable') } }
        # The total duration of the media.
        field :duration, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('duration') } }
        # The aspect ratio of the media.
        field :aspect_ratio, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('aspectRatio') } }
        # Timestamp of when the media was created.
        field :created_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('createdAt'), 'decoder': Utils.datetime_from_iso_format(true) } }
        # Timestamp of when the media was last updated.
        field :updated_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('updatedAt'), 'decoder': Utils.datetime_from_iso_format(true) } }

        sig { params(thumbnail: T.nilable(::String), id: T.nilable(::String), source_media_id: T.nilable(::String), workspace_id: T.nilable(::String), metadata: T.nilable(T::Hash[Symbol, ::String]), max_resolution: T.nilable(Models::Components::MediaClipResponseMaxResolution), source_resolution: T.nilable(Models::Components::MediaClipResponseSourceResolution), status: T.nilable(Models::Components::Status), source_access: T.nilable(T::Boolean), playback_ids: T.nilable(T::Array[Models::Components::MediaClipResponsePlaybackId]), tracks: T.nilable(T::Array[Models::Components::MediaClipResponseTrack]), generated_subtitles: T.nilable(T::Array[Models::Components::GeneratedSubtitle]), is_audio_only: T.nilable(T::Boolean), subtitle_available: T.nilable(T::Boolean), duration: T.nilable(::String), aspect_ratio: T.nilable(::String), created_at: T.nilable(::DateTime), updated_at: T.nilable(::DateTime)).void }
        def initialize(thumbnail: nil, id: nil, source_media_id: nil, workspace_id: nil, metadata: nil, max_resolution: nil, source_resolution: nil, status: nil, source_access: nil, playback_ids: nil, tracks: nil, generated_subtitles: nil, is_audio_only: nil, subtitle_available: nil, duration: nil, aspect_ratio: nil, created_at: nil, updated_at: nil)
          @thumbnail = thumbnail
          @id = id
          @source_media_id = source_media_id
          @workspace_id = workspace_id
          @metadata = metadata
          @max_resolution = max_resolution
          @source_resolution = source_resolution
          @status = status
          @source_access = source_access
          @playback_ids = playback_ids
          @tracks = tracks
          @generated_subtitles = generated_subtitles
          @is_audio_only = is_audio_only
          @subtitle_available = subtitle_available
          @duration = duration
          @aspect_ratio = aspect_ratio
          @created_at = created_at
          @updated_at = updated_at
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @thumbnail == other.thumbnail
          return false unless @id == other.id
          return false unless @source_media_id == other.source_media_id
          return false unless @workspace_id == other.workspace_id
          return false unless @metadata == other.metadata
          return false unless @max_resolution == other.max_resolution
          return false unless @source_resolution == other.source_resolution
          return false unless @status == other.status
          return false unless @source_access == other.source_access
          return false unless @playback_ids == other.playback_ids
          return false unless @tracks == other.tracks
          return false unless @generated_subtitles == other.generated_subtitles
          return false unless @is_audio_only == other.is_audio_only
          return false unless @subtitle_available == other.subtitle_available
          return false unless @duration == other.duration
          return false unless @aspect_ratio == other.aspect_ratio
          return false unless @created_at == other.created_at
          return false unless @updated_at == other.updated_at
          true
        end
      end
    end
  end
end
