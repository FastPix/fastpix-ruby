# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true

require_relative 'fastpix_client/utils/utils'
require_relative 'fastpix_client/utils/request_bodies'
require_relative 'fastpix_client/utils/query_params'
require_relative 'fastpix_client/utils/forms'
require_relative 'fastpix_client/utils/headers'
require_relative 'fastpix_client/utils/url'
require_relative 'fastpix_client/utils/security'
require_relative 'crystalline'
require_relative 'fastpix_client/sdkconfiguration'

module FastpixClient
  autoload :Fastpixapi, 'fastpix_client/fastpixapi'
  autoload :InputVideo, 'fastpix_client/input_video'
  autoload :ManageVideos, 'fastpix_client/manage_videos'
  autoload :InVideoAIFeatures, 'fastpix_client/in_video_ai_features'
  autoload :Playback, 'fastpix_client/playback'
  autoload :Playlist, 'fastpix_client/playlist'
  autoload :DRMConfigurations, 'fastpix_client/drm_configurations'
  autoload :StartLiveStream, 'fastpix_client/start_live_stream'
  autoload :ManageLiveStream, 'fastpix_client/manage_live_stream'
  autoload :LivePlayback, 'fastpix_client/live_playback'
  autoload :SimulcastStream, 'fastpix_client/simulcast_stream'
  autoload :SigningKeys, 'fastpix_client/signing_keys'
  autoload :Views, 'fastpix_client/views'
  autoload :Dimensions, 'fastpix_client/dimensions'
  autoload :Metrics, 'fastpix_client/metrics'
  autoload :Errors, 'fastpix_client/errors'
  module Models
    autoload :Components, 'fastpix_client/models/components'
    autoload :Operations, 'fastpix_client/models/operations'
    autoload :Errors, 'fastpix_client/models/errors'
    autoload :Callbacks, 'fastpix_client/models/callbacks'
  end
end
