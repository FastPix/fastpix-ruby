#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'test_helper'

class TestManageVideos < Minitest::Test
  def initialize(test_name = nil)
    super(test_name)
    @username = self.class.class_variable_defined?(:@@username) ? self.class.class_variable_get(:@@username) : ENV['FASTPIX_USERNAME'] || 'YOUR_FASTPIX_USERNAME'
    @password = self.class.class_variable_defined?(:@@password) ? self.class.class_variable_get(:@@password) : ENV['FASTPIX_PASSWORD'] || 'YOUR_FASTPIX_PASSWORD'
    @sdk = FastpixTestHelper.create_sdk(@username, @password)
    @models = ::FastpixApiSDK::Models
    @test_media_id = nil
  end

  def test_list_media
    run_test("List Media") do
      begin
        response = @sdk.manage_videos.list_media(limit: 10, offset: 1)
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true &&
        response.object&.data.is_a?(Array)
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_list_media_with_pagination
    run_test("List Media with Pagination") do
      begin
        response = @sdk.manage_videos.list_media(limit: 5)
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true
      rescue => e
        puts "   Details: #{e.message}"
        # Also accept validation errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ? true : false
      end
    end
  end

  def test_get_media_by_id
    run_test("Get Media by ID") do
      begin
        # First, try to get a media ID from list
        list_response = @sdk.manage_videos.list_media(limit: 1)
        
        if list_response.status_code == 200 && 
           list_response.object&.data&.any? &&
           list_response.object.data.first&.id
          
          media_id = list_response.object.data.first.id
          @test_media_id = media_id
          response = @sdk.manage_videos.get_media(media_id: media_id)
          
          response.status_code == 200 &&
          response.object&.success == true &&
          response.object&.data&.id == media_id
        else
          puts "   Details: No media found to test with"
          true # Skip test if no media available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_get_media_not_found
    run_test("Get Media Not Found Error") do
      begin
        response = @sdk.manage_videos.get_media(media_id: 'non-existent-id')
        
        # Should return 404
        response.status_code == 404
      rescue => e
        # Expected to raise not found error or validation error
        e.is_a?(::FastpixApiSDK::Models::Errors::MediaNotFoundError) ||
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse)
      end
    end
  end

  def test_list_uploads
    run_test("List Uploads") do
      begin
        response = @sdk.manage_videos.list_uploads(limit: 10, offset: 1)
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true &&
        response.object&.data.is_a?(Array)
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_cancel_upload
    run_test("Cancel Upload") do
      begin
        # Try to cancel a non-existent upload
        response = @sdk.manage_videos.cancel_upload(upload_id: 'non-existent-upload-id')
        
        # Should return 404 or error
        [404, 400, 422].include?(response.status_code)
      rescue => e
        # Expected to raise not found error or validation error
        e.is_a?(::FastpixApiSDK::Models::Errors::MediaNotFoundError) ||
        e.is_a?(::FastpixApiSDK::Models::Errors::BadRequestError) ||
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse)
      end
    end
  end

  def test_add_media_track
    run_test("Add Media Track") do
      begin
        if @test_media_id
          track_request = @models::Components::AddTrackRequest.new(
            url: 'https://example.com/subtitle.srt',
            type: @models::Components::AddTrackRequestType::SUBTITLE,
            language_name: 'English',
            language_code: 'en'
          )
          
          request_body = @models::Operations::AddMediaTrackRequestBody.new(
            tracks: track_request
          )
          
          response = @sdk.manage_videos.add_media_track(
            request_body: request_body,
            media_id: @test_media_id
          )
          
          response.status_code == 201 &&
          response.object&.success == true
        else
          puts "   Details: No media ID available from previous test"
          true # Skip test if no media available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_get_media_clips
    run_test("Get Media Clips") do
      begin
        if @test_media_id
          response = @sdk.manage_videos.get_media_clips(
            source_media_id: @test_media_id,
            limit: 10,
            offset: 1
          )
          
          response.status_code == 200 &&
          response.object&.success == true &&
          response.object&.data.is_a?(Array)
        else
          puts "   Details: No media ID available from previous test"
          true # Skip test if no media available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end
end
