
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class UpdatedMediaRequestBody
        extend T::Sig
        include Crystalline::MetadataFields


        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }

        sig { params(metadata: T.nilable(T::Hash[Symbol, ::String])).void }
        def initialize(metadata: nil)
          @metadata = metadata
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @metadata == other.metadata
          true
        end
      end
    end
  end
end
