
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class UpdateMediaNamedEntitiesRequestBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Enable or disable named entity extraction. Set to `true` to enable or `false` to disable.
        # 
        field :named_entities, Crystalline::Boolean.new, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('namedEntities'), required: true } }

        sig { params(named_entities: T::Boolean).void }
        def initialize(named_entities:)
          @named_entities = named_entities
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @named_entities == other.named_entities
          true
        end
      end
    end
  end
end
