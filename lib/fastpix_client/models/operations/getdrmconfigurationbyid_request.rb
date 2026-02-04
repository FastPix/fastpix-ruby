# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class GetDrmConfigurationByIdRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier of the DRM configuration.
        field :drm_configuration_id, ::String, { 'path_param': { 'field_name': 'drmConfigurationId', 'style': 'simple', 'explode': false } }

        sig { params(drm_configuration_id: ::String).void }
        def initialize(drm_configuration_id:)
          @drm_configuration_id = drm_configuration_id
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @drm_configuration_id == other.drm_configuration_id
          true
        end
      end
    end
  end
end
