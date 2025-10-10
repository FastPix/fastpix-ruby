
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class NotFoundErrorError
        extend T::Sig
        include Crystalline::MetadataFields


        field :code, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('code') } }

        field :message, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('message') } }

        field :description, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('description') } }

        sig { params(code: T.nilable(::Integer), message: T.nilable(::String), description: T.nilable(::String)).void }
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
