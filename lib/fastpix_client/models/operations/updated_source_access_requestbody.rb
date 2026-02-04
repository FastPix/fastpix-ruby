# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class UpdatedSourceAccessRequestBody
        extend T::Sig
        include Crystalline::MetadataFields

        # The sourceAccess parameter determines whether the original media file is accessible. Set to true to enable access or false to restrict it.
        field :source_access, Crystalline::Boolean.new, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('sourceAccess'), required: true } }

        sig { params(source_access: T::Boolean).void }
        def initialize(source_access:)
          @source_access = source_access
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @source_access == other.source_access
          true
        end
      end
    end
  end
end
