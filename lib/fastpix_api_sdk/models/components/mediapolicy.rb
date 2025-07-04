# Code generated by Speakeasy (https://speakeasy.com). DO NOT EDIT.

# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # MediaPolicy - Determines whether the recorded stream should be publicly accessible or private in Live to VOD (Video on Demand).
      class MediaPolicy < T::Enum
        enums do
          PUBLIC = new('public')
          PRIVATE = new('private')
        end
      end
    end
  end
end
