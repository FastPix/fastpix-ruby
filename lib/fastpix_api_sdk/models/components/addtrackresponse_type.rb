
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # AddTrackResponseType - Specifies the type of track (audio or subtitle).
      class AddTrackResponseType < T::Enum


        enums do
          AUDIO = new('audio')
          SUBTITLE = new('subtitle')
        end
      end
    end
  end
end
