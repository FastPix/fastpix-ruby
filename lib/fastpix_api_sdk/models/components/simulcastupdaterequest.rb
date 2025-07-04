# Code generated by Speakeasy (https://speakeasy.com). DO NOT EDIT.

# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class SimulcastUpdateRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # When the value is set to false, the simulcast will be disabled for the given stream.
        field :is_enabled, T.nilable(T::Boolean), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('isEnabled') } }
        # Arbitrary user-supplied metadata that will be included in the simulcast details. Can be used to store your own ID for a video along with the simulcast. Max:255 characters, Upto 10 entries are allowed.
        field :metadata, T.nilable(Models::Components::SimulcastUpdateRequestMetadata), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }

        sig { params(is_enabled: T.nilable(T::Boolean), metadata: T.nilable(Models::Components::SimulcastUpdateRequestMetadata)).void }
        def initialize(is_enabled: nil, metadata: nil)
          @is_enabled = is_enabled
          @metadata = metadata
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @is_enabled == other.is_enabled
          return false unless @metadata == other.metadata
          true
        end
      end
    end
  end
end
