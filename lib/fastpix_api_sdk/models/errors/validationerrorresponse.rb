
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Errors
    

      class ValidationErrorResponse < StandardError
        extend T::Sig
        include Crystalline::MetadataFields

        # Demonstrates whether the request is successful or not.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('success') } }
        # Displays details about the reasons behind the request's failure.
        field :error, Crystalline::Nilable.new(Models::Components::ValidationErrorResponseError), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('error') } }
        # Raw HTTP response; suitable for custom response parsing
        field :raw_response, Crystalline::Nilable.new(::Faraday::Response), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('-') } }

        sig { params(success: T.nilable(T::Boolean), error: T.nilable(Models::Components::ValidationErrorResponseError), raw_response: T.nilable(::Faraday::Response)).void }
        def initialize(success: nil, error: nil, raw_response: nil)
          @success = success
          @error = error
          @raw_response = raw_response
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          return false unless @error == other.error
          return false unless @raw_response == other.raw_response
          true
        end
      end
    end
  end
end
