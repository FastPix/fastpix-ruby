# Code generated by Speakeasy (https://speakeasy.com). DO NOT EDIT.

# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # A collection of Playback ID objects utilized for crafting HLS playback urls.
      class PlaybackIds
        extend T::Sig
        include Crystalline::MetadataFields

        # Unique identifier for the playbackId
        field :id, T.nilable(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('id') } }
        # Determines if access to the streamed content is kept private or available to all.
        field :access_policy, T.nilable(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('accessPolicy') } }

        sig { params(id: T.nilable(::String), access_policy: T.nilable(::String)).void }
        def initialize(id: nil, access_policy: nil)
          @id = id
          @access_policy = access_policy
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @access_policy == other.access_policy
          true
        end
      end
    end
  end
end
