#!/usr/bin/env ruby
# frozen_string_literal: true

# Offline checks for the examples. No credentials or network needed.
#   ruby examples/test_examples.rb
require 'minitest/autorun'
require 'open3'

HERE = __dir__
RUBY_EXAMPLES = Dir[File.join(HERE, '*.rb')].reject { |f| File.basename(f) == 'test_examples.rb' } +
                Dir[File.join(HERE, 'rails-example', 'app.rb')]

class ExampleWellFormednessTest < Minitest::Test
  # A UUID that isn't all-zeros looks like a real credential.
  REAL_UUID = /\b(?!0{8}-0{4}-0{4}-0{4}-0{12})[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\b/

  def test_every_example_parses
    RUBY_EXAMPLES.each do |file|
      _out, err, status = Open3.capture3('ruby', '-c', file)
      assert status.success?, "#{File.basename(file)} failed to parse: #{err}"
    end
  end

  def test_credentials_come_from_env
    RUBY_EXAMPLES.each do |file|
      src = File.read(file)
      next unless src.include?('FASTPIX_USERNAME')

      assert_match(/ENV\.fetch\(['"]FASTPIX_USERNAME|ENV\[['"]FASTPIX_USERNAME/, src,
                   "#{File.basename(file)} should read FASTPIX_USERNAME from the environment")
    end
  end

  def test_no_hardcoded_credentials
    RUBY_EXAMPLES.each do |file|
      src = File.read(file)
      refute_match REAL_UUID, src, "#{File.basename(file)} appears to contain a hardcoded credential"
    end
  end
end

class WebhookVerifierTest < Minitest::Test
  def setup
    # Load verify_webhook.rb without running its demo main.
    require File.join(HERE, 'verify_webhook.rb')
    @secret = Base64.strict_encode64('signing-secret')
    @body = '{"type":"video.media.ready","data":{"id":"abc-123"}}'
    key = Base64.decode64(@secret)
    @sig = Base64.strict_encode64(OpenSSL::HMAC.digest('SHA256', key, @body))
  end

  def test_valid_signature_passes
    assert valid_signature?(@body, @sig, @secret)
  end

  def test_wrong_signature_fails
    refute valid_signature?(@body, "#{@sig}x", @secret)
  end

  def test_tampered_body_fails
    refute valid_signature?("#{@body} ", @sig, @secret)
  end

  def test_missing_inputs_fail
    refute valid_signature?(@body, '', @secret)
    refute valid_signature?(@body, @sig, '')
  end
end
