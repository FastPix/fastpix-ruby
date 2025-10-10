#!/usr/bin/env ruby
# frozen_string_literal: true

# Basic FastPix Ruby SDK Usage Example
# This example demonstrates basic SDK setup, authentication, and simple operations

require 'fastpixapi'

# Configuration
USERNAME = ENV['FASTPIX_USERNAME'] || 'your_username_here'
PASSWORD = ENV['FASTPIX_PASSWORD'] || 'your_password_here'

puts "🚀 FastPix Ruby SDK - Basic Usage Example"
puts "=" * 50

begin
  # Initialize the SDK
  puts "\n1. Initializing FastPix SDK..."
  sdk = FastpixApiSDK::Fastpix.new(
    security: FastpixApiSDK::Models::Components::Security.new(
      username: USERNAME,
      password: PASSWORD
    )
  )
  puts "✅ SDK initialized successfully"

  # Test basic connectivity by listing media
  puts "\n2. Testing API connectivity..."
  begin
    media_response = sdk.manage_videos.list_media(limit: 5)
    
    if media_response.status_code == 200
      puts "✅ API connection successful"
      puts "   Status: #{media_response.status_code}"
      puts "   Media count: #{media_response.object&.data&.length || 0}"
    else
      puts "⚠️  API responded with status: #{media_response.status_code}"
    end
  rescue => e
    puts "❌ API connection failed: #{e.message}"
  end

  # Test live stream listing
  puts "\n3. Testing live stream operations..."
  begin
    streams_response = sdk.manage_live_stream.get_all_streams(limit: 5)
    
    if streams_response.status_code == 200
      puts "✅ Live streams API accessible"
      puts "   Status: #{streams_response.status_code}"
      puts "   Streams count: #{streams_response.object&.data&.length || 0}"
    else
      puts "⚠️  Live streams API responded with status: #{streams_response.status_code}"
    end
  rescue => e
    puts "❌ Live streams API failed: #{e.message}"
  end

  # Test analytics
  puts "\n4. Testing analytics operations..."
  begin
    views_response = sdk.views.list_video_views(request: FastpixApiSDK::Models::Operations::ListVideoViewsRequest.new(limit: 5, timespan: FastpixApiSDK::Models::Operations::ListVideoViewsRequestTimespan::SEVENDAYS))
    
    if views_response.status_code == 200
      puts "✅ Analytics API accessible"
      puts "   Status: #{views_response.status_code}"
      puts "   Views count: #{views_response.object&.data&.length || 0}"
    else
      puts "⚠️  Analytics API responded with status: #{views_response.status_code}"
    end
  rescue => e
    puts "❌ Analytics API failed: #{e.message}"
  end

  puts "\n🎉 Basic usage example completed!"
  puts "\nNext steps:"
  puts "- Check out media_upload.rb for media operations"
  puts "- Check out live_streaming.rb for live stream operations"
  puts "- Check out analytics.rb for data insights"

rescue => e
  puts "❌ SDK initialization failed: #{e.message}"
  puts "\nTroubleshooting:"
  puts "1. Verify your credentials are correct"
  puts "2. Check your internet connection"
  puts "3. Ensure you're using Ruby 3.2+"
  puts "4. Make sure the fastpixapi gem is installed"
end
