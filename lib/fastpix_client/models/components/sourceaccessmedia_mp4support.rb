# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # SourceAccessMediaMp4Support - Determines the type of MP4 support for the media.
      # - **none**: Disables MP4 support.
      # - **capped_4k**: Enables MP4 downloads with resolutions up to 4K.
      # - **audioOnly**: Provides an MP4 stream containing only the audio.
      # - **audioOnly,capped_4k**: Enables both MP4 video downloads (up to 4K) and an audio-only stream.
      # 
      class SourceAccessMediaMp4Support < T::Enum


        enums do
          NONE = new('none')
          CAPPED_4K = new('capped_4k')
          AUDIO_ONLY = new('audioOnly')
          AUDIO_ONLY_CAPPED_4K = new('audioOnly,capped_4k')
        end
      end
    end
  end
end
