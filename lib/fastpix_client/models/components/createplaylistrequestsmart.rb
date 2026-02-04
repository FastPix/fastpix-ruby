# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class CreatePlaylistRequestSmart
        extend T::Sig
        include Crystalline::MetadataFields

        # Name of the playlist.
        field :name, ::String, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('name'), required: true } }
        # Unique string value assigned by user to the playlist.
        field :reference_id, ::String, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('referenceId'), required: true } }
        # For a smart playlist metadata is required.
        field :type, Models::Components::CreatePlaylistRequestSmartType, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type'), required: true, 'decoder': Utils.enum_from_string(Models::Components::CreatePlaylistRequestSmartType, false) } }
        # Determines the insertion order of media into playlist.
        field :play_order, Models::Components::PlaylistOrder, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playOrder'), required: true, 'decoder': Utils.enum_from_string(Models::Components::PlaylistOrder, false) } }
        # Required when the playlist type is `smart`. Media created between `startDate` and `endDate` of `createdDate` is added. Optionally, you can include media based on `updatedDate`.
        field :metadata, Models::Components::Metadata, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata'), required: true } }
        # Description for a playlist (Optional).
        field :description, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('description') } }
        # Optional parameter to limit no. of media in a playlist.
        field :limit, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('limit') } }

        sig { params(name: ::String, reference_id: ::String, type: Models::Components::CreatePlaylistRequestSmartType, play_order: Models::Components::PlaylistOrder, metadata: Models::Components::Metadata, description: T.nilable(::String), limit: T.nilable(::Integer)).void }
        def initialize(name:, reference_id:, type:, play_order:, metadata:, description: nil, limit: 1000)
          @name = name
          @reference_id = reference_id
          @type = type
          @play_order = play_order
          @metadata = metadata
          @description = description
          @limit = limit
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @name == other.name
          return false unless @reference_id == other.reference_id
          return false unless @type == other.type
          return false unless @play_order == other.play_order
          return false unless @metadata == other.metadata
          return false unless @description == other.description
          return false unless @limit == other.limit
          true
        end
      end
    end
  end
end
