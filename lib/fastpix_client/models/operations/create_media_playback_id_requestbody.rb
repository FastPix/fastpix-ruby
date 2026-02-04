# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Request body for creating playback id for an media
      class CreateMediaPlaybackIdRequestBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Access policy for media content
        field :access_policy, Models::Components::AccessPolicy, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessPolicy'), required: true, 'decoder': Utils.enum_from_string(Models::Components::AccessPolicy, false) } }

        field :access_restrictions, Crystalline::Nilable.new(Models::Operations::CreateMediaPlaybackIdAccessRestrictions), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessRestrictions') } }
        # DRM configuration ID (required if accessPolicy is "drm")
        field :drm_configuration_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('drmConfigurationId') } }
        # The maximum resolution for the playback ID.
        field :resolution, Crystalline::Nilable.new(Models::Operations::Resolution), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('resolution'), 'decoder': Utils.enum_from_string(Models::Operations::Resolution, true) } }

        sig { params(access_policy: Models::Components::AccessPolicy, access_restrictions: T.nilable(Models::Operations::CreateMediaPlaybackIdAccessRestrictions), drm_configuration_id: T.nilable(::String), resolution: T.nilable(Models::Operations::Resolution)).void }
        def initialize(access_policy:, access_restrictions: nil, drm_configuration_id: nil, resolution: nil)
          @access_policy = access_policy
          @access_restrictions = access_restrictions
          @drm_configuration_id = drm_configuration_id
          @resolution = resolution
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @access_policy == other.access_policy
          return false unless @access_restrictions == other.access_restrictions
          return false unless @drm_configuration_id == other.drm_configuration_id
          return false unless @resolution == other.resolution
          true
        end
      end
    end
  end
end
