#!/usr/bin/env ruby
# frozen_string_literal: true

# FastPix Ruby SDK - Live Streaming Examples
# This example demonstrates live stream creation and management

require 'fastpixapi'

# Configuration
USERNAME = ENV['FASTPIX_USERNAME'] || 'your_username_here'
PASSWORD = ENV['FASTPIX_PASSWORD'] || 'your_password_here'

puts "📺 FastPix Ruby SDK - Live Streaming Examples"
puts "=" * 50

begin
  # Initialize the SDK
  sdk = FastpixApiSDK::Fastpix.new(
    security: FastpixApiSDK::Models::Components::Security.new(
      username: USERNAME,
      password: PASSWORD
    )
  )
  puts "✅ SDK initialized successfully"

  # Example 1: List existing live streams
  puts "\n1. Listing existing live streams..."
  begin
    response = sdk.manage_live_stream.get_all_streams(limit: 10)
    
    if response.status_code == 200
      puts "✅ Live streams retrieved successfully"
      puts "   Total streams: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Recent streams:"
        response.object.data.first(3).each_with_index do |stream, index|
          puts "     #{index + 1}. ID: #{stream.id}"
          puts "        Status: #{stream.status || 'Unknown'}"
          puts "        Created: #{stream.created_at || 'Unknown'}"
        end
      end
    else
      puts "⚠️  Live streams listing failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Live streams listing failed: #{e.message}"
  end

  # Example 2: Create a new live stream
  puts "\n2. Creating a new live stream..."
  begin
    create_request = FastpixApiSDK::Models::Components::CreateLiveStreamRequest.new(
      name: "Sample Live Stream #{Time.now.strftime('%Y%m%d_%H%M%S')}",
      description: "Sample live stream created via Ruby SDK",
      access_policy: FastpixApiSDK::Models::Components::CreateLiveStreamRequestAccessPolicy::PUBLIC,
      metadata: {
        'source' => 'ruby_sdk_sample',
        'created_at' => Time.now.iso8601
      }
    )

    response = sdk.start_live_stream.create_new_stream(request: create_request)
    
    if response.status_code == 201
      puts "✅ Live stream created successfully"
      stream = response.object&.data
      puts "   Stream ID: #{stream&.id}"
      puts "   Stream Key: #{stream&.stream_key}"
      puts "   RTMP URL: #{stream&.rtmp_url}"
      puts "   Status: #{stream&.status}"
      
      # Store stream ID for later operations
      @stream_id = stream&.id
    else
      puts "⚠️  Live stream creation failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Live stream creation failed: #{e.message}"
  end

  # Example 3: Get live stream details (if we created one)
  if @stream_id
    puts "\n3. Getting live stream details..."
    begin
      response = sdk.manage_live_stream.get_live_stream_by_id(stream_id: @stream_id)
      
      if response.status_code == 200
        puts "✅ Live stream details retrieved successfully"
        stream = response.object&.data
        puts "   ID: #{stream&.id}"
        puts "   Name: #{stream&.name}"
        puts "   Status: #{stream&.status}"
        puts "   Stream Key: #{stream&.stream_key}"
        puts "   RTMP URL: #{stream&.rtmp_url}"
        puts "   Created: #{stream&.created_at}"
      else
        puts "⚠️  Live stream details retrieval failed with status: #{response.status_code}"
      end
    rescue => e
      puts "❌ Live stream details retrieval failed: #{e.message}"
    end
  end

  # Example 4: Create playback ID for live stream
  if @stream_id
    puts "\n4. Creating playback ID for live stream..."
    begin
      request_body = FastpixApiSDK::Models::Operations::CreatePlaybackIdOfStreamRequestBody.new(
        access_policy: FastpixApiSDK::Models::Components::PlaybackIdRequestAccessPolicy::PUBLIC
      )

      response = sdk.live_playback.create_playback_id_of_stream(
        stream_id: @stream_id,
        request_body: request_body
      )
      
      if response.status_code == 201
        puts "✅ Playback ID created successfully"
        playback = response.object&.data
        puts "   Playback ID: #{playback&.playback_id}"
        puts "   Access Policy: #{playback&.access_policy}"
        puts "   Created: #{playback&.created_at}"
        
        # Store playback ID for later operations
        @playback_id = playback&.playback_id
      else
        puts "⚠️  Playback ID creation failed with status: #{response.status_code}"
      end
    rescue => e
      puts "❌ Playback ID creation failed: #{e.message}"
    end
  end

  # Example 5: List live stream clips
  if @stream_id
    puts "\n5. Listing live stream clips..."
    begin
      response = sdk.live_playback.list_live_clips(stream_id: @stream_id, limit: 10)
      
      if response.status_code == 200
        puts "✅ Live stream clips retrieved successfully"
        puts "   Total clips: #{response.object&.data&.length || 0}"
        
        if response.object&.data&.any?
          puts "   Recent clips:"
          response.object.data.first(3).each_with_index do |clip, index|
            puts "     #{index + 1}. ID: #{clip.id}"
            puts "        Duration: #{clip.duration} seconds" if clip.duration
            puts "        Created: #{clip.created_at || 'Unknown'}"
          end
        end
      else
        puts "⚠️  Live stream clips listing failed with status: #{response.status_code}"
      end
    rescue => e
      puts "❌ Live stream clips listing failed: #{e.message}"
    end
  end

  # Example 6: Update live stream (if we created one)
  if @stream_id
    puts "\n6. Updating live stream..."
    begin
      update_request = FastpixApiSDK::Models::Components::PatchLiveStreamRequest.new(
        name: "Updated Live Stream #{Time.now.strftime('%Y%m%d_%H%M%S')}",
        description: "Updated live stream description",
        metadata: {
          'updated_at' => Time.now.iso8601,
          'updated_by' => 'ruby_sdk'
        }
      )

      response = sdk.manage_live_stream.update_live_stream(
        stream_id: @stream_id,
        request: update_request
      )
      
      if response.status_code == 200
        puts "✅ Live stream updated successfully"
        stream = response.object&.data
        puts "   Updated Name: #{stream&.name}"
        puts "   Updated Description: #{stream&.description}"
      else
        puts "⚠️  Live stream update failed with status: #{response.status_code}"
      end
    rescue => e
      puts "❌ Live stream update failed: #{e.message}"
    end
  end

  puts "\n🎉 Live streaming examples completed!"
  puts "\nNext steps:"
  puts "- Check out live_playback.rb for more playback operations"
  puts "- Check out simulcast.rb for simulcast streaming"
  puts "- Use the stream key and RTMP URL to start streaming from your encoder"

rescue => e
  puts "❌ Example failed: #{e.message}"
  puts "\nTroubleshooting:"
  puts "1. Verify your credentials are correct"
  puts "2. Check your internet connection"
  puts "3. Ensure you have proper permissions for live streaming operations"
end
