# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # DirectUploadVideoMediaAccessPolicy - Determines if access to the streamed content is kept private, drm or available to all.
      class DirectUploadVideoMediaAccessPolicy < T::Enum


        enums do
          PUBLIC = new('public')
          PRIVATE = new('private')
          DRM = new('drm')
        end
      end
    end
  end
end
