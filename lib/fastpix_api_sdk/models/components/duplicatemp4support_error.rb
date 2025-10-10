
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Displays details about the reasons behind the request's failure.
      class DuplicateMp4SupportError
        extend T::Sig
        include Crystalline::MetadataFields

        # Displays the error code indicating the type of the error.
        field :code, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('code') } }
        # A descriptive message providing more details for the error.
        field :message, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('message') } }
        # A detailed explanation of the possible causes for the error.
        # 
        field :description, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('description') } }

        sig { params(code: T.nilable(::Float), message: T.nilable(::String), description: T.nilable(::String)).void }
        def initialize(code: nil, message: nil, description: nil)
          @code = code
          @message = message
          @description = description
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @code == other.code
          return false unless @message == other.message
          return false unless @description == other.description
          true
        end
      end
    end
  end
end
