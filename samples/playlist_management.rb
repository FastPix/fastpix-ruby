#!/usr/bin/env ruby
# frozen_string_literal: true

# FastPix Ruby SDK - Playlist Management Examples
# This example demonstrates playlist creation and management

require 'fastpixapi'

# Configuration
USERNAME = ENV['FASTPIX_USERNAME'] || 'your_username_here'
PASSWORD = ENV['FASTPIX_PASSWORD'] || 'your_password_here'

puts "📋 FastPix Ruby SDK - Playlist Management Examples"
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

  # Example 1: List existing playlists
  puts "\n1. Listing existing playlists..."
  begin
    response = sdk.playlist.get_all_playlists(limit: 10)
    
    if response.status_code == 200
      puts "✅ Playlists retrieved successfully"
      puts "   Total playlists: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Recent playlists:"
        response.object.data.first(3).each_with_index do |playlist, index|
          puts "     #{index + 1}. ID: #{playlist.id}"
          puts "        Name: #{playlist.name}"
          puts "        Type: #{playlist.type}"
          puts "        Created: #{playlist.created_at || 'Unknown'}"
        end
      end
    else
      puts "⚠️  Playlists listing failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Playlists listing failed: #{e.message}"
  end

  # Example 2: Create a new playlist
  puts "\n2. Creating a new playlist..."
  begin
    create_request = FastpixApiSDK::Models::Components::CreatePlaylistRequest.new(
      name: "Sample Playlist #{Time.now.strftime('%Y%m%d_%H%M%S')}",
      reference_id: "sample-playlist-#{Time.now.to_i}",
      type: FastpixApiSDK::Models::Components::CreatePlaylistRequestType::MANUAL,
      description: "Sample playlist created via Ruby SDK",
      metadata: {
        'source' => 'ruby_sdk_sample',
        'created_at' => Time.now.iso8601
      }
    )

    response = sdk.playlist.create_a_playlist(request: create_request)
    
    if response.status_code == 201
      puts "✅ Playlist created successfully"
      playlist = response.object&.data
      puts "   Playlist ID: #{playlist&.id}"
      puts "   Name: #{playlist&.name}"
      puts "   Type: #{playlist&.type}"
      puts "   Reference ID: #{playlist&.reference_id}"
      
      # Store playlist ID for later operations
      @playlist_id = playlist&.id
    else
      puts "⚠️  Playlist creation failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Playlist creation failed: #{e.message}"
  end

  # Example 3: Get playlist details (if we created one)
  if @playlist_id
    puts "\n3. Getting playlist details..."
    begin
      response = sdk.playlist.get_playlist_by_id(playlist_id: @playlist_id)
      
      if response.status_code == 200
        puts "✅ Playlist details retrieved successfully"
        playlist = response.object&.data
        puts "   ID: #{playlist&.id}"
        puts "   Name: #{playlist&.name}"
        puts "   Type: #{playlist&.type}"
        puts "   Description: #{playlist&.description}"
        puts "   Media count: #{playlist&.media_list&.length || 0}"
        puts "   Created: #{playlist&.created_at}"
      else
        puts "⚠️  Playlist details retrieval failed with status: #{response.status_code}"
      end
    rescue => e
      puts "❌ Playlist details retrieval failed: #{e.message}"
    end
  end

  # Example 4: Add media to playlist (if we have a playlist and media)
  if @playlist_id
    puts "\n4. Adding media to playlist..."
    begin
      # First, try to get a media ID from the list
      media_response = sdk.manage_videos.list_media(limit: 1)
      
      if media_response.status_code == 200 && 
         media_response.object&.data&.any? &&
         media_response.object.data.first&.id
        
        media_id = media_response.object.data.first.id
        puts "   Using media ID: #{media_id}"
        
        request_body = FastpixApiSDK::Models::Operations::AddMediaToPlaylistRequestBody.new(
          media_id: media_id
        )

        response = sdk.playlist.add_media_to_playlist(
          playlist_id: @playlist_id,
          request_body: request_body
        )
        
        if response.status_code == 201
          puts "✅ Media added to playlist successfully"
          puts "   Media ID: #{media_id}"
          puts "   Playlist ID: #{@playlist_id}"
        else
          puts "⚠️  Media addition to playlist failed with status: #{response.status_code}"
        end
      else
        puts "ℹ️  No media available to add to playlist"
      end
    rescue => e
      puts "❌ Media addition to playlist failed: #{e.message}"
    end
  end

  # Example 5: Update playlist
  if @playlist_id
    puts "\n5. Updating playlist..."
    begin
      update_request = FastpixApiSDK::Models::Components::UpdatePlaylistRequest.new(
        name: "Updated Playlist #{Time.now.strftime('%Y%m%d_%H%M%S')}",
        description: "Updated playlist description",
        metadata: {
          'updated_at' => Time.now.iso8601,
          'updated_by' => 'ruby_sdk'
        }
      )

      response = sdk.playlist.update_a_playlist(
        playlist_id: @playlist_id,
        request: update_request
      )
      
      if response.status_code == 200
        puts "✅ Playlist updated successfully"
        playlist = response.object&.data
        puts "   Updated Name: #{playlist&.name}"
        puts "   Updated Description: #{playlist&.description}"
      else
        puts "⚠️  Playlist update failed with status: #{response.status_code}"
      end
    rescue => e
      puts "❌ Playlist update failed: #{e.message}"
    end
  end

  # Example 6: List playlist media
  if @playlist_id
    puts "\n6. Listing playlist media..."
    begin
      response = sdk.playlist.get_playlist_by_id(playlist_id: @playlist_id)
      
      if response.status_code == 200
        puts "✅ Playlist media retrieved successfully"
        playlist = response.object&.data
        media_list = playlist&.media_list || []
        puts "   Media count: #{media_list.length}"
        
        if media_list.any?
          puts "   Media in playlist:"
          media_list.first(5).each_with_index do |media, index|
            puts "     #{index + 1}. Media ID: #{media.id}"
            puts "        Title: #{media.title || 'Unknown'}"
            puts "        Duration: #{media.duration} seconds" if media.duration
          end
        end
      else
        puts "⚠️  Playlist media retrieval failed with status: #{response.status_code}"
      end
    rescue => e
      puts "❌ Playlist media retrieval failed: #{e.message}"
    end
  end

  # Example 7: Change media order in playlist
  if @playlist_id
    puts "\n7. Changing media order in playlist..."
    begin
      # First, get the current media list
      playlist_response = sdk.playlist.get_playlist_by_id(playlist_id: @playlist_id)
      
      if playlist_response.status_code == 200 && 
         playlist_response.object&.data&.media_list&.length && 
         playlist_response.object.data.media_list.length > 1
        
        media_list = playlist_response.object.data.media_list
        puts "   Current media order: #{media_list.map(&:id).join(', ')}"
        
        # Reverse the order as an example
        reversed_order = media_list.reverse.map(&:id)
        puts "   New media order: #{reversed_order.join(', ')}"
        
        request_body = FastpixApiSDK::Models::Operations::ChangeMediaOrderInPlaylistRequestBody.new(
          media_ids: reversed_order
        )

        response = sdk.playlist.change_media_order_in_playlist(
          playlist_id: @playlist_id,
          request_body: request_body
        )
        
        if response.status_code == 200
          puts "✅ Media order changed successfully"
        else
          puts "⚠️  Media order change failed with status: #{response.status_code}"
        end
      else
        puts "ℹ️  Not enough media in playlist to change order"
      end
    rescue => e
      puts "❌ Media order change failed: #{e.message}"
    end
  end

  puts "\n🎉 Playlist management examples completed!"
  puts "\nNext steps:"
  puts "- Check out media_management.rb for more media operations"
  puts "- Use playlists to organize and manage your video content"
  puts "- Integrate playlist functionality into your application"

rescue => e
  puts "❌ Example failed: #{e.message}"
  puts "\nTroubleshooting:"
  puts "1. Verify your credentials are correct"
  puts "2. Check your internet connection"
  puts "3. Ensure you have proper permissions for playlist operations"
  puts "4. Make sure you have media available to add to playlists"
end
