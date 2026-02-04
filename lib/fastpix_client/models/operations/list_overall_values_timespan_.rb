# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # ListOverallValuesTimespan - This parameter specifies the time span between which the video views list must be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.
      # 
      # **Accepted formats are:**
      # 
      # array of epoch timestamps for example 
      # `timespan[]=1498867200&timespan[]=1498953600`
      # 
      # duration string for example  
      # `timespan[]=24:hours` or `timespan[]=7:days`
      # 
      class ListOverallValuesTimespan < T::Enum


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
