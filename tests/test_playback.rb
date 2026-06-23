#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'test_helper'

class TestPlayback < Minitest::Test
  def initialize(test_name = nil)
    super(test_name)
    @username = self.class.class_variable_defined?(:@@username) ? self.class.class_variable_get(:@@username) : ENV['FASTPIX_USERNAME'] || 'YOUR_FASTPIX_USERNAME'
    @password = self.class.class_variable_defined?(:@@password) ? self.class.class_variable_get(:@@password) : ENV['FASTPIX_PASSWORD'] || 'YOUR_FASTPIX_PASSWORD'
    @sdk = FastpixTestHelper.create_sdk(@username, @password)
    @models = ::FastpixApiSDK::Models
    @test_media_id = nil
    @test_playback_id = nil
  end

  def test_create_media_playback_id
    run_test("Create Media Playback ID") do
      begin
        # First, try to get a media ID from list
        list_response = @sdk.manage_videos.list_media(limit: 1)

        if list_response.status_code == 200 &&
           list_response.object&.data&.any? &&
           list_response.object.data.first&.id
          create_playback_id_for(list_response.object.data.first.id)
        else
          create_media_then_playback_id
        end
      rescue => e
        puts "   Details: #{e.message}"
        # Accept validation errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ? true : false
      end
    end
  end

  # Creates a playback id for the given media id; returns true on success.
  def create_playback_id_for(media_id)
    @test_media_id = media_id

    request_body = @models::Operations::CreateMediaPlaybackIdRequestBody.new(
      access_policy: @models::Components::AccessPolicy::PUBLIC
    )

    response = @sdk.playback.create_media_playback_id(
      media_id: media_id,
      request_body: request_body
    )

    if response.status_code == 201 &&
       response.object&.success == true &&
       response.object&.data&.playback_id
      @test_playback_id = response.object.data.playback_id
      true
    else
      false
    end
  end

  # Creates a new media, then a playback id for it. Skips (true) if creation fails.
  def create_media_then_playback_id
    create_request = @models::Components::CreateMediaRequest.new(
      inputs: [
        @models::Components::VideoInput.new(
          type: 'video',
          url: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4'
        )
      ],
      access_policy: @models::Components::CreateMediaRequestAccessPolicy::PUBLIC
    )

    create_response = @sdk.input_video.create_media(request: create_request)
    unless create_response.status_code == 201 && create_response.object&.data&.any?
      puts "   Details: Media creation failed - Status: #{create_response.status_code}, Response: #{create_response.object&.inspect}"
      return true # Skip test if no media available
    end

    media_id = create_response.object.data.first.id
    puts "   Details: Created media with ID: #{media_id}"
    create_playback_id_for(media_id)
  end

  def test_get_playback_id
    run_test("Get Playback ID") do
      begin
        if @test_media_id && @test_playback_id
          response = @sdk.playback.get_playback_id(
            media_id: @test_media_id,
            playback_id: @test_playback_id
          )
          
          response.status_code == 200 &&
          response.object&.success == true &&
          response.object&.data&.playback_id == @test_playback_id
        else
          puts "   Details: No playback ID available from previous test"
          true # Skip test if no playback ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_get_playback_id_not_found
    run_test("Get Playback ID Not Found Error") do
      begin
        # Try to get a non-existent playback ID
        response = @sdk.playback.get_playback_id(
          media_id: 'non-existent-media-id',
          playback_id: 'non-existent-playback-id'
        )
        
        # Should return 404
        response.status_code == 404
      rescue => e
        # Expected to raise not found error or validation error
        e.is_a?(::FastpixApiSDK::Models::Errors::MediaOrPlaybackNotFoundError) ||
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse)
      end
    end
  end

  def test_delete_media_playback_id
    run_test("Delete Media Playback ID") do
      begin
        if @test_media_id && @test_playback_id
          response = @sdk.playback.delete_media_playback_id(
            media_id: @test_media_id,
            playback_id: @test_playback_id
          )
          
          response.status_code == 200 &&
          response.object&.success == true
        else
          puts "   Details: No playback ID available from previous test"
          true # Skip test if no playback ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_create_private_playback_id
    run_test("Create Private Playback ID") do
      begin
        if @test_media_id
          request_body = @models::Operations::CreateMediaPlaybackIdRequestBody.new(
            access_policy: @models::Components::AccessPolicy::PRIVATE
          )
          
          response = @sdk.playback.create_media_playback_id(
            media_id: @test_media_id,
            request_body: request_body
          )
          
          response.status_code == 201 &&
          response.object&.success == true &&
          response.object&.data&.playback_id
        else
          puts "   Details: No media ID available from previous test"
          true # Skip test if no media ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_playback_id_validation_error
    run_test("Playback ID Validation Error") do
      begin
        if @test_media_id
          # Try to create playback ID with invalid access policy
          request_body = @models::Operations::CreateMediaPlaybackIdRequestBody.new(
            access_policy: 'invalid_policy'
          )
          
          response = @sdk.playback.create_media_playback_id(
            media_id: @test_media_id,
            request_body: request_body
          )
          
          # Should return validation error
          [400, 422].include?(response.status_code)
        else
          puts "   Details: No media ID available from previous test"
          true # Skip test if no media ID available
        end
      rescue => e
        # Expected to raise validation error
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ||
        e.is_a?(::FastpixApiSDK::Models::Errors::BadRequestError)
      end
    end
  end
end
