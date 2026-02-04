# frozen_string_literal: true

source 'https://rubygems.org'

# Patch OpenSSL before loading any gems
begin
  require_relative 'lib/openssl_patch'
rescue LoadError
  # Ignore if file doesn't exist yet
end

# Specify your gem's dependencies in openapi.gemspec
gemspec
