#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'test_helper'
require_relative 'test_input_video'
require_relative 'test_manage_videos'
require_relative 'test_playback'
require_relative 'test_live_stream'
require_relative 'test_playlist'
require_relative 'test_drm'
require_relative 'test_analytics'

# Parse command line arguments
if ARGV.length != 2
  puts "❌ Usage: ruby tests/run_all_tests.rb <username> <password>"
  puts "   Example: ruby tests/run_all_tests.rb your-access-token your-secret-key"
  exit 1
end

username = ARGV[0]
password = ARGV[1]

puts "🚀 FastPix Ruby SDK Test Suite"
puts "=" * 60
puts "📝 Testing with credentials: #{username} / #{'*' * password.length}"
puts "=" * 60

# Reset counters
$passed_tests = 0
$failed_tests = 0
$total_tests = 0

# Run all test classes
test_classes = [
  { name: "Input Video APIs", file: "test_input_video", class_name: "TestInputVideo" },
  { name: "Media Management APIs", file: "test_manage_videos", class_name: "TestManageVideos" },
  { name: "Playback Management APIs", file: "test_playback", class_name: "TestPlayback" },
  { name: "Live Stream APIs", file: "test_live_stream", class_name: "TestLiveStream" },
  { name: "Playlist Management APIs", file: "test_playlist", class_name: "TestPlaylist" },
  { name: "DRM Configuration APIs", file: "test_drm", class_name: "TestDRM" },
  { name: "Analytics & Data APIs", file: "test_analytics", class_name: "TestAnalytics" }
]

test_classes.each do |test_info|
  FastpixTestHelper.print_section_header(test_info[:name])
  
  begin
    test_class = Object.const_get(test_info[:class_name])
    
    # Set credentials as class variables
    test_class.class_variable_set(:@@username, username)
    test_class.class_variable_set(:@@password, password)
    
    test_instance = test_class.new
    
    # Get all test methods and run them
    test_methods = test_instance.methods.grep(/^test_/)
    test_methods.each do |method_name|
      test_instance.send(method_name)
    end
    
  rescue => e
    puts "❌ Failed to load #{test_info[:name]}: #{e.message}"
    $failed_tests += 1
    $total_tests += 1
  end
end

# Print final summary
FastpixTestHelper.print_summary($passed_tests, $failed_tests, $total_tests)

# Exit with appropriate code
if $failed_tests > 0
  puts "\n❌ Some tests failed. Please check the output above."
  exit 1
else
  puts "\n✅ All tests passed!"
  exit 0
end
