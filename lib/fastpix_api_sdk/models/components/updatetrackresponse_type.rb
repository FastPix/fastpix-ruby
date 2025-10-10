
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # UpdateTrackResponseType - Specifies the type of track (audio or subtitle).
      class UpdateTrackResponseType < T::Enum


        enums do
          AUDIO = new('audio')
          SUBTITLE = new('subtitle')
        end
      end
    end
  end
end
