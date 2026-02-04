# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Contains details about the error if the request failed.
      class Error
        extend T::Sig
        include Crystalline::MetadataFields

        # The HTTP status code that explains the type of error (for example, 400 for a bad request, 404 for not found).
        field :code, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('code') } }
        # A short message describing what went wrong.
        field :message, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('message') } }
        # A detailed explanation of the error and what caused it. May also include links to documentation or tips for fixing the issue.  
        # 
        field :description, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('description') } }

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
