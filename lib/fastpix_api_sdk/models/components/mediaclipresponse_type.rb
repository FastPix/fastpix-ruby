
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # MediaClipResponseType - The type of media track.
      class MediaClipResponseType < T::Enum


        enums do
          VIDEO = new('video')
          AUDIO = new('audio')
          SUBTITLE = new('subtitle')
        end
      end
    end
  end
end
