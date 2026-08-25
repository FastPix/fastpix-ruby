#!/usr/bin/env ruby
# frozen_string_literal: true

# Flow: create a manual playlist, add a media to it, read it, then delete it.

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

# 1. Create a manual playlist. reference_id must be alphanumeric and unique
#    per workspace, so derive a fresh one each run.
create = sdk.playlist.create_a_playlist(
  request: Models::Components::CreatePlaylistRequestManual.new(
    name: 'Example playlist',
    reference_id: "ex#{Time.now.to_i}#{rand(1000)}",
    type: Models::Components::CreatePlaylistRequestManualType::MANUAL,
    # description allows only alphanumerics, spaces, hyphens and underscores
    description: 'Created by the playlist management example'
  )
)
playlist_id = body(create).dig('data', 'id')
puts "create_a_playlist -> HTTP #{create.status_code}, playlist id #{playlist_id}"

# 2. Add an existing media, if the workspace has one.
media = sdk.manage_videos.list_media(limit: 1)
media_id = (body(media)['data'] || []).dig(0, 'id')
if media_id
  add = sdk.playlist.add_media_to_playlist(
    playlist_id: playlist_id,
    body: Models::Components::MediaIdsRequest.new(media_ids: [media_id])
  )
  puts "add_media         -> HTTP #{add.status_code}, media #{media_id}"
else
  puts 'add_media         -> skipped (no media in workspace)'
end

# 3. Read it back.
get = sdk.playlist.get_playlist_by_id(playlist_id: playlist_id)
puts "get_playlist      -> HTTP #{get.status_code}"

# 4. Clean up.
del = sdk.playlist.delete_a_playlist(playlist_id: playlist_id)
puts "delete_a_playlist -> HTTP #{del.status_code}"
