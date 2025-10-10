
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class PlaylistByIdResponseData
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique id of the playlist
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('id') } }
        # The name of the playlist set by the user
        field :name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('name') } }
        # Unique string value assigned by user to the playlist.
        field :reference_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('referenceId') } }
        # type of the playlist, when it was created
        field :type, Crystalline::Nilable.new(Models::Components::PlaylistByIdResponseType), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('type'), 'decoder': Utils.enum_from_string(Models::Components::PlaylistByIdResponseType, true) } }
        # Description of the playlist set by the user.
        field :description, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('description') } }

        field :media_list, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::PlaylistByIdResponseMediaList)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mediaList') } }
        # The unique id of the workspace in which the playlist is present.
        field :workspace_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('workspaceId') } }
        # Timestamp of playlist creation.
        field :created_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('createdAt'), 'decoder': Utils.datetime_from_iso_format(true) } }
        # Playlist's most recent update timestamp.
        field :updated_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('updatedAt'), 'decoder': Utils.datetime_from_iso_format(true) } }
        # No. of media present in the playlist
        field :media_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mediaCount') } }

        sig { params(id: T.nilable(::String), name: T.nilable(::String), reference_id: T.nilable(::String), type: T.nilable(Models::Components::PlaylistByIdResponseType), description: T.nilable(::String), media_list: T.nilable(T::Array[Models::Components::PlaylistByIdResponseMediaList]), workspace_id: T.nilable(::String), created_at: T.nilable(::DateTime), updated_at: T.nilable(::DateTime), media_count: T.nilable(::Integer)).void }
        def initialize(id: nil, name: nil, reference_id: nil, type: nil, description: nil, media_list: nil, workspace_id: nil, created_at: nil, updated_at: nil, media_count: nil)
          @id = id
          @name = name
          @reference_id = reference_id
          @type = type
          @description = description
          @media_list = media_list
          @workspace_id = workspace_id
          @created_at = created_at
          @updated_at = updated_at
          @media_count = media_count
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @name == other.name
          return false unless @reference_id == other.reference_id
          return false unless @type == other.type
          return false unless @description == other.description
          return false unless @media_list == other.media_list
          return false unless @workspace_id == other.workspace_id
          return false unless @created_at == other.created_at
          return false unless @updated_at == other.updated_at
          return false unless @media_count == other.media_count
          true
        end
      end
    end
  end
end
