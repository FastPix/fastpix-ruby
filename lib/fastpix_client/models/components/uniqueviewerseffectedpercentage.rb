# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # percentage of unique viewers affected by the specific error.
      class UniqueViewersEffectedPercentage
        extend T::Sig
        include Crystalline::MetadataFields


        
        def initialize; end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          true
        end
      end
    end
  end
end
