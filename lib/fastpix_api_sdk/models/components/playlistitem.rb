
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class PlaylistItem
        extend T::Sig
        include Crystalline::MetadataFields


        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('id') } }

        field :name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('name') } }

        field :type, Crystalline::Nilable.new(Models::Components::PlaylistItemType), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('type'), 'decoder': Utils.enum_from_string(Models::Components::PlaylistItemType, true) } }

        field :reference_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('referenceId') } }

        field :created_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('createdAt'), 'decoder': Utils.datetime_from_iso_format(true) } }

        field :media_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mediaCount') } }

        sig { params(id: T.nilable(::String), name: T.nilable(::String), type: T.nilable(Models::Components::PlaylistItemType), reference_id: T.nilable(::String), created_at: T.nilable(::DateTime), media_count: T.nilable(::Integer)).void }
        def initialize(id: nil, name: nil, type: nil, reference_id: nil, created_at: nil, media_count: nil)
          @id = id
          @name = name
          @type = type
          @reference_id = reference_id
          @created_at = created_at
          @media_count = media_count
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @name == other.name
          return false unless @type == other.type
          return false unless @reference_id == other.reference_id
          return false unless @created_at == other.created_at
          return false unless @media_count == other.media_count
          true
        end
      end
    end
  end
end
