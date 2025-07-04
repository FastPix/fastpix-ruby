# Code generated by Speakeasy (https://speakeasy.com). DO NOT EDIT.

# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # Displays the result of the request.
      class Data
        extend T::Sig
        include Crystalline::MetadataFields

        # A collection of Playback ID objects utilized for crafting HLS playback URLs.
        field :playback_ids, T.nilable(T::Array[Models::Components::PlaybackId]), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playbackIds') } }

        sig { params(playback_ids: T.nilable(T::Array[Models::Components::PlaybackId])).void }
        def initialize(playback_ids: nil)
          @playback_ids = playback_ids
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @playback_ids == other.playback_ids
          true
        end
      end
    end
  end
end
