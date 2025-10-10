
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # CreatePlaylistRequestType - For a smart playlist metadata is required.
      class CreatePlaylistRequestType < T::Enum


        enums do
          SMART = new('smart')
          MANUAL = new('manual')
        end
      end
    end
  end
end
