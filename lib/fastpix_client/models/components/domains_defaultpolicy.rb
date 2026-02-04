# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # DomainsDefaultPolicy - Specifies the default access policy for domains. 
      # If set to `allow`, all domains are allowed access unless otherwise specified in the `deny` lists. 
      # If set to `deny`, all domains are denied access unless otherwise specified in the `allow` lists.
      # 
      class DomainsDefaultPolicy < T::Enum


        enums do
          ALLOW = new('allow')
          DENY = new('deny')
        end
      end
    end
  end
end
