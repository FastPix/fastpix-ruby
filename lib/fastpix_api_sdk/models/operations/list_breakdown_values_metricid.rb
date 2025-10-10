
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # ListBreakdownValuesMetricId - Pass metric Id
      # 
      class ListBreakdownValuesMetricId < T::Enum


        enums do
          VIEWS = new('views')
          UNIQUE_VIEWERS = new('unique_viewers')
          PLAYING_TIME = new('playing_time')
          QUALITY_OF_EXPERIENCE_SCORE = new('quality_of_experience_score')
          PLAYBACK_SCORE = new('playback_score')
          PLAYBACK_FAILURE_PERCENTAGE = new('playback_failure_percentage')
          EXIT_BEFORE_VIDEO_START = new('exit_before_video_start')
          VIDEO_STARTUP_FAILURE_PERCENTAGE = new('video_startup_failure_percentage')
          STARTUP_SCORE = new('startup_score')
          VIDEO_STARTUP_TIME = new('video_startup_time')
          PLAYER_STARTUP_TIME = new('player_startup_time')
          PAGE_LOAD_TIME = new('page_load_time')
          TOTAL_STARTUP_TIME = new('total_startup_time')
          LIVE_STREAM_LATENCY = new('live_stream_latency')
          AVERAGE_BITRATE = new('average_bitrate')
          BUFFER_COUNT = new('buffer_count')
          RENDER_QUALITY_SCORE = new('render_quality_score')
          AVG_UPSCALING = new('avg_upscaling')
          AVG_DOWNSCALING = new('avg_downscaling')
          MAX_UPSCALING = new('max_upscaling')
          MAX_DOWNSCALING = new('max_downscaling')
          JUMP_LATENCY = new('jump_latency')
          STABILITY_SCORE = new('stability_score')
          BUFFER_RATIO = new('buffer_ratio')
          BUFFER_FREQUENCY = new('buffer_frequency')
          BUFFER_FILL = new('buffer_fill')
        end
      end
    end
  end
end
