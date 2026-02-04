# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # UserAgentsDefaultPolicy - Specifies the default access policy for user agents (browsers, bots, etc.).
      # If set to `allow`, all user agents are allowed access unless otherwise specified in the `deny` lists. 
      # If set to `deny`, all user agents are denied access unless otherwise specified in the `allow` lists.
      # 
      class UserAgentsDefaultPolicy < T::Enum


        enums do
          ALLOW = new('allow')
          DENY = new('deny')
        end
      end
    end
  end
end
