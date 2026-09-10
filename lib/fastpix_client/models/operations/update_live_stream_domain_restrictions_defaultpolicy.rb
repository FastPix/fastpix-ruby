# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # UpdateLiveStreamDomainRestrictionsDefaultPolicy - Specify the fallback behavior for domains that are not listed in the `allow` or `deny` lists.
      class UpdateLiveStreamDomainRestrictionsDefaultPolicy < T::Enum


        enums do
          ALLOW = new('allow')
          DENY = new('deny')
        end
      end
    end
  end
end
