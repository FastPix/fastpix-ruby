
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class Details
        extend T::Sig
        include Crystalline::MetadataFields

        # The player_source_bitrate represents the bitrate of the video stream that is being played, measured in bits per second (bps). This value indicates the quality of the video being streamed, with higher bitrates typically corresponding to better video quality but requiring more bandwidth.
        # 
        field :player_source_bitrate, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('player_source_bitrate') } }
        # The player_source_codec represents the video or audio codec being used to decode and play the media. A codec is a technology used to compress and decompress digital media files, enabling efficient transmission and storage while maintaining quality.
        # 
        field :player_source_codec, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('player_source_codec') } }
        # The player_source_height refers to the vertical resolution of the video being played, measured in pixels. This value represents the height dimension of the video frame and is part of the overall resolution of the video (e.g., 1920x1080, where the height is 1080 pixels).
        # 
        field :player_source_height, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerSourceHeight') } }
        # The player_source_width refers to the horizontal resolution of the video being played, measured in pixels. This value represents the width dimension of the video frame and is part of the overall video resolution (e.g., 1920x1080, where the width is 1920 pixels).
        # 
        field :player_source_width, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerSourceWidth') } }

        sig { params(player_source_bitrate: T.nilable(::Integer), player_source_codec: T.nilable(::String), player_source_height: T.nilable(::Integer), player_source_width: T.nilable(::Integer)).void }
        def initialize(player_source_bitrate: nil, player_source_codec: nil, player_source_height: nil, player_source_width: nil)
          @player_source_bitrate = player_source_bitrate
          @player_source_codec = player_source_codec
          @player_source_height = player_source_height
          @player_source_width = player_source_width
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @player_source_bitrate == other.player_source_bitrate
          return false unless @player_source_codec == other.player_source_codec
          return false unless @player_source_height == other.player_source_height
          return false unless @player_source_width == other.player_source_width
          true
        end
      end
    end
  end
end
