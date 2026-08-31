#!/usr/bin/env ruby
# frozen_string_literal: true

# Flow: create a signing key, read it back, then delete it.
# Signing keys sign playback tokens for private/DRM playback.

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

# 1. Create a key. The private key comes back once, here only.
# Creating signing keys needs an access token with system/admin permission.
begin
  create = sdk.signing_keys.create_signing_key
rescue FastpixClient::Models::Errors::APIError => e
  warn "create_signing_key failed: #{JSON.parse(e.body).dig('error', 'message') rescue e.body}"
  exit 1
end
key_id = body(create).dig('data', 'id')
puts "create_signing_key   -> HTTP #{create.status_code}, key id #{key_id}"

# 2. Read it back (metadata only, no private key).
get = sdk.signing_keys.get_signing_key_by_id(signing_key_id: key_id)
puts "get_signing_key_by_id -> HTTP #{get.status_code}"

# 3. Clean up.
del = sdk.signing_keys.delete_signing_key(signing_key_id: key_id)
puts "delete_signing_key   -> HTTP #{del.status_code}"
