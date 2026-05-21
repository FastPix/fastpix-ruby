# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      # DeleteSigningKeyResponseData - Contains details about the deleted signing key.
      class DeleteSigningKeyResponseData
        extend T::Sig
        include Crystalline::MetadataFields

        # A human-readable confirmation message.
        field :message, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('message') } }

        sig { params(message: T.nilable(::String)).void }
        def initialize(message: nil)
          @message = message
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @message == other.message
          true
        end
      end
    end
  end
end
