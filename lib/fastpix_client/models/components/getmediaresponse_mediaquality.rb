# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # GetMediaResponseMediaQuality - The quality tier applied to the media.
      class GetMediaResponseMediaQuality < T::Enum


        enums do
          STANDARD = new('standard')
          PRO = new('pro')
          PREMIUM = new('premium')
        end
      end
    end
  end
end
