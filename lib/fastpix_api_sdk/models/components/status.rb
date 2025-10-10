
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Status - The current processing status of the media.
      class Status < T::Enum


        enums do
          PREPARING = new('preparing')
          READY = new('ready')
          FAILED = new('failed')
          CREATED = new('created')
        end
      end
    end
  end
end
