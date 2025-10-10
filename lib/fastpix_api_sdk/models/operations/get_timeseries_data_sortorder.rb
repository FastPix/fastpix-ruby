
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # GetTimeseriesDataSortOrder - The order direction to sort the metrics list by.
      # 
      class GetTimeseriesDataSortOrder < T::Enum


        enums do
          ASC = new('asc')
          DESC = new('desc')
        end
      end
    end
  end
end
