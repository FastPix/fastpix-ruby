
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class CreatePlaylistRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Name of the playlist.
        field :name, ::String, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('name'), required: true } }
        # Unique string value assigned by user to the playlist.
        field :reference_id, ::String, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('referenceId'), required: true } }
        # For a smart playlist metadata is required.
        field :type, Models::Components::CreatePlaylistRequestType, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('type'), required: true, 'decoder': Utils.enum_from_string(Models::Components::CreatePlaylistRequestType, false) } }
        # Description for a playlist (Optional).
        field :description, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('description') } }
        # Determines the insertion order of media into playlist.
        field :play_order, Crystalline::Nilable.new(Models::Components::PlaylistOrder), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playOrder'), 'decoder': Utils.enum_from_string(Models::Components::PlaylistOrder, true) } }
        # Required when playlist type is smart - media created between startDate and endDate of createdDate will be add, similarily updatedDate (Optional)
        field :metadata, Crystalline::Nilable.new(Models::Components::CreatePlaylistRequestMetadata), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }
        # Optional parameter to limit no. of media in a playlist.
        field :limit, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('limit') } }

        sig { params(name: ::String, reference_id: ::String, type: Models::Components::CreatePlaylistRequestType, description: T.nilable(::String), play_order: T.nilable(Models::Components::PlaylistOrder), metadata: T.nilable(Models::Components::CreatePlaylistRequestMetadata), limit: T.nilable(::Integer)).void }
        def initialize(name:, reference_id:, type:, description: nil, play_order: nil, metadata: nil, limit: 1000)
          @name = name
          @reference_id = reference_id
          @type = type
          @description = description
          @play_order = play_order
          @metadata = metadata
          @limit = limit
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @name == other.name
          return false unless @reference_id == other.reference_id
          return false unless @type == other.type
          return false unless @description == other.description
          return false unless @play_order == other.play_order
          return false unless @metadata == other.metadata
          return false unless @limit == other.limit
          true
        end
      end
    end
  end
end
