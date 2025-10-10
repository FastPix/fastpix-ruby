
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class PlaylistItemType < T::Enum


        enums do
          MANUAL = new('manual')
          SMART = new('smart')
        end
      end
    end
  end
end
