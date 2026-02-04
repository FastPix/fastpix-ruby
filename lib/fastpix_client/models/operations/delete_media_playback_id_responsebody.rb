# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Deleted a Playback Id successfully
      class DeleteMediaPlaybackIdResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Shows the request status. Returns true for success and false for failure.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success') } }

        sig { params(success: T.nilable(T::Boolean)).void }
        def initialize(success: nil)
          @success = success
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          true
        end
      end
    end
  end
end
