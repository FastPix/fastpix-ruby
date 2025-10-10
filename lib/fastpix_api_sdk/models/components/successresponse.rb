
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class SuccessResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # Demonstrates whether the request is successful or not.
        field :success, Crystalline::Boolean.new, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('success'), required: true } }
        # Array of response data
        field :data, Crystalline::Array.new(Models::Components::SuccessResponseData), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('data'), required: true } }

        sig { params(success: T::Boolean, data: T::Array[Models::Components::SuccessResponseData]).void }
        def initialize(success:, data:)
          @success = success
          @data = data
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          return false unless @data == other.data
          true
        end
      end
    end
  end
end
