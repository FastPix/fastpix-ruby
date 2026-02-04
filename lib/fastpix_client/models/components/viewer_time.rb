# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # The unix epoch timestamp which represents the actual time the event has occurred.
      # 
      class ViewerTime
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
