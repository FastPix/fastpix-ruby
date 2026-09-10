# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # UpdateLiveStreamUserAgentRestrictionsDefaultPolicy - The default behavior when a user-agent is not listed in `allow` or `deny`.
      class UpdateLiveStreamUserAgentRestrictionsDefaultPolicy < T::Enum


        enums do
          ALLOW = new('allow')
          DENY = new('deny')
        end
      end
    end
  end
end
