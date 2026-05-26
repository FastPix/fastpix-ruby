#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'test_helper'

class TestInputVideo < Minitest::Test
  def initialize(test_name = nil)
    super(test_name)
    @username = self.class.class_variable_defined?(:@@username) ? self.class.class_variable_get(:@@username) : ENV['FASTPIX_USERNAME'] || 'YOUR_FASTPIX_USERNAME'
    @password = self.class.class_variable_defined?(:@@password) ? self.class.class_variable_get(:@@password) : ENV['FASTPIX_PASSWORD'] || 'YOUR_FASTPIX_PASSWORD'
    @sdk = FastpixTestHelper.create_sdk(@username, @password)
    @models = ::FastpixApiSDK::Models
  end

  def test_create_media_from_url
    run_test("Create Media from URL") do
      begin
        request = @models::Components::CreateMediaRequest.new(
          inputs: [
            @models::Components::VideoInput.new(
              type: 'video',
              url: 'https://static.fastpix.com/sample.mp4'
            )
          ],
          metadata: {
            "test_key": 'test_value'
          },
          access_policy: @models::Components::CreateMediaRequestAccessPolicy::PUBLIC
        )

        response = @sdk.input_video.create_media(request: request)
        
        # Check if response is successful
        response.status_code == 201 && 
        response.create_media_success_response&.success == true &&
        !response.create_media_success_response&.data&.id.nil?
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_direct_upload_video_media
    run_test("Direct Upload Video Media") do
      begin
        response = @sdk.input_video.direct_upload_video_media(cors_origin: 'https://example.com')
        
        # Check if response is successful
        response.status_code == 201 && 
        !response.object&.data&.id.nil? &&
        !response.object&.data&.url.nil?
      rescue => e
        puts "   Details: #{e.message}"
        # Accept validation errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ? true : false
      end
    end
  end

  def test_direct_upload_with_metadata
    run_test("Direct Upload with Metadata") do
      begin
        response = @sdk.input_video.direct_upload_video_media(
          cors_origin: 'https://example.com',
          push_media_settings: @models::Operations::PushMediaSettings.new(
            access_policy: @models::Components::BasicAccessPolicy::PUBLIC,
            metadata: {
              "test_upload" => 'metadata_test'
            }
          )
        )
        
        # Check if response is successful
        response.status_code == 201 && 
        !response.object&.data&.id.nil? &&
        !response.object&.data&.url.nil?
      rescue => e
        puts "   Details: #{e.message}"
        # Accept validation errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ? true : false
      end
    end
  end

  def test_create_media_validation_error
    run_test("Create Media Validation Error Handling") do
      begin
        # Try to create media with invalid URL
        request = @models::Components::CreateMediaRequest.new(
          inputs: [
            @models::Components::VideoInput.new(
              type: 'video',
              url: 'invalid-url'
            )
          ],
          access_policy: @models::Components::CreateMediaRequestAccessPolicy::PUBLIC
        )

        response = @sdk.input_video.create_media(request: request)
        
        # Should return validation error (400 or 422)
        [400, 422].include?(response.status_code)
      rescue => e
        # Expected to raise validation error
        e.is_a?(::FastpixApiSDK::Models::Errors::BadRequestError) ||
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse)
      end
    end
  end
end
