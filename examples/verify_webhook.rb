#!/usr/bin/env ruby
# frozen_string_literal: true

# Verify a FastPix webhook signature before trusting the payload.
#
# FastPix signs the raw request body with your webhook Signing Secret
# (Dashboard > Webhooks) and sends it as a Base64 HMAC-SHA256 in the
# "FastPix-Signature" header. The Signing Secret is itself Base64-encoded, so
# sign with its decoded bytes as the key. Verify the body exactly as received:
# parsing and re-serializing changes the bytes and the signature won't match.
#
# This runs offline: it self-signs a demo payload and checks it.

require 'openssl'
require 'base64'

# Returns true if signature is a valid FastPix-Signature for raw_body.
def valid_signature?(raw_body, signature, secret)
  return false if secret.to_s.empty? || signature.to_s.empty?

  key = Base64.decode64(secret) # Signing Secret is Base64; use its decoded bytes.
  expected = Base64.strict_encode64(OpenSSL::HMAC.digest('SHA256', key, raw_body))
  secure_compare(expected, signature)
end

# Constant-time string comparison (stdlib has no public helper).
def secure_compare(a, b)
  return false unless a.bytesize == b.bytesize

  res = 0
  a.bytes.zip(b.bytes) { |x, y| res |= x ^ y }
  res.zero?
end

if __FILE__ == $PROGRAM_NAME
  secret = ENV['FASTPIX_WEBHOOK_SECRET'] || Base64.strict_encode64('demo-secret')
  raw_body = '{"type":"video.media.ready","data":{"id":"abc-123"}}'
  key = Base64.decode64(secret)
  signature = Base64.strict_encode64(OpenSSL::HMAC.digest('SHA256', key, raw_body))

  puts valid_signature?(raw_body, signature, secret) ? 'verified' : 'rejected'
  puts valid_signature?(raw_body, signature + 'x', secret) ? 'verified' : 'rejected (tampered)'
end
