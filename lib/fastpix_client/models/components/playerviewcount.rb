# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Represents the total number of times the video player has been initialized or viewed for a specific session or video. This metric helps track playback engagement and identify view patterns across different players or sessions.
      # 
      class PlayerViewCount
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
