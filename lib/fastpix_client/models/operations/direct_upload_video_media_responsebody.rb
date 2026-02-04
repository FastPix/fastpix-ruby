# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Direct upload created successfully
      class DirectUploadVideoMediaResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Shows the request status. Returns true for success and false for failure.
        field :success, Crystalline::Boolean.new, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success'), required: true } }
        # Displays the result of the request.
        field :data, Models::Components::DirectUpload, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data'), required: true } }

        sig { params(success: T::Boolean, data: Models::Components::DirectUpload).void }
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
