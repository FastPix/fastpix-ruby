# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class DefaultError
        extend T::Sig
        include Crystalline::MetadataFields

        # Shows if the request was completed successfully. Returns `true` for success and `false` for failure.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success') } }
        # Contains details about the error if the request failed.
        field :error, Crystalline::Nilable.new(Models::Components::Error), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('error') } }

        sig { params(success: T.nilable(T::Boolean), error: T.nilable(Models::Components::Error)).void }
        def initialize(success: nil, error: nil)
          @success = success
          @error = error
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          return false unless @error == other.error
          true
        end
      end
    end
  end
end
