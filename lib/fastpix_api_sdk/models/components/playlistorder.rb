
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # PlaylistOrder - Determines the insertion order of media into playlist.
      class PlaylistOrder < T::Enum


        enums do
          CREATED_DATE_ASC = new('createdDate ASC')
          CREATED_DATE_DESC = new('createdDate DESC')
        end
      end
    end
  end
end
