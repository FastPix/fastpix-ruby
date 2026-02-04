# typed: true
# frozen_string_literal: true

# Patch OpenSSL before loading any other gems
begin
  require_relative 'lib/openssl_patch'
rescue LoadError
  # Ignore if file doesn't exist
end

require 'bundler/gem_tasks'
require 'minitest/test_task'
require 'rubocop/rake_task'

RuboCop::RakeTask.new

Minitest::TestTask.create do |t|
  # workaround to avoid throwing warnings from Janeway library circular require...
  t.warning = false
end

task :default => :test


# Developers can run all tests with:
#
# $ rake test
#
# Developers can run individual test files with:
#
# $ rake test test/parameter_test
#
# and run individual tests by adding `focus` to the line before the test definition.