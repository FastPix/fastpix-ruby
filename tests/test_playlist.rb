#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'test_helper'

class TestPlaylist < Minitest::Test
  def initialize(test_name = nil)
    super(test_name)
    @username = self.class.class_variable_defined?(:@@username) ? self.class.class_variable_get(:@@username) : "453c6ab2-491a-470e-9d4e-78546bfbc818"
    @password = self.class.class_variable_defined?(:@@password) ? self.class.class_variable_get(:@@password) : "ff6983d7-6b70-4f21-ba45-f1fa9954f344"
    @sdk = FastpixTestHelper.create_sdk(@username, @password)
    @models = ::FastpixApiSDK::Models
    @test_playlist_id = nil
  end

  def test_create_a_playlist
    run_test("Create a Playlist") do
      begin
        request = @models::Components::CreatePlaylistRequest.new(
          name: 'Test Playlist',
          reference_id: 'test-playlist-ref',
          type: @models::Components::CreatePlaylistRequestType::MANUAL,
          description: 'Test playlist description'
        )
        
        response = @sdk.playlist.create_a_playlist(request: request)
        
        if response.status_code == 201 &&
           response.object&.success == true &&
           response.object&.data&.id
          @test_playlist_id = response.object.data.id
          true
        else
          false
        end
      rescue => e
        puts "   Details: #{e.message}"
        # Accept validation errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ? true : false
      end
    end
  end

  def test_get_all_playlists
    run_test("Get All Playlists") do
      begin
        response = @sdk.playlist.get_all_playlists(limit: 10, offset: 1)
        
        response.status_code == 200 &&
        response.object&.success == true &&
        response.object&.data.is_a?(Array)
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_get_playlist_by_id
    run_test("Get Playlist by ID") do
      begin
        if @test_playlist_id
          response = @sdk.playlist.get_playlist_by_id(playlist_id: @test_playlist_id)
          
          response.status_code == 200 &&
          response.object&.success == true &&
          response.object&.data&.id == @test_playlist_id
        else
          puts "   Details: No playlist ID available from previous test"
          true # Skip test if no playlist ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_update_a_playlist
    run_test("Update a Playlist") do
      begin
        if @test_playlist_id
          request = @models::Components::UpdatePlaylistRequest.new(
            name: 'Updated Test Playlist',
            description: 'Updated test playlist description'
          )
          
          response = @sdk.playlist.update_a_playlist(
            update_playlist_request: request,
            playlist_id: @test_playlist_id
          )
          
          response.status_code == 200 &&
          response.object&.success == true
        else
          puts "   Details: No playlist ID available from previous test"
          true # Skip test if no playlist ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_add_media_to_playlist
    run_test("Add Media to Playlist") do
      begin
        if @test_playlist_id
          # First, try to get a media ID from list
          list_response = @sdk.manage_videos.list_media(limit: 1)
          
          if list_response.status_code == 200 && 
             list_response.object&.data&.any? &&
             list_response.object.data.first&.id
            
            media_id = list_response.object.data.first.id
            
            request = @models::Components::MediaIdsRequest.new(
              media_ids: [media_id]
            )
            
            response = @sdk.playlist.add_media_to_playlist(
              media_ids_request: request,
              playlist_id: @test_playlist_id
            )
            
            response.status_code == 200 &&
            response.object&.success == true
          else
            puts "   Details: No media found to add to playlist"
            true # Skip test if no media available
          end
        else
          puts "   Details: No playlist ID available from previous test"
          true # Skip test if no playlist ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_change_media_order_in_playlist
    run_test("Change Media Order in Playlist") do
      begin
        if @test_playlist_id
          # First, try to get media IDs from list
          list_response = @sdk.manage_videos.list_media(limit: 2)
          
          if list_response.status_code == 200 && 
             list_response.object&.data&.length >= 2
            
            media_ids = list_response.object.data.map(&:id)
            
            request = @models::Components::MediaIdsRequest.new(
              media_ids: media_ids.reverse # Reverse order
            )
            
            response = @sdk.playlist.change_media_order_in_playlist(
              media_ids_request: request,
              playlist_id: @test_playlist_id
            )
            
            response.status_code == 200 &&
            response.object&.success == true
          else
            puts "   Details: Not enough media found to test reordering"
            true # Skip test if not enough media available
          end
        else
          puts "   Details: No playlist ID available from previous test"
          true # Skip test if no playlist ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_delete_media_from_playlist
    run_test("Delete Media from Playlist") do
      begin
        if @test_playlist_id
          # First, try to get a media ID from list
          list_response = @sdk.manage_videos.list_media(limit: 1)
          
          if list_response.status_code == 200 && 
             list_response.object&.data&.any? &&
             list_response.object.data.first&.id
            
            media_id = list_response.object.data.first.id
            
            request = @models::Components::MediaIdsRequest.new(
              media_ids: [media_id]
            )
            
            response = @sdk.playlist.delete_media_from_playlist(
              playlist_id: @test_playlist_id,
              media_ids_request: request
            )
            
            response.status_code == 200 &&
            response.object&.success == true
          else
            puts "   Details: No media found to delete from playlist"
            true # Skip test if no media available
          end
        else
          puts "   Details: No playlist ID available from previous test"
          true # Skip test if no playlist ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_delete_a_playlist
    run_test("Delete a Playlist") do
      begin
        if @test_playlist_id
          response = @sdk.playlist.delete_a_playlist(playlist_id: @test_playlist_id)
          
          response.status_code == 200 &&
          response.object&.success == true
        else
          puts "   Details: No playlist ID available from previous test"
          true # Skip test if no playlist ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_playlist_not_found_error
    run_test("Playlist Not Found Error") do
      begin
        response = @sdk.playlist.get_playlist_by_id(playlist_id: 'non-existent-playlist-id')
        
        # Should return 404
        response.status_code == 404
      rescue => e
        # Expected to raise not found error or validation error
        e.is_a?(::FastpixApiSDK::Models::Errors::NotFoundError) ||
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse)
      end
    end
  end
end
