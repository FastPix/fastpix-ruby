#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative '../lib/fastpixapi'
require 'minitest/autorun'
require 'minitest/reporters'

# Configure minitest
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

module FastpixTestHelper
  # Test configuration
  TEST_TIMEOUT = 30000 # 30 seconds
  TEST_RETRIES = FastpixApiSDK::Utils::RetryConfig.new(
    backoff: FastpixApiSDK::Utils::BackoffStrategy.new(
      exponent: 1.5,
      initial_interval: 1000,
      max_elapsed_time: 10_000,
      max_interval: 2_000
    ),
    retry_connection_errors: true,
    strategy: 'backoff'
  )

  def self.create_sdk(username, password)
    ::FastpixApiSDK::Fastpix.new(
      security: ::FastpixApiSDK::Models::Components::Security.new(
        username: username,
        password: password,
      ),
      timeout_ms: TEST_TIMEOUT,
      retry_config: TEST_RETRIES
    )
  end

  def self.print_test_result(test_name, success, error_message = nil)
    if success
      puts "✅ #{test_name} - PASSED"
    else
      puts "❌ #{test_name} - FAILED"
      puts "   Error: #{error_message}" if error_message
    end
  end

  def self.print_section_header(section_name)
    puts "\n" + "="*60
    puts "🧪 TESTING #{section_name.upcase}"
    puts "="*60
  end

  def self.print_summary(passed, failed, total)
    puts "\n" + "="*60
    puts "📊 TEST SUMMARY"
    puts "="*60
    puts "Total Tests: #{total}"
    puts "Passed: #{passed} ✅"
    puts "Failed: #{failed} ❌"
    puts "Success Rate: #{((passed.to_f / total) * 100).round(1)}%"
    puts "="*60
  end
end

# Global test counters
$passed_tests = 0
$failed_tests = 0
$total_tests = 0

def run_test(test_name, &block)
  $total_tests += 1
  begin
    result = block.call
    if result
      $passed_tests += 1
      FastpixTestHelper.print_test_result(test_name, true)
    else
      $failed_tests += 1
      FastpixTestHelper.print_test_result(test_name, false, "Test returned false")
    end
  rescue => e
    $failed_tests += 1
    FastpixTestHelper.print_test_result(test_name, false, e.message)
  end
end