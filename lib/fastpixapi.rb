# typed: true
# frozen_string_literal: true

module FastpixApiSDK
  autoload :Fastpix, 'fastpix_api_sdk/fastpix'
  autoload :InputVideo, 'fastpix_api_sdk/input_video'
  autoload :ManageVideos, 'fastpix_api_sdk/manage_videos'
  autoload :InVideoAIFeatures, 'fastpix_api_sdk/in_video_ai_features'
  autoload :Playback, 'fastpix_api_sdk/playback'
  autoload :Playlist, 'fastpix_api_sdk/playlist'
  autoload :DRMConfigurations, 'fastpix_api_sdk/drm_configurations'
  autoload :StartLiveStream, 'fastpix_api_sdk/start_live_stream'
  autoload :ManageLiveStream, 'fastpix_api_sdk/manage_live_stream'
  autoload :LivePlayback, 'fastpix_api_sdk/live_playback'
  autoload :SimulcastStream, 'fastpix_api_sdk/simulcast_stream'
  autoload :SigningKeys, 'fastpix_api_sdk/signing_keys'
  autoload :Views, 'fastpix_api_sdk/views'
  autoload :Dimensions, 'fastpix_api_sdk/dimensions'
  autoload :Metrics, 'fastpix_api_sdk/metrics'
  autoload :Errors, 'fastpix_api_sdk/errors'
  module Models
    autoload :Components, 'fastpix_api_sdk/models/components'
    autoload :Operations, 'fastpix_api_sdk/models/operations'
    autoload :Errors, 'fastpix_api_sdk/models/errors'
    autoload :Callbacks, 'fastpix_api_sdk/models/callbacks'
  end
end

require_relative 'fastpix_api_sdk/utils/utils'
require_relative 'fastpix_api_sdk/utils/request_bodies'
require_relative 'fastpix_api_sdk/utils/query_params'
require_relative 'fastpix_api_sdk/utils/forms'
require_relative 'fastpix_api_sdk/utils/headers'
require_relative 'fastpix_api_sdk/utils/url'
require_relative 'fastpix_api_sdk/utils/security'
require_relative 'crystalline'
require_relative 'fastpix_api_sdk/sdkconfiguration'
