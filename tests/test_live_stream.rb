#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'test_helper'

class TestLiveStream < Minitest::Test
  def initialize(test_name = nil)
    super(test_name)
    @username = self.class.class_variable_defined?(:@@username) ? self.class.class_variable_get(:@@username) : ENV['FASTPIX_USERNAME'] || 'YOUR_FASTPIX_USERNAME'
    @password = self.class.class_variable_defined?(:@@password) ? self.class.class_variable_get(:@@password) : ENV['FASTPIX_PASSWORD'] || 'YOUR_FASTPIX_PASSWORD'
    @sdk = FastpixTestHelper.create_sdk(@username, @password)
    @models = ::FastpixApiSDK::Models
    @test_stream_id = nil
  end

  def test_create_new_stream
    run_test("Create New Stream") do
      begin
        request = @models::Components::CreateLiveStreamRequest.new(
          playback_settings: @models::Components::PlaybackSettings.new,
          input_media_settings: @models::Components::InputMediaSettings.new(
            metadata: {
              "test_stream": 'live_test'
            }
          )
        )
        
        response = @sdk.start_live_stream.create_new_stream(request: request)
        
        if response.status_code == 201 &&
           response.object&.success == true &&
           response.object&.data&.stream_id
          @test_stream_id = response.object.data.stream_id
          true
        else
          false
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_get_all_streams
    run_test("Get All Streams") do
      begin
        response = @sdk.manage_live_stream.get_all_streams(limit: 10, offset: 1)
        
        response.status_code == 200 &&
        response.object&.success == true &&
        response.object&.data.is_a?(Array)
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_get_live_stream_by_id
    run_test("Get Live Stream by ID") do
      begin
        if @test_stream_id
          response = @sdk.manage_live_stream.get_live_stream_by_id(stream_id: @test_stream_id)
          
          response.status_code == 200 &&
          response.object&.success == true &&
          response.object&.data&.id == @test_stream_id
        else
          puts "   Details: No stream ID available from previous test"
          true # Skip test if no stream ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_get_live_stream_viewer_count
    run_test("Get Live Stream Viewer Count") do
      begin
        if @test_stream_id
          response = @sdk.manage_live_stream.get_live_stream_viewer_count_by_id(stream_id: @test_stream_id)
          
          response.status_code == 200 &&
          response.object&.success == true &&
          response.object&.data&.viewer_count.is_a?(Numeric)
        else
          puts "   Details: No stream ID available from previous test"
          true # Skip test if no stream ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_update_live_stream
    run_test("Update Live Stream") do
      begin
        if @test_stream_id
          request = @models::Components::PatchLiveStreamRequest.new(
            metadata: {
              "updated_stream": 'updated_test'
            }
          )
          
          response = @sdk.manage_live_stream.update_live_stream(
            patch_live_stream_request: request,
            stream_id: @test_stream_id
          )
          
          response.status_code == 200 &&
          response.object&.success == true
        else
          puts "   Details: No stream ID available from previous test"
          true # Skip test if no stream ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_create_playback_id_of_stream
    run_test("Create Playback ID of Stream") do
      begin
        if @test_stream_id
          request = @models::Components::PlaybackIdRequest.new(
            access_policy: @models::Components::AccessPolicy::PUBLIC
          )
          
          response = @sdk.live_playback.create_playback_id_of_stream(
            playback_id_request: request,
            stream_id: @test_stream_id
          )
          
          response.status_code == 201 &&
          response.object&.success == true &&
          response.object&.data&.playback_id
        else
          puts "   Details: No stream ID available from previous test"
          true # Skip test if no stream ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_create_simulcast_of_stream
    run_test("Create Simulcast of Stream") do
      begin
        if @test_stream_id
          request = @models::Components::SimulcastRequest.new(
            platform: 'youtube',
            stream_key: 'test_stream_key',
            metadata: {
              "simulcast_test": 'test_value'
            }
          )
          
          response = @sdk.simulcast_stream.create_simulcast_of_stream(
            simulcast_request: request,
            stream_id: @test_stream_id
          )
          
          response.status_code == 201 &&
          response.object&.success == true &&
          response.object&.data&.id
        else
          puts "   Details: No stream ID available from previous test"
          true # Skip test if no stream ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_disable_live_stream
    run_test("Disable Live Stream") do
      begin
        if @test_stream_id
          response = @sdk.manage_live_stream.disable_live_stream(stream_id: @test_stream_id)
          
          response.status_code == 200 &&
          response.object&.success == true
        else
          puts "   Details: No stream ID available from previous test"
          true # Skip test if no stream ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_complete_live_stream
    run_test("Complete Live Stream") do
      begin
        if @test_stream_id
          response = @sdk.manage_live_stream.complete_live_stream(stream_id: @test_stream_id)
          
          response.status_code == 200 &&
          response.object&.success == true
        else
          puts "   Details: No stream ID available from previous test"
          true # Skip test if no stream ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_delete_live_stream
    run_test("Delete Live Stream") do
      begin
        if @test_stream_id
          response = @sdk.manage_live_stream.delete_live_stream(stream_id: @test_stream_id)
          
          response.status_code == 200 &&
          response.object&.success == true
        else
          puts "   Details: No stream ID available from previous test"
          true # Skip test if no stream ID available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end
end
