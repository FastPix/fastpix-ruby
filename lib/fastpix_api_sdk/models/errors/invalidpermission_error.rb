# Code generated by Speakeasy (https://speakeasy.com). DO NOT EDIT.

# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Errors
    

      class InvalidPermissionError
        extend T::Sig
        include Crystalline::MetadataFields

        # Demonstrates whether the request is successful or not.
        field :success, T.nilable(T::Boolean), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('success') } }
        # Displays details about the reasons behind the request's failure.
        field :error, T.nilable(Models::Errors::InvalidPermissionErrorError), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('error') } }

        sig { params(success: T.nilable(T::Boolean), error: T.nilable(Models::Errors::InvalidPermissionErrorError)).void }
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
