#!/usr/bin/env ruby
# frozen_string_literal: true

# Flow: create a live stream, read it, toggle it, then delete it.
# New streams start enabled, so the demo order is disable -> enable.

require 'fastpixapi'
require 'json'

Models = ::FastpixClient::Models

sdk = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: ENV.fetch('FASTPIX_USERNAME'),
    password: ENV.fetch('FASTPIX_PASSWORD')
  )
)

def body(res)
  JSON.parse(res.raw_response.body)
rescue StandardError
  {}
end

# 1. Create a stream. You'll stream to the returned stream key over RTMP.
# (Live streaming has to be enabled on your account for this to succeed.)
begin
  create = sdk.start_live_stream.create_new_stream(
    request: Models::Components::CreateLiveStreamRequest.new(
      playback_settings: Models::Components::PlaybackSettings.new,
      input_media_settings: Models::Components::InputMediaSettings.new(
        metadata: { 'source' => 'live_streaming_example' }
      )
    )
  )
rescue FastpixClient::Models::Errors::APIError => e
  warn "create_new_stream failed: #{JSON.parse(e.body)['error']&.fetch('message', e.body) rescue e.body}"
  exit 1
end
data = body(create)['data'] || {}
stream_id = data['streamId']
puts "create_new_stream -> HTTP #{create.status_code}, stream id #{stream_id}"
puts "  stream key: #{data['streamKey']}"

# 2. Read it back.
get = sdk.manage_live_stream.get_live_stream_by_id(stream_id: stream_id)
puts "get_by_id         -> HTTP #{get.status_code}"

# 3. Toggle: a fresh stream is already enabled, so disable first.
disable = sdk.manage_live_stream.disable_live_stream(stream_id: stream_id)
puts "disable           -> HTTP #{disable.status_code}"
enable = sdk.manage_live_stream.enable_live_stream(stream_id: stream_id)
puts "enable            -> HTTP #{enable.status_code}"

# 4. Clean up.
del = sdk.manage_live_stream.delete_live_stream(stream_id: stream_id)
puts "delete            -> HTTP #{del.status_code}"
