
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # MediaClipResponseMaxResolution - The maximum resolution specified for the media.
      class MediaClipResponseMaxResolution < T::Enum


        enums do
          TWO_THOUSAND_ONE_HUNDRED_AND_SIXTYP = new('2160p')
          ONE_THOUSAND_FOUR_HUNDRED_AND_FORTYP = new('1440p')
          ONE_THOUSAND_AND_EIGHTYP = new('1080p')
          SEVEN_HUNDRED_AND_TWENTYP = new('720p')
          FOUR_HUNDRED_AND_EIGHTYP = new('480p')
          THREE_HUNDRED_AND_SIXTYP = new('360p')
        end
      end
    end
  end
end
