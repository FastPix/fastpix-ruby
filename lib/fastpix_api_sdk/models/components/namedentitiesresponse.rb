
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class NamedEntitiesResponse
        extend T::Sig
        include Crystalline::MetadataFields


        field :media_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mediaId') } }

        field :is_generated_named_entities, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('isGeneratedNamedEntities') } }

        sig { params(media_id: T.nilable(::String), is_generated_named_entities: T.nilable(T::Boolean)).void }
        def initialize(media_id: nil, is_generated_named_entities: nil)
          @media_id = media_id
          @is_generated_named_entities = is_generated_named_entities
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @media_id == other.media_id
          return false unless @is_generated_named_entities == other.is_generated_named_entities
          true
        end
      end
    end
  end
end
