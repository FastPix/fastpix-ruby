
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # AccessPolicy - Access policy for media content
      class AccessPolicy < T::Enum


        enums do
          PUBLIC = new('public')
          PRIVATE = new('private')
          DRM = new('drm')
        end
      end
    end
  end
end
