# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class MediaClipResponseData
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier assigned to the media by FastPix.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('id') } }
        # Duration of the media in HH:MM:SS format.
        field :duration, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('duration') } }
        # The current processing status of the media.
        field :status, Crystalline::Nilable.new(Models::Components::MediaClipResponseStatus), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('status'), 'decoder': Utils.enum_from_string(Models::Components::MediaClipResponseStatus, true) } }
        # A video thumbnail that acts as a preview image for the video.
        field :thumbnail, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('thumbnail') } }
        # Timestamp of when the media was created.
        field :created_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('createdAt'), 'decoder': Utils.datetime_from_iso_format(true) } }

        field :playback_ids, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::MediaClipResponsePlaybackId)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playbackIds') } }

        sig { params(id: T.nilable(::String), duration: T.nilable(::String), status: T.nilable(Models::Components::MediaClipResponseStatus), thumbnail: T.nilable(::String), created_at: T.nilable(::DateTime), playback_ids: T.nilable(T::Array[Models::Components::MediaClipResponsePlaybackId])).void }
        def initialize(id: nil, duration: nil, status: nil, thumbnail: nil, created_at: nil, playback_ids: nil)
          @id = id
          @duration = duration
          @status = status
          @thumbnail = thumbnail
          @created_at = created_at
          @playback_ids = playback_ids
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @duration == other.duration
          return false unless @status == other.status
          return false unless @thumbnail == other.thumbnail
          return false unless @created_at == other.created_at
          return false unless @playback_ids == other.playback_ids
          true
        end
      end
    end
  end
end
