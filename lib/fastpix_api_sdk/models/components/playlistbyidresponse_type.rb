
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # PlaylistByIdResponseType - type of the playlist, when it was created
      class PlaylistByIdResponseType < T::Enum


        enums do
          MANUAL = new('manual')
          SMART = new('smart')
        end
      end
    end
  end
end
