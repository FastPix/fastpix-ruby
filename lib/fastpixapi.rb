# Code generated by Speakeasy (https://speakeasy.com). DO NOT EDIT.

# typed: true
# frozen_string_literal: true

module FastpixApiSDK
  autoload :SDK, 'fastpix_api_sdk/sdk'
  autoload :StartLiveStream, 'fastpix_api_sdk/start_live_stream'
  autoload :ManageLiveStream, 'fastpix_api_sdk/manage_live_stream'
  autoload :Playback, 'fastpix_api_sdk/playback'
  autoload :SimulcastStream, 'fastpix_api_sdk/simulcast_stream'
  autoload :InputVideo, 'fastpix_api_sdk/input_video'
  autoload :ManageVideos, 'fastpix_api_sdk/manage_videos'
  module Models
    autoload :Components, 'fastpix_api_sdk/models/components'
    autoload :Operations, 'fastpix_api_sdk/models/operations'
    autoload :Errors, 'fastpix_api_sdk/models/errors'
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
