# typed: true
# frozen_string_literal: true

# Patch OpenSSL before loading any other gems
begin
  require_relative 'lib/openssl_patch'
rescue LoadError
  # Ignore if file doesn't exist
end

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

# Offline RSpec suite under spec/ (no credentials needed).
# Fails on any failing example and (via spec_helper) when zero examples are found.
RSpec::Core::RakeTask.new(:test) do |t|
  t.rspec_opts = '--require spec_helper'
end

task default: :test
