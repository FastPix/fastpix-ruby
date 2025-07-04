# Code generated by Speakeasy (https://speakeasy.com). DO NOT EDIT.

# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # Mp4Support - Generates MP4 video up to 4K ("capped_4k"), m4a audio only ("audioOnly"), or both for offline viewing.
      # 
      class Mp4Support < T::Enum
        enums do
          CAPPED_4K = new('capped_4k')
          AUDIO_ONLY = new('audioOnly')
          AUDIO_ONLY_CAPPED_4K = new('audioOnly,capped_4k')
        end
      end
    end
  end
end
