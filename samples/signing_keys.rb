#!/usr/bin/env ruby
# frozen_string_literal: true

# FastPix Ruby SDK - Signing Keys Examples
# This example demonstrates signing key management for secure access

require 'fastpixapi'

# Configuration
USERNAME = ENV['FASTPIX_USERNAME'] || 'your_username_here'
PASSWORD = ENV['FASTPIX_PASSWORD'] || 'your_password_here'

puts "🔐 FastPix Ruby SDK - Signing Keys Examples"
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

  # Example 1: List existing signing keys
  puts "\n1. Listing existing signing keys..."
  begin
    response = sdk.signing_keys.list_signing_keys(limit: 10)
    
    if response.status_code == 200
      puts "✅ Signing keys retrieved successfully"
      puts "   Total keys: #{response.object&.data&.length || 0}"
      
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

  # Example 2: Create a new signing key
  puts "\n2. Creating a new signing key..."
  begin
    create_request = FastpixApiSDK::Models::Components::CreateSigningKeyRequest.new(
      name: "Sample Signing Key #{Time.now.strftime('%Y%m%d_%H%M%S')}",
      description: "Sample signing key created via Ruby SDK",
      metadata: {
        'source' => 'ruby_sdk_sample',
        'created_at' => Time.now.iso8601
      }
    )

    response = sdk.signing_keys.create_signing_key(request: create_request)
    
    if response.status_code == 201
      puts "✅ Signing key created successfully"
      key = response.object&.data
      puts "   Key ID: #{key&.id}"
      puts "   Name: #{key&.name}"
      puts "   Description: #{key&.description}"
      puts "   Created: #{key&.created_at}"
      
      # Store key ID for later operations
      @signing_key_id = key&.id
    else
      puts "⚠️  Signing key creation failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Signing key creation failed: #{e.message}"
  end

  # Example 3: Get signing key details (if we created one)
  if @signing_key_id
    puts "\n3. Getting signing key details..."
    begin
      response = sdk.signing_keys.get_signing_key_by_id(signing_key_id: @signing_key_id)
      
      if response.status_code == 200
        puts "✅ Signing key details retrieved successfully"
        key = response.object&.data
        puts "   ID: #{key&.id}"
        puts "   Name: #{key&.name}"
        puts "   Description: #{key&.description}"
        puts "   Created: #{key&.created_at}"
        puts "   Updated: #{key&.updated_at}"
      else
        puts "⚠️  Signing key details retrieval failed with status: #{response.status_code}"
      end
    rescue => e
      puts "❌ Signing key details retrieval failed: #{e.message}"
    end
  end

  # Example 4: Get public PEM using signing key ID
  if @signing_key_id
    puts "\n4. Getting public PEM for signing key..."
    begin
      response = sdk.signing_keys.get_public_pem_using_signing_key_id(
        signing_key_id: @signing_key_id
      )
      
      if response.status_code == 200
        puts "✅ Public PEM retrieved successfully"
        pem_data = response.object&.data
        puts "   Key ID: #{pem_data&.id}"
        puts "   Public PEM length: #{pem_data&.public_pem&.length || 0} characters"
        puts "   Public PEM preview: #{pem_data&.public_pem&.[](0..50)}..."
      else
        puts "⚠️  Public PEM retrieval failed with status: #{response.status_code}"
      end
    rescue => e
      puts "❌ Public PEM retrieval failed: #{e.message}"
    end
  end

  # Example 5: Update signing key
  if @signing_key_id
    puts "\n5. Updating signing key..."
    begin
      update_request = FastpixApiSDK::Models::Components::UpdateSigningKeyRequest.new(
        name: "Updated Signing Key #{Time.now.strftime('%Y%m%d_%H%M%S')}",
        description: "Updated signing key description",
        metadata: {
          'updated_at' => Time.now.iso8601,
          'updated_by' => 'ruby_sdk'
        }
      )

      response = sdk.signing_keys.update_signing_key(
        signing_key_id: @signing_key_id,
        request: update_request
      )
      
      if response.status_code == 200
        puts "✅ Signing key updated successfully"
        key = response.object&.data
        puts "   Updated Name: #{key&.name}"
        puts "   Updated Description: #{key&.description}"
      else
        puts "⚠️  Signing key update failed with status: #{response.status_code}"
      end
    rescue => e
      puts "❌ Signing key update failed: #{e.message}"
    end
  end

  # Example 6: List signing keys with pagination
  puts "\n6. Listing signing keys with pagination..."
  begin
    response = sdk.signing_keys.list_signing_keys(
      limit: 5,
      offset: 0
    )
    
    if response.status_code == 200
      puts "✅ Paginated signing keys retrieved successfully"
      puts "   Keys count: #{response.object&.data&.length || 0}"
      
      if response.object&.data&.any?
        puts "   Signing keys:"
        response.object.data.each_with_index do |key, index|
          puts "     #{index + 1}. ID: #{key.id}"
          puts "        Name: #{key.name}"
          puts "        Created: #{key.created_at || 'Unknown'}"
        end
      end
    else
      puts "⚠️  Paginated signing keys retrieval failed with status: #{response.status_code}"
    end
  rescue => e
    puts "❌ Paginated signing keys retrieval failed: #{e.message}"
  end

  # Example 7: Delete signing key (if we created one)
  if @signing_key_id
    puts "\n7. Deleting signing key..."
    begin
      response = sdk.signing_keys.delete_signing_key(signing_key_id: @signing_key_id)
      
      if response.status_code == 200
        puts "✅ Signing key deleted successfully"
        puts "   Deleted Key ID: #{@signing_key_id}"
      else
        puts "⚠️  Signing key deletion failed with status: #{response.status_code}"
      end
    rescue => e
      puts "❌ Signing key deletion failed: #{e.message}"
    end
  end

  puts "\n🎉 Signing keys examples completed!"
  puts "\nKey concepts:"
  puts "- Signing keys are used for secure access and token management"
  puts "- Each key has a public/private key pair for cryptographic operations"
  puts "- Keys can be used to sign requests and verify authenticity"
  puts "- Store private keys securely and never expose them"
  puts "- Use public keys for verification and sharing"

rescue => e
  puts "❌ Example failed: #{e.message}"
  puts "\nTroubleshooting:"
  puts "1. Verify your credentials are correct"
  puts "2. Check your internet connection"
  puts "3. Ensure you have proper permissions for signing key operations"
  puts "4. Some operations may require specific account permissions"
end
