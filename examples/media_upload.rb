#!/usr/bin/env ruby
# frozen_string_literal: true

# Flow: create a media from a public URL, read it back, then delete it.
# (For device uploads that mint a signed URL, see create_upload.rb.)

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

# 1. Create a media from a hosted file.
create = sdk.input_video.create_media(
  request: Models::Components::CreateMediaRequest.new(
    inputs: [
      Models::Components::PullVideoInput.new(
        type: 'video',
        url: 'https://static.fastpix.com/fp-sample-video.mp4'
      )
    ],
    metadata: { 'source' => 'media_upload_example' }
  )
)
media = body(create)['data']
media_id = media.is_a?(Array) ? media.first['id'] : media['id']
puts "create_media -> HTTP #{create.status_code}, media id #{media_id}"

# 2. Read it back. A freshly created media is still processing (status "Created").
get = sdk.manage_videos.get_media(media_id: media_id)
puts "get_media    -> HTTP #{get.status_code}, status #{body(get).dig('data', 'status')}"

# 3. Clean up so reruns stay tidy.
del = sdk.manage_videos.delete_media(media_id: media_id)
puts "delete_media -> HTTP #{del.status_code}"
