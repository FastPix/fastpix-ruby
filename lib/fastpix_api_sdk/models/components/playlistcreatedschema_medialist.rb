
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class PlaylistCreatedSchemaMediaList
        extend T::Sig
        include Crystalline::MetadataFields

        # timestamp of media creation in the workspace
        field :created_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('createdAt'), 'decoder': Utils.datetime_from_iso_format(true) } }
        # duration of the media in hh:mm:ss format
        field :duration, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('duration') } }
        # unique identifier of the media
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('id') } }
        # The source resolution of the media
        field :source_resolution, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('sourceResolution') } }
        # The status of the video in the workspace. Only media which are in ready status are added into the playlist
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('status') } }
        # Thumbnail to the particular media
        field :thumbnail, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('thumbnail') } }

        sig { params(created_at: T.nilable(::DateTime), duration: T.nilable(::String), id: T.nilable(::String), source_resolution: T.nilable(::String), status: T.nilable(::String), thumbnail: T.nilable(::String)).void }
        def initialize(created_at: nil, duration: nil, id: nil, source_resolution: nil, status: nil, thumbnail: nil)
          @created_at = created_at
          @duration = duration
          @id = id
          @source_resolution = source_resolution
          @status = status
          @thumbnail = thumbnail
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @created_at == other.created_at
          return false unless @duration == other.duration
          return false unless @id == other.id
          return false unless @source_resolution == other.source_resolution
          return false unless @status == other.status
          return false unless @thumbnail == other.thumbnail
          true
        end
      end
    end
  end
end
