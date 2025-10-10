
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class UpdatedSourceAccessRequestBody
        extend T::Sig
        include Crystalline::MetadataFields

        # The sourceAccess parameter determines whether the original media file is accessible. Set to true to enable access or false to restrict it.
        field :source_access, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('sourceAccess') } }

        sig { params(source_access: T.nilable(T::Boolean)).void }
        def initialize(source_access: nil)
          @source_access = source_access
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @source_access == other.source_access
          true
        end
      end
    end
  end
end
