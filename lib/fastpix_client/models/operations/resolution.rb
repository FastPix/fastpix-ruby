# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Resolution - The maximum resolution for the playback ID.
      class Resolution < T::Enum


        enums do
          FOUR_HUNDRED_AND_EIGHTYP = new('480p')
          SEVEN_HUNDRED_AND_TWENTYP = new('720p')
          ONE_THOUSAND_AND_EIGHTYP = new('1080p')
          ONE_THOUSAND_FOUR_HUNDRED_AND_FORTYP = new('1440p')
          TWO_THOUSAND_ONE_HUNDRED_AND_SIXTYP = new('2160p')
        end
      end
    end
  end
end
