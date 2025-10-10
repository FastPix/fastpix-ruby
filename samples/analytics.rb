#!/usr/bin/env ruby
# frozen_string_literal: true

# FastPix Ruby SDK - Analytics Examples
# This example demonstrates analytics and metrics operations

require 'fastpixapi'

# Configuration
USERNAME = ENV['FASTPIX_USERNAME'] || 'your_username_here'
PASSWORD = ENV['FASTPIX_PASSWORD'] || 'your_password_here'

puts "📊 FastPix Ruby SDK - Analytics Examples"
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

  # Example 1: List video views
  puts "\n1. Listing video views..."
  begin
    response = sdk.views.list_video_views(limit: 10)
    
    if response.status_code == 200
      puts "✅ Video views retrieved successfully"
      puts "   Total views: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Recent views:"
        response.object.data.first(3).each_with_index do |view, index|
          puts "     #{index + 1}. View ID: #{view.id}"
          puts "        Media ID: #{view.media_id}"
          puts "        Playback ID: #{view.playback_id}"
          puts "        Created: #{view.created_at || 'Unknown'}"
        end
      end
    else
      puts "⚠️  Video views listing failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Video views listing failed: #{e.message}"
  end

  # Example 2: Get timeseries data
  puts "\n2. Getting timeseries data..."
  begin
    request = FastpixApiSDK::Models::Operations::GetTimeseriesDataRequest.new(
      metric_id: FastpixApiSDK::Models::Operations::GetTimeseriesDataMetricId::VIEWS,
      timespan: FastpixApiSDK::Models::Operations::GetTimeseriesDataTimespan::SEVENDAYS
    )

    response = sdk.metrics.get_timeseries_data(request: request)
    
    if response.status_code == 200
      puts "✅ Timeseries data retrieved successfully"
      data = response.object&.data
      puts "   Metric: #{data&.metric_id}"
      puts "   Timespan: #{data&.timespan}"
      puts "   Data points: #{data&.data&.length || 0}"
      
      if data&.data&.any?
        puts "   Sample data points:"
        data.data.first(3).each_with_index do |point, index|
          puts "     #{index + 1}. Time: #{point.time}"
          puts "        Value: #{point.value}"
        end
      end
    else
      puts "⚠️  Timeseries data retrieval failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Timeseries data retrieval failed: #{e.message}"
  end

  # Example 3: List breakdown values for dimensions
  puts "\n3. Getting breakdown values for dimensions..."
  begin
    # First, get available dimensions
    dimensions_response = sdk.dimensions.list_dimensions()
    
    if dimensions_response.status_code == 200 && dimensions_response.object&.data&.any?
      dimension = dimensions_response.object.data.first
      puts "   Using dimension: #{dimension}"
      
      # Get breakdown values for the first dimension
      breakdown_response = sdk.dimensions.list_breakdown_values_for_dimension(
        dimension_id: dimension,
        limit: 10
      )
      
      if breakdown_response.status_code == 200
        puts "✅ Breakdown values retrieved successfully"
        puts "   Dimension: #{dimension}"
        puts "   Values count: #{breakdown_response.object&.data&.length || 0}"
        
        if breakdown_response.object&.data&.any?
          puts "   Sample values:"
          breakdown_response.object.data.first(5).each_with_index do |value, index|
            puts "     #{index + 1}. #{value}"
          end
        end
      else
        puts "⚠️  Breakdown values retrieval failed with status: #{breakdown_response.status_code}"
      end
    else
      puts "ℹ️  No dimensions available for breakdown analysis"
    end
  rescue => e
    puts "❌ Breakdown values retrieval failed: #{e.message}"
  end

  # Example 4: List comparison values
  puts "\n4. Getting comparison values..."
  begin
    response = sdk.dimensions.list_comparison_values(limit: 10)
    
    if response.status_code == 200
      puts "✅ Comparison values retrieved successfully"
      puts "   Values count: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Sample comparison values:"
        response.object.data.first(5).each_with_index do |value, index|
          puts "     #{index + 1}. #{value}"
        end
      end
    else
      puts "⚠️  Comparison values retrieval failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Comparison values retrieval failed: #{e.message}"
  end

  # Example 5: Get specific video view details (if we have views)
  puts "\n5. Getting specific video view details..."
  begin
    # First, try to get a view ID from the list
    views_response = sdk.views.list_video_views(limit: 1)
    
    if views_response.status_code == 200 && 
       views_response.object&.data&.any? &&
       views_response.object.data.first&.id
      
      view_id = views_response.object.data.first.id
      puts "   Using view ID: #{view_id}"
      
      response = sdk.views.get_video_view_details(view_id: view_id)
      
      if response.status_code == 200
        puts "✅ Video view details retrieved successfully"
        view = response.object&.data
        puts "   View ID: #{view&.id}"
        puts "   Media ID: #{view&.media_id}"
        puts "   Playback ID: #{view&.playback_id}"
        puts "   Duration: #{view&.duration} seconds" if view&.duration
        puts "   Created: #{view&.created_at}"
      else
        puts "⚠️  Video view details retrieval failed with status: #{response.status_code}"
      end
    else
      puts "ℹ️  No video views available to retrieve details for"
    end
  rescue => e
    puts "❌ Video view details retrieval failed: #{e.message}"
  end

  # Example 6: List signing keys (for analytics access)
  puts "\n6. Listing signing keys..."
  begin
    response = sdk.signing_keys.list_signing_keys(limit: 10)
    
    if response.status_code == 200
      puts "✅ Signing keys retrieved successfully"
      puts "   Keys count: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Recent signing keys:"
        response.object.data.first(3).each_with_index do |key, index|
          puts "     #{index + 1}. ID: #{key.id}"
          puts "        Name: #{key.name}"
          puts "        Created: #{key.created_at || 'Unknown'}"
        end
      end
    else
      puts "⚠️  Signing keys listing failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Signing keys listing failed: #{e.message}"
  end

  puts "\n🎉 Analytics examples completed!"
  puts "\nNext steps:"
  puts "- Check out metrics.rb for more detailed metrics operations"
  puts "- Use the analytics data to build dashboards and reports"
  puts "- Integrate with your application's analytics pipeline"

rescue => e
  puts "❌ Example failed: #{e.message}"
  puts "\nTroubleshooting:"
  puts "1. Verify your credentials are correct"
  puts "2. Check your internet connection"
  puts "3. Ensure you have proper permissions for analytics operations"
  puts "4. Some analytics data may require time to accumulate"
end
