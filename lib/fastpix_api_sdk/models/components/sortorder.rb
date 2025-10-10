
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # SortOrder - The values in the list can be arranged in two ways: DESC (Descending) or ASC (Ascending).
      class SortOrder < T::Enum


        enums do
          ASC = new('asc')
          DESC = new('desc')
        end
      end
    end
  end
end
