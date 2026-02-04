# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class CreatePlaylistRequestManual
        extend T::Sig
        include Crystalline::MetadataFields

        # Name of the playlist.
        field :name, ::String, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('name'), required: true } }
        # Unique string value assigned by user to the playlist.
        field :reference_id, ::String, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('referenceId'), required: true } }
        # Manual playlist type (no `playOrder`).
        field :type, Models::Components::CreatePlaylistRequestManualType, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type'), required: true, 'decoder': Utils.enum_from_string(Models::Components::CreatePlaylistRequestManualType, false) } }
        # Description for a playlist (Optional).
        field :description, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('description') } }
        # Optional parameter to limit no. of media in a playlist.
        field :limit, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('limit') } }

        sig { params(name: ::String, reference_id: ::String, type: Models::Components::CreatePlaylistRequestManualType, description: T.nilable(::String), limit: T.nilable(::Integer)).void }
        def initialize(name:, reference_id:, type:, description: nil, limit: 1000)
          @name = name
          @reference_id = reference_id
          @type = type
          @description = description
          @limit = limit
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @name == other.name
          return false unless @reference_id == other.reference_id
          return false unless @type == other.type
          return false unless @description == other.description
          return false unless @limit == other.limit
          true
        end
      end
    end
  end
end
