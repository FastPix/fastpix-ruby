# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class PlaybackIdRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Basic access policy for media content
        field :access_policy, Crystalline::Nilable.new(Models::Components::BasicAccessPolicy), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessPolicy'), 'decoder': Utils.enum_from_string(Models::Components::BasicAccessPolicy, true) } }
        # Domain and user-agent access restrictions applied to the live playback ID.
        field :access_restrictions, Crystalline::Nilable.new(Models::Components::PlaybackIdAccessRestrictions), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessRestrictions') } }

        sig { params(access_policy: T.nilable(Models::Components::BasicAccessPolicy), access_restrictions: T.nilable(Models::Components::PlaybackIdAccessRestrictions)).void }
        def initialize(access_policy: Models::Components::BasicAccessPolicy::PUBLIC, access_restrictions: nil)
          @access_policy = access_policy
          @access_restrictions = access_restrictions
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @access_policy == other.access_policy
          return false unless @access_restrictions == other.access_restrictions
          true
        end
      end
    end
  end
end
