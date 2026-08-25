# frozen_string_literal: true

# A minimal single-file Rails app with two endpoints:
#
#   POST /uploads   mint a signed direct-upload URL (client PUTs the file there)
#   POST /webhooks  verify a FastPix webhook signature, then handle the event
#
# The video file never passes through this server: the client uploads it
# straight to the signed URL. See README.md to run it.

require 'rails'
require 'action_controller/railtie'
require 'fastpixapi'
require 'openssl'
require 'base64'
require 'json'

Models = ::FastpixClient::Models

class App < Rails::Application
  config.root = __dir__
  config.eager_load = false
  config.consider_all_requests_local = true
  config.secret_key_base = 'demo-not-a-real-secret'
  config.logger = Logger.new($stdout)
  config.hosts.clear # demo only; set allowed hosts in production

  routes.append do
    post '/uploads',  to: 'app#uploads'
    post '/webhooks', to: 'app#webhooks'
  end
end

def fastpix
  ::FastpixClient::Fastpixapi.new(
    security: Models::Components::Security.new(
      username: ENV.fetch('FASTPIX_USERNAME'),
      password: ENV.fetch('FASTPIX_PASSWORD')
    )
  )
end

# Constant-time compare (stdlib has no public helper).
def secure_compare(a, b)
  return false unless a.bytesize == b.bytesize

  res = 0
  a.bytes.zip(b.bytes) { |x, y| res |= x ^ y }
  res.zero?
end

# Verify FastPix-Signature = Base64(HMAC-SHA256(decoded secret, raw body)).
def valid_signature?(raw_body, signature)
  secret = ENV['FASTPIX_WEBHOOK_SECRET']
  return false if secret.to_s.empty? || signature.to_s.empty?

  key = Base64.decode64(secret) # Signing Secret is Base64; use its decoded bytes.
  expected = Base64.strict_encode64(OpenSSL::HMAC.digest('SHA256', key, raw_body))
  secure_compare(expected, signature)
end

class AppController < ActionController::Base
  # Webhooks are server-to-server and HMAC-authed with no cookie, so CSRF
  # protection doesn't apply. Add auth to /uploads before you ship it.
  skip_forgery_protection

  # POST /uploads -> { uploadId, url }
  def uploads
    req = Models::Operations::DirectUploadVideoMediaRequest.new(
      cors_origin: '*', # tighten to your own origin in production
      push_media_settings: Models::Operations::PushMediaSettings.new(
        metadata: { 'source' => 'rails_example' }
      )
    )
    data = fastpix.input_video.direct_upload_video_media(request: req).object&.data
    render json: { uploadId: data&.upload_id, url: data&.url }
  end

  # POST /webhooks -> ack fast; verify the raw body before trusting it.
  def webhooks
    raw = request.body.read
    unless valid_signature?(raw, request.headers['FastPix-Signature'])
      return head :unauthorized
    end

    event = JSON.parse(raw)
    case event['type']
    when 'video.media.ready'
      Rails.logger.info("media ready: #{event.dig('data', 'id')}")
    when 'video.media.failed'
      Rails.logger.info("media failed: #{event.dig('data', 'id')}")
    else
      Rails.logger.info("unhandled event: #{event['type']}")
    end

    head :ok # 2xx quickly; FastPix retries on non-2xx.
  end
end

App.initialize!
