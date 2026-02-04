# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Upload cancelled successfully
      class CancelUploadResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Demonstrates whether the request is successful or not.
        field :success, Crystalline::Boolean.new, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success'), required: true } }
        # Response returned when an upload is cancelled.
        field :data, Models::Components::MediaCancelResponse, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data'), required: true } }

        sig { params(success: T::Boolean, data: Models::Components::MediaCancelResponse).void }
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
