#!/usr/bin/env ruby
# frozen_string_literal: true

# How to handle API errors. Every failed request raises
# FastpixClient::Models::Errors::APIError, which carries the HTTP status and
# the raw response body so you can read the server's error details.

require 'fastpixapi'
require 'json'
require 'securerandom'

Models = ::FastpixClient::Models

sdk = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: ENV.fetch('FASTPIX_USERNAME'),
    password: ENV.fetch('FASTPIX_PASSWORD')
  )
)

begin
  # A media id that doesn't exist -> the API returns an error.
  sdk.manage_videos.get_media(media_id: SecureRandom.uuid)
rescue FastpixClient::Models::Errors::APIError => e
  puts "Caught APIError: HTTP #{e.status_code}"
  error = (JSON.parse(e.body)['error'] rescue nil)
  puts "  message: #{error&.fetch('message', nil) || e.body}"
end
