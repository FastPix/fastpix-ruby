# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Playback ID for a media content.
      class CreateMediaPlaybackIdResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Shows the request status. Returns true for success and false for failure.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success') } }
        # A collection of Playback ID objects utilized for crafting HLS playback urls.
        field :data, Crystalline::Nilable.new(Models::Components::CreatePlaybackId), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data') } }

        sig { params(success: T.nilable(T::Boolean), data: T.nilable(Models::Components::CreatePlaybackId)).void }
        def initialize(success: nil, data: nil)
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
