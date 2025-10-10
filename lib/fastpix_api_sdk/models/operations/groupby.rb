
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # GroupBy - Pass this value to group the metrics list by.
      # 
      class GroupBy < T::Enum


        enums do
          MINUTE = new('minute')
          TEN_MINUTES = new('ten_minutes')
          HOUR = new('hour')
          DAY = new('day')
        end
      end
    end
  end
end
