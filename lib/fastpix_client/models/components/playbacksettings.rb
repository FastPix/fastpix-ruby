# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Displays the result of the playback settings.
      class PlaybackSettings
        extend T::Sig
        include Crystalline::MetadataFields

        # Basic access policy for media content
        field :access_policy, Crystalline::Nilable.new(Models::Components::BasicAccessPolicy), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessPolicy'), 'decoder': Utils.enum_from_string(Models::Components::BasicAccessPolicy, true) } }

        sig { params(access_policy: T.nilable(Models::Components::BasicAccessPolicy)).void }
        def initialize(access_policy: Models::Components::BasicAccessPolicy::PUBLIC)
          @access_policy = access_policy
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @access_policy == other.access_policy
          true
        end
      end
    end
  end
end
