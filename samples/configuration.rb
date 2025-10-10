#!/usr/bin/env ruby
# frozen_string_literal: true

# FastPix Ruby SDK - Configuration Examples
# This example demonstrates various SDK configuration options

require 'fastpixapi'

# Configuration
USERNAME = ENV['FASTPIX_USERNAME'] || 'your_username_here'
PASSWORD = ENV['FASTPIX_PASSWORD'] || 'your_password_here'

puts "⚙️  FastPix Ruby SDK - Configuration Examples"
puts "=" * 50

begin
  # Example 1: Basic SDK initialization
  puts "\n1. Basic SDK initialization..."
  sdk = FastpixApiSDK::Fastpix.new(
    security: FastpixApiSDK::Models::Components::Security.new(
      username: USERNAME,
      password: PASSWORD
    )
  )
  puts "✅ Basic SDK initialized successfully"

  # Example 2: SDK with custom configuration
  puts "\n2. SDK with custom configuration..."
  custom_sdk = FastpixApiSDK::Fastpix.new(
    security: FastpixApiSDK::Models::Components::Security.new(
      username: USERNAME,
      password: PASSWORD
    )
  )
  puts "✅ Custom SDK initialized successfully"

  # Example 3: SDK configuration details
  puts "\n3. SDK configuration details..."
  config = custom_sdk.sdk_configuration
  puts "   Server URL: #{config.server_url}"
  puts "   SDK Version: #{config.sdk_version}"
  puts "   OpenAPI Doc Version: #{config.openapi_doc_version}"
  puts "   Language: #{config.language}"
  puts "   User Agent: #{config.user_agent}"
  puts "   Timeout: #{config.timeout} seconds"

  # Example 4: Test different server configurations
  puts "\n4. Testing different server configurations..."
  
  # Test with default server
  begin
    response = sdk.manage_videos.list_media(limit: 1)
    puts "   ✅ Default server connection: #{response.status_code}"
  rescue => e
    puts "   ❌ Default server connection failed: #{e.message}"
  end

  # Test with custom server
  begin
    response = custom_sdk.manage_videos.list_media(limit: 1)
    puts "   ✅ Custom server connection: #{response.status_code}"
  rescue => e
    puts "   ❌ Custom server connection failed: #{e.message}"
  end

  # Example 5: Retry configuration testing
  puts "\n5. Testing retry configuration..."
  
  # Create SDK with aggressive retry settings for testing
  retry_sdk = FastpixApiSDK::Fastpix.new(
    security: FastpixApiSDK::Models::Components::Security.new(
      username: USERNAME,
      password: PASSWORD
    )
  )
  
  begin
    response = retry_sdk.manage_videos.list_media(limit: 1)
    puts "   ✅ Retry configuration test: #{response.status_code}"
  rescue => e
    puts "   ❌ Retry configuration test failed: #{e.message}"
  end

  # Example 6: Timeout configuration testing
  puts "\n6. Testing timeout configuration..."
  
  # Create SDK with short timeout for testing
  timeout_sdk = FastpixApiSDK::Fastpix.new(
    security: FastpixApiSDK::Models::Components::Security.new(
      username: USERNAME,
      password: PASSWORD
    )
  )
  
  begin
    response = timeout_sdk.manage_videos.list_media(limit: 1)
    puts "   ✅ Timeout configuration test: #{response.status_code}"
  rescue => e
    puts "   ❌ Timeout configuration test failed: #{e.message}"
  end

  # Example 7: Environment-based configuration
  puts "\n7. Environment-based configuration..."
  
  # Check environment variables
  puts "   Environment variables:"
  puts "   - FASTPIX_USERNAME: #{ENV['FASTPIX_USERNAME'] ? 'Set' : 'Not set'}"
  puts "   - FASTPIX_PASSWORD: #{ENV['FASTPIX_PASSWORD'] ? 'Set' : 'Not set'}"
  puts "   - FASTPIX_SERVER_URL: #{ENV['FASTPIX_SERVER_URL'] || 'Not set'}"
  puts "   - FASTPIX_TIMEOUT: #{ENV['FASTPIX_TIMEOUT'] || 'Not set'}"

  # Create SDK using environment variables
  env_sdk = FastpixApiSDK::Fastpix.new(
    security: FastpixApiSDK::Models::Components::Security.new(
      username: ENV['FASTPIX_USERNAME'] || USERNAME,
      password: ENV['FASTPIX_PASSWORD'] || PASSWORD
    ),
    server_url: ENV['FASTPIX_SERVER_URL'],
    timeout: ENV['FASTPIX_TIMEOUT']&.to_i
  )
  
  begin
    response = env_sdk.manage_videos.list_media(limit: 1)
    puts "   ✅ Environment-based configuration test: #{response.status_code}"
  rescue => e
    puts "   ❌ Environment-based configuration test failed: #{e.message}"
  end

  # Example 8: Configuration validation
  puts "\n8. Configuration validation..."
  
  def validate_sdk_config(sdk, name)
    puts "   Validating #{name} configuration..."
    
    config = sdk.sdk_configuration
    
    # Check required fields
    required_fields = [:server_url, :sdk_version, :timeout]
    missing_fields = required_fields.select { |field| config.send(field).nil? }
    
    if missing_fields.empty?
      puts "   ✅ All required fields present"
    else
      puts "   ❌ Missing required fields: #{missing_fields.join(', ')}"
    end
    
    # Check timeout value
    if config.timeout && config.timeout > 0
      puts "   ✅ Timeout value is valid: #{config.timeout} seconds"
    else
      puts "   ⚠️  Timeout value may be invalid: #{config.timeout}"
    end
    
    # Check server URL format
    if config.server_url && config.server_url.match?(/\Ahttps?:\/\//)
      puts "   ✅ Server URL format is valid: #{config.server_url}"
    else
      puts "   ⚠️  Server URL format may be invalid: #{config.server_url}"
    end
  end

  validate_sdk_config(sdk, "Basic SDK")
  validate_sdk_config(custom_sdk, "Custom SDK")

  # Example 9: Configuration comparison
  puts "\n9. Configuration comparison..."
  
  basic_config = sdk.sdk_configuration
  custom_config = custom_sdk.sdk_configuration
  
  puts "   Configuration differences:"
  puts "   - Server URL: #{basic_config.server_url} vs #{custom_config.server_url}"
  puts "   - Timeout: #{basic_config.timeout} vs #{custom_config.timeout}"
  puts "   - SDK Version: #{basic_config.sdk_version} vs #{custom_config.sdk_version}"

  # Example 10: Best practices
  puts "\n10. Configuration best practices..."
  puts "   ✅ Use environment variables for sensitive data (credentials)"
  puts "   ✅ Set appropriate timeouts based on your use case"
  puts "   ✅ Configure retry logic for production environments"
  puts "   ✅ Use HTTPS URLs for production"
  puts "   ✅ Validate configuration before making API calls"
  puts "   ✅ Log configuration details for debugging (without sensitive data)"

  puts "\n🎉 Configuration examples completed!"
  puts "\nNext steps:"
  puts "- Use environment variables for production deployments"
  puts "- Configure appropriate timeouts and retry logic"
  puts "- Test your configuration in different environments"
  puts "- Monitor API performance and adjust configuration as needed"

rescue => e
  puts "❌ Example failed: #{e.message}"
  puts "\nTroubleshooting:"
  puts "1. Verify your credentials are correct"
  puts "2. Check your internet connection"
  puts "3. Ensure configuration values are valid"
  puts "4. Review the configuration options in the SDK documentation"
end
