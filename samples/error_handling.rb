#!/usr/bin/env ruby
# frozen_string_literal: true

# FastPix Ruby SDK - Error Handling Examples
# This example demonstrates comprehensive error handling patterns

require 'fastpixapi'

# Configuration
USERNAME = ENV['FASTPIX_USERNAME'] || 'your_username_here'
PASSWORD = ENV['FASTPIX_PASSWORD'] || 'your_password_here'

puts "⚠️  FastPix Ruby SDK - Error Handling Examples"
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

  # Example 1: Handle authentication errors
  puts "\n1. Testing authentication error handling..."
  begin
    # Try with invalid credentials
    invalid_sdk = FastpixApiSDK::Fastpix.new(
      security: FastpixApiSDK::Models::Components::Security.new(
        username: 'invalid_username',
        password: 'invalid_password'
      )
    )
    
    response = invalid_sdk.manage_videos.list_media(limit: 1)
    puts "⚠️  Expected authentication error but got status: #{response.status_code}"
  rescue FastpixApiSDK::Models::Errors::UnauthorizedError => e
    puts "✅ Caught UnauthorizedError as expected"
    puts "   Error: #{e.message}"
  rescue FastpixApiSDK::Models::Errors::UnauthorizedResponseError => e
    puts "✅ Caught UnauthorizedResponseError as expected"
    puts "   Error: #{e.message}"
  rescue => e
    puts "ℹ️  Caught other error: #{e.class.name} - #{e.message}"
  end

  # Example 2: Handle validation errors
  puts "\n2. Testing validation error handling..."
  begin
    # Try to create media with invalid data
    invalid_request = FastpixApiSDK::Models::Components::CreateMediaRequest.new(
      inputs: [], # Empty inputs should cause validation error
      access_policy: FastpixApiSDK::Models::Components::CreateMediaRequestAccessPolicy::PUBLIC
    )

    response = sdk.input_video.create_media(request: invalid_request)
    
    if response.status_code == 400
      puts "✅ Validation error caught as expected"
      puts "   Status: #{response.status_code}"
    else
      puts "⚠️  Expected validation error but got status: #{response.status_code}"
    end
  rescue FastpixApiSDK::Models::Errors::ValidationErrorResponse => e
    puts "✅ Caught ValidationErrorResponse as expected"
    puts "   Error: #{e.message}"
  rescue => e
    puts "ℹ️  Caught other error: #{e.class.name} - #{e.message}"
  end

  # Example 3: Handle not found errors
  puts "\n3. Testing not found error handling..."
  begin
    # Try to get a non-existent media
    response = sdk.manage_videos.get_media(media_id: 'non-existent-id')
    
    if response.status_code == 404
      puts "✅ Not found error caught as expected"
      puts "   Status: #{response.status_code}"
    else
      puts "⚠️  Expected not found error but got status: #{response.status_code}"
    end
  rescue FastpixApiSDK::Models::Errors::NotFoundError => e
    puts "✅ Caught NotFoundError as expected"
    puts "   Error: #{e.message}"
  rescue FastpixApiSDK::Models::Errors::MediaNotFoundError => e
    puts "✅ Caught MediaNotFoundError as expected"
    puts "   Error: #{e.message}"
  rescue => e
    puts "ℹ️  Caught other error: #{e.class.name} - #{e.message}"
  end

  # Example 4: Handle bad request errors
  puts "\n4. Testing bad request error handling..."
  begin
    # Try to get DRM configuration with invalid parameters
    response = sdk.drm_configurations.get_drm_configuration(limit: -1) # Invalid limit
    
    if response.status_code == 400
      puts "✅ Bad request error caught as expected"
      puts "   Status: #{response.status_code}"
    else
      puts "⚠️  Expected bad request error but got status: #{response.status_code}"
    end
  rescue FastpixApiSDK::Models::Errors::BadRequestError => e
    puts "✅ Caught BadRequestError as expected"
    puts "   Error: #{e.message}"
  rescue => e
    puts "ℹ️  Caught other error: #{e.class.name} - #{e.message}"
  end

  # Example 5: Handle forbidden errors
  puts "\n5. Testing forbidden error handling..."
  begin
    # Try to access a resource that might be forbidden
    response = sdk.signing_keys.get_signing_key_by_id(signing_key_id: 'forbidden-key-id')
    
    if response.status_code == 403
      puts "✅ Forbidden error caught as expected"
      puts "   Status: #{response.status_code}"
    else
      puts "⚠️  Expected forbidden error but got status: #{response.status_code}"
    end
  rescue FastpixApiSDK::Models::Errors::ForbiddenError => e
    puts "✅ Caught ForbiddenError as expected"
    puts "   Error: #{e.message}"
  rescue => e
    puts "ℹ️  Caught other error: #{e.class.name} - #{e.message}"
  end

  # Example 6: Comprehensive error handling wrapper
  puts "\n6. Testing comprehensive error handling wrapper..."
  
  def safe_api_call(description, &_block)
    puts "   #{description}..."
    begin
      result = yield
      if result.respond_to?(:status_code) && result.status_code >= 200 && result.status_code < 300
        puts "   ✅ Success: #{result.status_code}"
        return result
      else
        puts "   ⚠️  API returned status: #{result.status_code}"
        return result
      end
    rescue FastpixApiSDK::Models::Errors::ValidationErrorResponse => e
      puts "   ❌ Validation Error: #{e.message}"
      return nil
    rescue FastpixApiSDK::Models::Errors::BadRequestError => e
      puts "   ❌ Bad Request Error: #{e.message}"
      return nil
    rescue FastpixApiSDK::Models::Errors::NotFoundError => e
      puts "   ❌ Not Found Error: #{e.message}"
      return nil
    rescue FastpixApiSDK::Models::Errors::UnauthorizedError => e
      puts "   ❌ Unauthorized Error: #{e.message}"
      return nil
    rescue FastpixApiSDK::Models::Errors::ForbiddenError => e
      puts "   ❌ Forbidden Error: #{e.message}"
      return nil
    rescue => e
      puts "   ❌ Unexpected Error: #{e.class.name} - #{e.message}"
      return nil
    end
  end

  # Test the wrapper with various operations
  safe_api_call("Listing media") do
    sdk.manage_videos.list_media(limit: 5)
  end

  safe_api_call("Getting non-existent media") do
    sdk.manage_videos.get_media(media_id: 'definitely-does-not-exist')
  end

  safe_api_call("Creating invalid media request") do
    invalid_request = FastpixApiSDK::Models::Components::CreateMediaRequest.new(
      inputs: [],
      access_policy: FastpixApiSDK::Models::Components::CreateMediaRequestAccessPolicy::PUBLIC
    )
    sdk.input_video.create_media(request: invalid_request)
  end

  # Example 7: Retry logic for transient errors
  puts "\n7. Testing retry logic for transient errors..."
  
  def api_call_with_retry(description, max_retries: 3, &_block)
    puts "   #{description} (with retry logic)..."
    
    retries = 0
    loop do
      begin
        result = yield
        if result.respond_to?(:status_code) && result.status_code >= 200 && result.status_code < 300
          puts "   ✅ Success on attempt #{retries + 1}: #{result.status_code}"
          return result
        elsif result.respond_to?(:status_code) && result.status_code >= 500 && retries < max_retries
          retries += 1
          puts "   ⚠️  Server error on attempt #{retries}, retrying in #{retries * 2} seconds..."
          sleep(retries * 2)
          next
        else
          puts "   ❌ Failed after #{retries + 1} attempts: #{result.status_code}"
          return result
        end
      rescue => e
        if retries < max_retries
          retries += 1
          puts "   ⚠️  Exception on attempt #{retries}, retrying in #{retries * 2} seconds: #{e.message}"
          sleep(retries * 2)
          next
        else
          puts "   ❌ Failed after #{retries + 1} attempts: #{e.class.name} - #{e.message}"
          return nil
        end
      end
    end
  end

  # Test retry logic
  api_call_with_retry("Listing live streams") do
    sdk.manage_live_stream.get_all_streams(limit: 5)
  end

  puts "\n🎉 Error handling examples completed!"
  puts "\nKey takeaways:"
  puts "- Always handle specific error types for better user experience"
  puts "- Implement retry logic for transient errors"
  puts "- Use comprehensive error handling wrappers"
  puts "- Log errors appropriately for debugging"
  puts "- Provide meaningful error messages to users"

rescue => e
  puts "❌ Example failed: #{e.message}"
  puts "\nTroubleshooting:"
  puts "1. Verify your credentials are correct"
  puts "2. Check your internet connection"
  puts "3. Review the error handling patterns in this example"
end
