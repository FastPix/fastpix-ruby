
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # AudioInputType - Type of overlay (currently only supports 'audio').
      class AudioInputType < T::Enum


        enums do
          AUDIO = new('audio')
        end
      end
    end
  end
end
