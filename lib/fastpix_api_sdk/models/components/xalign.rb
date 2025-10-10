
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # XAlign - Horizontal alignment of the watermark.
      class XAlign < T::Enum


        enums do
          LEFT = new('left')
          CENTER = new('center')
          RIGHT = new('right')
        end
      end
    end
  end
end
