
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class DeleteSigningKeyResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # It demonstrates whether the request is successful or not.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('success') } }

        sig { params(success: T.nilable(T::Boolean)).void }
        def initialize(success: nil)
          @success = success
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          true
        end
      end
    end
  end
end
