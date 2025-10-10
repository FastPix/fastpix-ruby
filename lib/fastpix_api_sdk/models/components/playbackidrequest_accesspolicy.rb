
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # PlaybackIdRequestAccessPolicy - Determines if access to the streamed content is kept private or available to all.
      class PlaybackIdRequestAccessPolicy < T::Enum
        enums do
          PUBLIC = new('public')
          PRIVATE = new('private')
        end
      end
    end
  end
end
