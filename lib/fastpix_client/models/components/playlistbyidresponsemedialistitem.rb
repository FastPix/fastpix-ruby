# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class PlaylistByIdResponseMediaListItem
        extend T::Sig
        include Crystalline::MetadataFields

        # Timestamp of media creation in the workspace.
        field :created_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('createdAt'), 'decoder': Utils.datetime_from_iso_format(true) } }
        # Duration of the media in hh:mm:ss format.
        field :duration, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('duration') } }
        # unique id of the particular media.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('id') } }
        # source resolution of the media.
        field :source_resolution, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('sourceResolution') } }
        # status of the media, only media with ready status is added to playlist.
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('status') } }
        # thumbnail for the particular media.
        field :thumbnail, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('thumbnail') } }
        # Creator ID of the media.
        field :creator_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('creatorId') } }
        # Title of the media.
        field :title, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('title') } }

        sig { params(created_at: T.nilable(::DateTime), duration: T.nilable(::String), id: T.nilable(::String), source_resolution: T.nilable(::String), status: T.nilable(::String), thumbnail: T.nilable(::String), creator_id: T.nilable(::String), title: T.nilable(::String)).void }
        def initialize(created_at: nil, duration: nil, id: nil, source_resolution: nil, status: nil, thumbnail: nil, creator_id: nil, title: nil)
          @created_at = created_at
          @duration = duration
          @id = id
          @source_resolution = source_resolution
          @status = status
          @thumbnail = thumbnail
          @creator_id = creator_id
          @title = title
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
          return false unless @creator_id == other.creator_id
          return false unless @title == other.title
          true
        end
      end
    end
  end
end
