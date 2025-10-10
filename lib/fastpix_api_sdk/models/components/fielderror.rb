
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class FieldError
        extend T::Sig
        include Crystalline::MetadataFields

        # Displays the specific field associated with the error.
        field :field, ::String, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('field'), required: true } }
        # Error message for the field
        field :message, ::String, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('message'), required: true } }

        sig { params(field: ::String, message: ::String).void }
        def initialize(field:, message:)
          @field = field
          @message = message
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @field == other.field
          return false unless @message == other.message
          true
        end
      end
    end
  end
end
