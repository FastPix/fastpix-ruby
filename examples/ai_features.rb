#!/usr/bin/env ruby
# frozen_string_literal: true

# Turn on in-video AI features (summary, chapters, named entities) for a media.
# These need a media that is already "Ready", so set FASTPIX_MEDIA_ID to an
# existing ready media id before running.

require 'fastpixapi'
require 'json'

Models = ::FastpixClient::Models
Ops = Models::Operations

media_id = ENV['FASTPIX_MEDIA_ID']
if media_id.nil? || media_id.empty?
  abort 'Set FASTPIX_MEDIA_ID to a ready media id first (see the comment at the top).'
end

sdk = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: ENV.fetch('FASTPIX_USERNAME'),
    password: ENV.fetch('FASTPIX_PASSWORD')
  )
)

summary = sdk.in_video_ai_features.update_media_summary(
  media_id: media_id,
  body: Ops::UpdateMediaSummaryRequestBody.new(generate: true)
)
puts "update_media_summary        -> HTTP #{summary.status_code}"

chapters = sdk.in_video_ai_features.update_media_chapters(
  media_id: media_id,
  body: Ops::UpdateMediaChaptersRequestBody.new(chapters: true)
)
puts "update_media_chapters       -> HTTP #{chapters.status_code}"

entities = sdk.in_video_ai_features.update_media_named_entities(
  media_id: media_id,
  body: Ops::UpdateMediaNamedEntitiesRequestBody.new(named_entities: true)
)
puts "update_media_named_entities -> HTTP #{entities.status_code}"
