
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Displays details about the reasons behind the request's failure.
      class InvalidPlaylistIdResponseError
        extend T::Sig
        include Crystalline::MetadataFields

        # Displays the error code indicating the type of the error.
        field :code, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('code') } }
        # A descriptive message providing more details for the error.
        field :message, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('message') } }
        # It is an collection of objects, where each object contains information about a specific field and a corresponding error message.
        field :fields_, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::FieldError)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('fields') } }

        sig { params(code: T.nilable(::Integer), message: T.nilable(::String), fields_: T.nilable(T::Array[Models::Components::FieldError])).void }
        def initialize(code: nil, message: nil, fields_: nil)
          @code = code
          @message = message
          @fields_ = fields_
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @code == other.code
          return false unless @message == other.message
          return false unless @fields_ == other.fields_
          true
        end
      end
    end
  end
end
