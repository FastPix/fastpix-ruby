# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # CreateLiveStreamRequestMaxResolution - Defines the maximum resolution for encoding, storage, and playback of the live stream.
      # 
      class CreateLiveStreamRequestMaxResolution < T::Enum


        enums do
          ONE_THOUSAND_AND_EIGHTYP = new('1080p')
          SEVEN_HUNDRED_AND_TWENTYP = new('720p')
          FOUR_HUNDRED_AND_EIGHTYP = new('480p')
        end
      end
    end
  end
end
