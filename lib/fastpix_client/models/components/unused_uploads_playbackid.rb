# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # A collection of Playback ID objects utilized for crafting HLS playback urls.
      class UnusedUploadsPlaybackId
        extend T::Sig
        include Crystalline::MetadataFields

        # Access policy for media content
        field :access_policy, Crystalline::Nilable.new(Models::Components::AccessPolicy), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessPolicy'), 'decoder': Utils.enum_from_string(Models::Components::AccessPolicy, true) } }
        # Controls access based on domains and user agents. Defines a default policy (either "allow" or "deny") and provides lists for explicitly allowed or denied domains and user agents.
        field :access_restrictions, Crystalline::Nilable.new(Models::Components::UnusedUploadsPlaybackIdAccessRestrictions), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessRestrictions') } }

        sig { params(access_policy: T.nilable(Models::Components::AccessPolicy), access_restrictions: T.nilable(Models::Components::UnusedUploadsPlaybackIdAccessRestrictions)).void }
        def initialize(access_policy: nil, access_restrictions: nil)
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
