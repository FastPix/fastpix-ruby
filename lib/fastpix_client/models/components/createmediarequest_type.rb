# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # CreateMediaRequestType - Defines the type of input. Possible values include video, audio, or av.
      # 
      class CreateMediaRequestType < T::Enum


        enums do
          VIDEO = new('video')
          AUDIO = new('audio')
          AV = new('av')
        end
      end
    end
  end
end
