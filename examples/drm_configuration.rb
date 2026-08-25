#!/usr/bin/env ruby
# frozen_string_literal: true

# Read-only: list your DRM configurations and fetch one by id.
# DRM configs are created in the Dashboard; the SDK reads them.

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

# The list endpoint returns 400 when the workspace has no DRM configuration yet.
begin
  list = sdk.drm_configurations.get_drm_configuration(limit: 10)
rescue FastpixClient::Models::Errors::APIError => e
  warn "get_drm_configuration: #{JSON.parse(e.body).dig('error', 'message') rescue e.body}"
  warn 'Create a DRM configuration in the Dashboard, then rerun.'
  exit 0
end
configs = body(list)['data'] || []
puts "get_drm_configuration       -> HTTP #{list.status_code}, #{configs.length} config(s)"

if (drm_id = configs.dig(0, 'id'))
  one = sdk.drm_configurations.get_drm_configuration_by_id(drm_configuration_id: drm_id)
  puts "get_drm_configuration_by_id -> HTTP #{one.status_code}, id #{drm_id}"
else
  puts 'get_drm_configuration_by_id -> skipped (no DRM configs; create one in the Dashboard)'
end
