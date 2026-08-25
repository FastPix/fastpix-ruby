#!/usr/bin/env ruby
# frozen_string_literal: true

# Show the SDK constructor options: request timeout, retries, and a custom
# server URL. Each is optional; the defaults are fine for most apps.

require 'fastpixapi'

Models = ::FastpixClient::Models
Utils = ::FastpixClient::Utils

security = Models::Components::Security.new(
  username: ENV.fetch('FASTPIX_USERNAME'),
  password: ENV.fetch('FASTPIX_PASSWORD')
)

# Retries with exponential backoff (all fields optional).
retry_config = Utils::RetryConfig.new(
  backoff: Utils::BackoffStrategy.new(
    initial_interval: 500,   # ms
    max_interval: 10_000,    # ms
    exponent: 1.5,
    max_elapsed_time: 30_000 # ms
  ),
  retry_connection_errors: true
)

sdk = ::FastpixClient::Fastpixapi.new(
  security: security,
  timeout_ms: 20_000,        # per-request timeout
  retry_config: retry_config
  # server_url: 'https://api.fastpix.com/v1/'  # override the API base URL if needed
)

res = sdk.manage_videos.list_media(limit: 1)
puts "Configured client works -> HTTP #{res.status_code}"
