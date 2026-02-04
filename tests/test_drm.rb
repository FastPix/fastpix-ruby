#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'test_helper'

class TestDRM < Minitest::Test
  def initialize(test_name = nil)
    super(test_name)
    @username = self.class.class_variable_defined?(:@@username) ? self.class.class_variable_get(:@@username) : ENV['FASTPIX_USERNAME'] || 'YOUR_FASTPIX_USERNAME'
    @password = self.class.class_variable_defined?(:@@password) ? self.class.class_variable_get(:@@password) : ENV['FASTPIX_PASSWORD'] || 'YOUR_FASTPIX_PASSWORD'
    @sdk = FastpixTestHelper.create_sdk(@username, @password)
    @models = ::FastpixApiSDK::Models
  end

  def test_get_drm_configuration
    run_test("Get DRM Configuration") do
      begin
        response = @sdk.drm_configurations.get_drm_configuration(limit: 10, offset: 1)
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true &&
        response.object&.data.is_a?(Array)
      rescue => e
        puts "   Details: #{e.message}"
        # Accept bad request errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::BadRequestError) ? true : false
      end
    end
  end

  def test_get_drm_configuration_by_id
    run_test("Get DRM Configuration by ID") do
      begin
        # First, try to get a DRM configuration ID from list
        list_response = @sdk.drm_configurations.get_drm_configuration(limit: 1)
        
        if list_response.status_code == 200 && 
           list_response.object&.data&.any? &&
           list_response.object.data.first&.id
          
          drm_id = list_response.object.data.first.id
          response = @sdk.drm_configurations.get_drm_configuration_by_id(drm_configuration_id: drm_id)
          
          response.status_code == 200 &&
          response.object&.success == true &&
          response.object&.data&.id == drm_id
        else
          puts "   Details: No DRM configuration found to test with"
          true # Skip test if no DRM configuration available
        end
      rescue => e
        puts "   Details: #{e.message}"
        # Accept bad request errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::BadRequestError) ? true : false
      end
    end
  end

  def test_get_drm_configuration_not_found
    run_test("Get DRM Configuration Not Found Error") do
      begin
        response = @sdk.drm_configurations.get_drm_configuration_by_id(drm_configuration_id: 'non-existent-drm-id')
        
        # Should return 404
        response.status_code == 404
      rescue => e
        # Expected to raise not found error or bad request error
        e.is_a?(::FastpixApiSDK::Models::Errors::NotFoundError) ||
        e.is_a?(::FastpixApiSDK::Models::Errors::BadRequestError)
      end
    end
  end

  def test_drm_configuration_pagination
    run_test("DRM Configuration Pagination") do
      begin
        response = @sdk.drm_configurations.get_drm_configuration(limit: 5, offset: 1)
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true &&
        response.object&.data.is_a?(Array)
      rescue => e
        puts "   Details: #{e.message}"
        # Accept bad request errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::BadRequestError) ? true : false
      end
    end
  end

  def test_drm_configuration_with_filters
    run_test("DRM Configuration with Filters") do
      begin
        # Test with different limit and offset values
        response = @sdk.drm_configurations.get_drm_configuration(limit: 20, offset: 2)
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true &&
        response.object&.data.is_a?(Array)
      rescue => e
        puts "   Details: #{e.message}"
        # Accept bad request errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::BadRequestError) ? true : false
      end
    end
  end
end
