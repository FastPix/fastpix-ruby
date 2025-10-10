
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # Pass the error code to filter the list of views. The possible values of error code can be fetched from list of errors end point.
      # 
      class ErrorCode
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
