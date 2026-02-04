# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # GetPlaybackIdAccessPolicy - The access policy set for the playback ID.
      class GetPlaybackIdAccessPolicy < T::Enum


        enums do
          PUBLIC = new('public')
          PRIVATE = new('private')
          DRM = new('drm')
        end
      end
    end
  end
end
