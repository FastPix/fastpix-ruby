# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class PlaybackIdSuccessResponseData
        extend T::Sig
        include Crystalline::MetadataFields

        # Unique identifier for the playbackId
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('id') } }
        # Determines if access to the streamed content is kept private or available to all.
        field :access_policy, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessPolicy') } }
        # Domain and user-agent access restrictions applied to the live playback ID.
        field :access_restrictions, Crystalline::Nilable.new(Models::Components::PlaybackIdAccessRestrictions), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessRestrictions') } }

        sig { params(id: T.nilable(::String), access_policy: T.nilable(::String), access_restrictions: T.nilable(Models::Components::PlaybackIdAccessRestrictions)).void }
        def initialize(id: nil, access_policy: nil, access_restrictions: nil)
          @id = id
          @access_policy = access_policy
          @access_restrictions = access_restrictions
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @access_policy == other.access_policy
          return false unless @access_restrictions == other.access_restrictions
          true
        end
      end
    end
  end
end
