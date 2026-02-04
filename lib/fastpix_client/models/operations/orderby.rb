# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # OrderBy - The list of value can be order in two ways DESC (Descending) or ASC (Ascending). In case not specified, by default it will be DESC.
      class OrderBy < T::Enum


        enums do
          ASC = new('asc')
          DESC = new('desc')
        end
      end
    end
  end
end
