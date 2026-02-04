# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Request body for direct upload
      class DirectUploadVideoMediaRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Configuration settings for uploading and processing media on the FastPix platform.  
        # These settings define how the uploaded video is handled, including access control, resolution, DRM, and optional metadata.  
        # For a complete explanation of how media uploads and processing work, refer to the  
        # <a href="https://docs.fastpix.io/docs/video-on-demand-overview" target="_blank">FastPix Video on Demand Overview</a>.
        # 
        field :push_media_settings, Crystalline::Nilable.new(Models::Operations::PushMediaSettings), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('pushMediaSettings') } }
        # Upload media directly from a device using the URL name or enter "*" to allow all.
        field :cors_origin, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('corsOrigin') } }

        sig { params(push_media_settings: T.nilable(Models::Operations::PushMediaSettings), cors_origin: T.nilable(::String)).void }
        def initialize(push_media_settings: nil, cors_origin: '*')
          @push_media_settings = push_media_settings
          @cors_origin = cors_origin
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @push_media_settings == other.push_media_settings
          return false unless @cors_origin == other.cors_origin
          true
        end
      end
    end
  end
end
