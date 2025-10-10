#!/usr/bin/env ruby
# frozen_string_literal: true

# FastPix Ruby SDK - AI Features Examples
# This example demonstrates in-video AI processing features

require 'fastpixapi'

# Configuration
USERNAME = ENV['FASTPIX_USERNAME'] || 'your_username_here'
PASSWORD = ENV['FASTPIX_PASSWORD'] || 'your_password_here'

puts "🤖 FastPix Ruby SDK - AI Features Examples"
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

  # Example 1: List AI features
  puts "\n1. Listing available AI features..."
  begin
    response = sdk.in_video_ai_features.list_ai_features(limit: 10)
    
    if response.status_code == 200
      puts "✅ AI features retrieved successfully"
      puts "   Total features: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Available AI features:"
        response.object.data.first(5).each_with_index do |feature, index|
          puts "     #{index + 1}. ID: #{feature.id}"
          puts "        Name: #{feature.name}"
          puts "        Type: #{feature.type}"
          puts "        Status: #{feature.status}"
          puts "        Created: #{feature.created_at || 'Unknown'}"
        end
      else
        puts "   ℹ️  No AI features found"
        puts "   This is normal for new accounts or test environments"
      end
    else
      puts "⚠️  AI features listing failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ AI features listing failed: #{e.message}"
  end

  # Example 2: Get AI feature details (if we have one)
  puts "\n2. Getting AI feature details..."
  begin
    # First, try to get an AI feature ID from the list
    list_response = sdk.in_video_ai_features.list_ai_features(limit: 1)
    
    if list_response.status_code == 200 && 
       list_response.object&.data&.any? &&
       list_response.object.data.first&.id
      
      feature_id = list_response.object.data.first.id
      puts "   Using AI feature ID: #{feature_id}"
      
      response = sdk.in_video_ai_features.get_ai_feature_by_id(
        ai_feature_id: feature_id
      )
      
      if response.status_code == 200
        puts "✅ AI feature details retrieved successfully"
        feature = response.object&.data
        puts "   ID: #{feature&.id}"
        puts "   Name: #{feature&.name}"
        puts "   Type: #{feature&.type}"
        puts "   Status: #{feature&.status}"
        puts "   Description: #{feature&.description}"
        puts "   Created: #{feature&.created_at}"
      else
        puts "⚠️  AI feature details retrieval failed with status: #{response.status_code}"
      end
    else
      puts "ℹ️  No AI features available to retrieve details for"
    end
  rescue => e
    puts "❌ AI feature details retrieval failed: #{e.message}"
  end

  # Example 3: List AI features with pagination
  puts "\n3. Listing AI features with pagination..."
  begin
    response = sdk.in_video_ai_features.list_ai_features(
      limit: 5,
      offset: 0
    )
    
    if response.status_code == 200
      puts "✅ Paginated AI features retrieved successfully"
      puts "   Features count: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   AI features:"
        response.object.data.each_with_index do |feature, index|
          puts "     #{index + 1}. ID: #{feature.id}"
          puts "        Name: #{feature.name}"
          puts "        Type: #{feature.type}"
          puts "        Status: #{feature.status}"
        end
      end
    else
      puts "⚠️  Paginated AI features retrieval failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Paginated AI features retrieval failed: #{e.message}"
  end

  # Example 4: List AI features with filters
  puts "\n4. Listing AI features with filters..."
  begin
    # Try to filter by type (if supported)
    response = sdk.in_video_ai_features.list_ai_features(
      limit: 10,
      type: 'object_detection' # Example filter
    )
    
    if response.status_code == 200
      puts "✅ Filtered AI features retrieved successfully"
      puts "   Features count: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Filtered AI features:"
        response.object.data.first(3).each_with_index do |feature, index|
          puts "     #{index + 1}. ID: #{feature.id}"
          puts "        Name: #{feature.name}"
          puts "        Type: #{feature.type}"
        end
      end
    else
      puts "⚠️  Filtered AI features retrieval failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Filtered AI features retrieval failed: #{e.message}"
  end

  # Example 5: AI feature search
  puts "\n5. Searching AI features..."
  begin
    # Try to search by name or other criteria
    response = sdk.in_video_ai_features.list_ai_features(
      limit: 10,
      search: 'detection' # Example search term
    )
    
    if response.status_code == 200
      puts "✅ AI feature search completed successfully"
      puts "   Search results count: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Search results:"
        response.object.data.first(3).each_with_index do |feature, index|
          puts "     #{index + 1}. ID: #{feature.id}"
          puts "        Name: #{feature.name}"
          puts "        Type: #{feature.type}"
        end
      end
    else
      puts "⚠️  AI feature search failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ AI feature search failed: #{e.message}"
  end

  # Example 6: AI feature statistics
  puts "\n6. Getting AI feature statistics..."
  begin
    # Get all features to calculate statistics
    response = sdk.in_video_ai_features.list_ai_features(limit: 100)
    
    if response.status_code == 200
      puts "✅ AI feature statistics retrieved successfully"
      features = response.object&.data || []
      
      puts "   Statistics:"
      puts "   - Total features: #{features.length}"
      
      # Group by type
      type_counts = features.group_by(&:type).transform_values(&:length)
      if type_counts.any?
        puts "   - By type:"
        type_counts.each do |type, count|
          puts "     * #{type}: #{count}"
        end
      end
      
      # Group by status
      status_counts = features.group_by(&:status).transform_values(&:length)
      if status_counts.any?
        puts "   - By status:"
        status_counts.each do |status, count|
          puts "     * #{status}: #{count}"
        end
      end
    else
      puts "⚠️  AI feature statistics retrieval failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ AI feature statistics retrieval failed: #{e.message}"
  end

  # Example 7: Common AI feature types
  puts "\n7. Common AI feature types..."
  puts "   Typical AI features available:"
  puts "   - Object Detection: Identify and locate objects in video frames"
  puts "   - Face Recognition: Detect and recognize faces in video content"
  puts "   - Scene Classification: Categorize video scenes and content"
  puts "   - Text Recognition: Extract text from video frames (OCR)"
  puts "   - Motion Analysis: Track movement and motion patterns"
  puts "   - Content Moderation: Detect inappropriate or sensitive content"
  puts "   - Sentiment Analysis: Analyze emotional tone of video content"
  puts "   - Quality Assessment: Evaluate video quality and technical metrics"

  puts "\n🎉 AI features examples completed!"
  puts "\nKey concepts:"
  puts "- AI features provide intelligent analysis of video content"
  puts "- Different features serve different use cases (detection, analysis, etc.)"
  puts "- AI features can be applied to both live and on-demand content"
  puts "- Features may require specific video formats or quality levels"
  puts "- AI processing may take time depending on video length and complexity"

rescue => e
  puts "❌ Example failed: #{e.message}"
  puts "\nTroubleshooting:"
  puts "1. Verify your credentials are correct"
  puts "2. Check your internet connection"
  puts "3. Ensure you have proper permissions for AI features"
  puts "4. Some AI features may require specific account permissions"
  puts "5. AI features may not be available in all environments"
end
