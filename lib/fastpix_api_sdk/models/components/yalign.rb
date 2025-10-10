
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # YAlign - Vertical alignment of the watermark.
      class YAlign < T::Enum


        enums do
          TOP = new('top')
          MIDDLE = new('middle')
          BOTTOM = new('bottom')
        end
      end
    end
  end
end
