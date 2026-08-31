#!/usr/bin/env ruby
# frozen_string_literal: true

# Connectivity check: initialise the SDK and read from a few endpoints.

require 'fastpixapi'
require 'json'

Models = ::FastpixClient::Models

sdk = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: ENV.fetch('FASTPIX_USERNAME'),
    password: ENV.fetch('FASTPIX_PASSWORD')
  )
)

def count(res)
  data = JSON.parse(res.raw_response.body)['data']
  data.is_a?(Array) ? data.length : 'n/a'
rescue StandardError
  'n/a'
end

media = sdk.manage_videos.list_media(limit: 5)
puts "list_media           -> HTTP #{media.status_code}, #{count(media)} item(s)"

streams = sdk.manage_live_stream.get_all_streams(limit: 5)
puts "get_all_streams      -> HTTP #{streams.status_code}, #{count(streams)} item(s)"

views = sdk.views.list_video_views(
  request: Models::Operations::ListVideoViewsRequest.new(
    timespan: Models::Operations::ListVideoViewsTimespan::TWENTY_FOURHOURS
  )
)
puts "list_video_views     -> HTTP #{views.status_code}, #{count(views)} item(s)"
