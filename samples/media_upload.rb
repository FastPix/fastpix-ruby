#!/usr/bin/env ruby
# frozen_string_literal: true

# FastPix Ruby SDK - Media Upload Examples
# This example demonstrates various media upload methods

require 'fastpixapi'

# Configuration
USERNAME = ENV['FASTPIX_USERNAME'] || 'your_username_here'
PASSWORD = ENV['FASTPIX_PASSWORD'] || 'your_password_here'

puts "📹 FastPix Ruby SDK - Media Upload Examples"
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

  # Example 1: Upload media from URL
  puts "\n1. Uploading media from URL..."
  begin
    create_request = FastpixApiSDK::Models::Components::CreateMediaRequest.new(
      inputs: [
        FastpixApiSDK::Models::Components::VideoInput.new(
          type: 'video',
          url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
        )
      ],
      access_policy: FastpixApiSDK::Models::Components::CreateMediaRequestAccessPolicy::PUBLIC,
      metadata: {
        'source' => 'sample_upload',
        'description' => 'Sample video upload from URL'
      }
    )

    response = sdk.input_video.create_media(request: create_request)
    
    if response.status_code == 201
      puts "✅ Media uploaded successfully from URL"
      puts "   Media ID: #{response.object&.data&.first&.id}"
      puts "   Status: #{response.status_code}"
    else
      puts "⚠️  Upload failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ URL upload failed: #{e.message}"
  end

  # Example 2: Direct upload (get upload URL)
  puts "\n2. Creating direct upload URL..."
  begin
    response = sdk.input_video.direct_upload_video_media(
      cors_origin: 'https://example.com',
      push_media_settings: FastpixApiSDK::Models::Operations::PushMediaSettings.new(
        access_policy: FastpixApiSDK::Models::Components::BasicAccessPolicy::PUBLIC,
        metadata: {
          'upload_type' => 'direct_upload',
          'description' => 'Direct upload example'
        }
      )
    )

    if response.status_code == 201
      puts "✅ Direct upload URL created successfully"
      puts "   Upload ID: #{response.object&.data&.id}"
      puts "   Upload URL: #{response.object&.data&.url[0..100]}..."
      puts "   Timeout: #{response.object&.data&.timeout} seconds"
    else
      puts "⚠️  Direct upload creation failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Direct upload creation failed: #{e.message}"
  end

  # Example 3: List existing media
  puts "\n3. Listing existing media..."
  begin
    response = sdk.manage_videos.list_media(limit: 10)
    
    if response.status_code == 200
      puts "✅ Media list retrieved successfully"
      puts "   Total media: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Recent media:"
        response.object.data.first(3).each_with_index do |media, index|
          puts "     #{index + 1}. ID: #{media.id}"
          puts "        Status: #{media.status || 'Unknown'}"
          puts "        Created: #{media.created_at || 'Unknown'}"
        end
      end
    else
      puts "⚠️  Media listing failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Media listing failed: #{e.message}"
  end

  # Example 4: Get specific media by ID (if we have one)
  puts "\n4. Getting media details..."
  begin
    # First, try to get a media ID from the list
    list_response = sdk.manage_videos.list_media(limit: 1)
    
    if list_response.status_code == 200 && 
       list_response.object&.data&.any? &&
       list_response.object.data.first&.id
      
      media_id = list_response.object.data.first.id
      puts "   Using media ID: #{media_id}"
      
      response = sdk.manage_videos.get_media(media_id: media_id)
      
      if response.status_code == 200
        puts "✅ Media details retrieved successfully"
        media = response.object&.data
        puts "   ID: #{media&.id}"
        puts "   Status: #{media&.status}"
        puts "   Resolution: #{media&.max_resolution}"
        puts "   Duration: #{media&.duration} seconds" if media&.duration
      else
        puts "⚠️  Media details retrieval failed with status: #{response.status_code}"
      end
    else
      puts "ℹ️  No media available to retrieve details for"
    end
  rescue => e
    puts "❌ Media details retrieval failed: #{e.message}"
  end

  puts "\n🎉 Media upload examples completed!"
  puts "\nNext steps:"
  puts "- Check out media_management.rb for more media operations"
  puts "- Check out media_tracks.rb for adding audio/subtitle tracks"

rescue => e
  puts "❌ Example failed: #{e.message}"
  puts "\nTroubleshooting:"
  puts "1. Verify your credentials are correct"
  puts "2. Check your internet connection"
  puts "3. Ensure you have proper permissions for media operations"
end
