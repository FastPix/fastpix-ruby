
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Returns the problem that has occured
      class ViewNotFoundError
        extend T::Sig
        include Crystalline::MetadataFields

        # An error code indicating the type of the error.
        field :code, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('code') } }
        # A descriptive message providing more details for the error.
        field :message, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('message') } }

        sig { params(code: T.nilable(::Float), message: T.nilable(::String)).void }
        def initialize(code: nil, message: nil)
          @code = code
          @message = message
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @code == other.code
          return false unless @message == other.message
          true
        end
      end
    end
  end
end
