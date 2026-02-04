# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # UpdateUserAgentRestrictionsDefaultPolicy - The default behavior when a user-agent is not listed in `allow` or `deny`.
      class UpdateUserAgentRestrictionsDefaultPolicy < T::Enum


        enums do
          ALLOW = new('allow')
          DENY = new('deny')
        end
      end
    end
  end
end
