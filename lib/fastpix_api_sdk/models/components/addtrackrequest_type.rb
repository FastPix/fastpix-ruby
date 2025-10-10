
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # AddTrackRequestType - Specifies the type of track being added. It can be either `audio` or `subtitle`.
      class AddTrackRequestType < T::Enum


        enums do
          AUDIO = new('audio')
          SUBTITLE = new('subtitle')
        end
      end
    end
  end
end
