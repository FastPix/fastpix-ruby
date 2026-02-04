# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # MediaType - Type of media content
      class MediaType < T::Enum


        enums do
          VIDEO = new('video')
          AUDIO = new('audio')
          AV = new('av')
        end
      end
    end
  end
end
