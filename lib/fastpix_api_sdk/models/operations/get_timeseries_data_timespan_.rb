
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # GetTimeseriesDataTimespan - This parameter specifies the time span between which the video views list should be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.
      # 
      class GetTimeseriesDataTimespan < T::Enum


        enums do
          SIXTYMINUTES = new('60:minutes')
          SIXHOURS = new('6:hours')
          TWENTY_FOURHOURS = new('24:hours')
          THREEDAYS = new('3:days')
          SEVENDAYS = new('7:days')
          THIRTYDAYS = new('30:days')
        end
      end
    end
  end
end
