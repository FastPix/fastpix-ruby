
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # PlaylistCreatedSchemaType - Type will be either smart or manual, as sent in the request body.
      class PlaylistCreatedSchemaType < T::Enum


        enums do
          SMART = new('smart')
          MANUAL = new('manual')
        end
      end
    end
  end
end
