#!/usr/bin/env ruby
# frozen_string_literal: true

# Mint a signed direct-upload URL. The client then PUTs the file straight to
# that URL, so the bytes never touch your server. See examples/README.md for
# setup and how to upload the file once you have the URL.

require 'fastpixapi'

Models = ::FastpixClient::Models

sdk = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: ENV.fetch('FASTPIX_USERNAME'),
    password: ENV.fetch('FASTPIX_PASSWORD')
  )
)

req = Models::Operations::DirectUploadVideoMediaRequest.new(
  cors_origin: '*', # tighten this to your own origin before you ship
  push_media_settings: Models::Operations::PushMediaSettings.new(
    metadata: { 'source' => 'create_upload_example' }
  )
)

res = sdk.input_video.direct_upload_video_media(request: req)
data = res.object&.data

puts "Upload ID: #{data&.upload_id}"
puts "Timeout:   #{data&.timeout}s"
puts
puts 'PUT your file to this signed URL to upload it:'
puts data&.url
puts
puts 'e.g.  curl -X PUT --upload-file video.mp4 \\'
puts '        -H "Content-Type: video/mp4" "<the url above>"'
