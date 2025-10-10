
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # BasicAccessPolicy - Basic access policy for media content
      class BasicAccessPolicy < T::Enum


        enums do
          PUBLIC = new('public')
          PRIVATE = new('private')
        end
      end
    end
  end
end
