# Code generated by Speakeasy (https://speakeasy.com). DO NOT EDIT.

# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # PlaybackIdDomainsDefaultPolicy - This sets the default behavior for domain access (either "allow" or "deny").
      class PlaybackIdDomainsDefaultPolicy < T::Enum
        enums do
          ALLOW = new('allow')
          DENY = new('deny')
        end
      end
    end
  end
end
