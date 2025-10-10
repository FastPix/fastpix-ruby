#!/usr/bin/env ruby
# frozen_string_literal: true

# FastPix Ruby SDK - DRM Configuration Examples
# This example demonstrates DRM (Digital Rights Management) configuration

require 'fastpixapi'

# Configuration
USERNAME = ENV['FASTPIX_USERNAME'] || 'your_username_here'
PASSWORD = ENV['FASTPIX_PASSWORD'] || 'your_password_here'

puts "🔒 FastPix Ruby SDK - DRM Configuration Examples"
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

  # Example 1: List DRM configurations
  puts "\n1. Listing DRM configurations..."
  begin
    response = sdk.drm_configurations.get_drm_configuration(limit: 10)
    
    if response.status_code == 200
      puts "✅ DRM configurations retrieved successfully"
      puts "   Total configurations: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Recent DRM configurations:"
        response.object.data.first(3).each_with_index do |config, index|
          puts "     #{index + 1}. ID: #{config.id}"
          puts "        Name: #{config.name}"
          puts "        Type: #{config.type}"
          puts "        Created: #{config.created_at || 'Unknown'}"
        end
      else
        puts "   ℹ️  No DRM configurations found"
        puts "   This is normal for new accounts or test environments"
      end
    else
      puts "⚠️  DRM configurations listing failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ DRM configurations listing failed: #{e.message}"
  end

  # Example 2: Get DRM configuration by ID (if we have one)
  puts "\n2. Getting DRM configuration by ID..."
  begin
    # First, try to get a DRM configuration ID from the list
    list_response = sdk.drm_configurations.get_drm_configuration(limit: 1)
    
    if list_response.status_code == 200 && 
       list_response.object&.data&.any? &&
       list_response.object.data.first&.id
      
      config_id = list_response.object.data.first.id
      puts "   Using DRM configuration ID: #{config_id}"
      
      response = sdk.drm_configurations.get_drm_configuration_by_id(
        drm_configuration_id: config_id
      )
      
      if response.status_code == 200
        puts "✅ DRM configuration details retrieved successfully"
        config = response.object&.data
        puts "   ID: #{config&.id}"
        puts "   Name: #{config&.name}"
        puts "   Type: #{config&.type}"
        puts "   Status: #{config&.status}"
        puts "   Created: #{config&.created_at}"
      else
        puts "⚠️  DRM configuration details retrieval failed with status: #{response.status_code}"
      end
    else
      puts "ℹ️  No DRM configurations available to retrieve details for"
    end
  rescue => e
    puts "❌ DRM configuration details retrieval failed: #{e.message}"
  end

  # Example 3: List DRM configurations with pagination
  puts "\n3. Listing DRM configurations with pagination..."
  begin
    response = sdk.drm_configurations.get_drm_configuration(
      limit: 5,
      offset: 0
    )
    
    if response.status_code == 200
      puts "✅ Paginated DRM configurations retrieved successfully"
      puts "   Configurations count: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   DRM configurations:"
        response.object.data.each_with_index do |config, index|
          puts "     #{index + 1}. ID: #{config.id}"
          puts "        Name: #{config.name}"
          puts "        Type: #{config.type}"
          puts "        Created: #{config.created_at || 'Unknown'}"
        end
      end
    else
      puts "⚠️  Paginated DRM configurations retrieval failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Paginated DRM configurations retrieval failed: #{e.message}"
  end

  # Example 4: List DRM configurations with filters
  puts "\n4. Listing DRM configurations with filters..."
  begin
    # Try to filter by type (if supported)
    response = sdk.drm_configurations.get_drm_configuration(
      limit: 10,
      type: 'widevine' # Example filter
    )
    
    if response.status_code == 200
      puts "✅ Filtered DRM configurations retrieved successfully"
      puts "   Configurations count: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Filtered DRM configurations:"
        response.object.data.first(3).each_with_index do |config, index|
          puts "     #{index + 1}. ID: #{config.id}"
          puts "        Name: #{config.name}"
          puts "        Type: #{config.type}"
        end
      end
    else
      puts "⚠️  Filtered DRM configurations retrieval failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Filtered DRM configurations retrieval failed: #{e.message}"
  end

  # Example 5: DRM configuration search
  puts "\n5. Searching DRM configurations..."
  begin
    # Try to search by name or other criteria
    response = sdk.drm_configurations.get_drm_configuration(
      limit: 10,
      search: 'sample' # Example search term
    )
    
    if response.status_code == 200
      puts "✅ DRM configuration search completed successfully"
      puts "   Search results count: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Search results:"
        response.object.data.first(3).each_with_index do |config, index|
          puts "     #{index + 1}. ID: #{config.id}"
          puts "        Name: #{config.name}"
          puts "        Type: #{config.type}"
        end
      end
    else
      puts "⚠️  DRM configuration search failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ DRM configuration search failed: #{e.message}"
  end

  # Example 6: DRM configuration statistics
  puts "\n6. Getting DRM configuration statistics..."
  begin
    # Get all configurations to calculate statistics
    response = sdk.drm_configurations.get_drm_configuration(limit: 100)
    
    if response.status_code == 200
      puts "✅ DRM configuration statistics retrieved successfully"
      configs = response.object&.data || []
      
      puts "   Statistics:"
      puts "   - Total configurations: #{configs.length}"
      
      # Group by type
      type_counts = configs.group_by(&:type).transform_values(&:length)
      if type_counts.any?
        puts "   - By type:"
        type_counts.each do |type, count|
          puts "     * #{type}: #{count}"
        end
      end
      
      # Group by status
      status_counts = configs.group_by(&:status).transform_values(&:length)
      if status_counts.any?
        puts "   - By status:"
        status_counts.each do |status, count|
          puts "     * #{status}: #{count}"
        end
      end
    else
      puts "⚠️  DRM configuration statistics retrieval failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ DRM configuration statistics retrieval failed: #{e.message}"
  end

  puts "\n🎉 DRM configuration examples completed!"
  puts "\nKey concepts:"
  puts "- DRM configurations control how content is protected and accessed"
  puts "- Different DRM types (Widevine, PlayReady, FairPlay) support different platforms"
  puts "- DRM configurations determine encryption and licensing policies"
  puts "- Use appropriate DRM types for your target platforms and devices"
  puts "- DRM configurations are typically managed by content administrators"

rescue => e
  puts "❌ Example failed: #{e.message}"
  puts "\nTroubleshooting:"
  puts "1. Verify your credentials are correct"
  puts "2. Check your internet connection"
  puts "3. Ensure you have proper permissions for DRM operations"
  puts "4. Some DRM operations may require specific account permissions"
  puts "5. DRM configurations may not be available in all environments"
end
