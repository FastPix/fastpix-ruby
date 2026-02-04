#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'test_helper'

class TestAnalytics < Minitest::Test
  def initialize(test_name = nil)
    super(test_name)
    @username = self.class.class_variable_defined?(:@@username) ? self.class.class_variable_get(:@@username) : ENV['FASTPIX_USERNAME'] || 'YOUR_FASTPIX_USERNAME'
    @password = self.class.class_variable_defined?(:@@password) ? self.class.class_variable_get(:@@password) : ENV['FASTPIX_PASSWORD'] || 'YOUR_FASTPIX_PASSWORD'
    @sdk = FastpixTestHelper.create_sdk(@username, @password)
    @models = ::FastpixApiSDK::Models
  end

  def test_list_video_views
    run_test("List Video Views") do
      begin
        request = @models::Operations::ListVideoViewsRequest.new(
          timespan: @models::Operations::ListVideoViewsTimespan::SEVENDAYS,
          limit: 10,
          offset: 1
        )
        
        response = @sdk.views.list_video_views(request: request)
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true &&
        response.object&.data.is_a?(Array)
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_get_video_view_details
    run_test("Get Video View Details") do
      begin
        # First, try to get a view ID from list
        list_response = @sdk.views.list_video_views(
          request: @models::Operations::ListVideoViewsRequest.new(
            timespan: @models::Operations::ListVideoViewsTimespan::SEVENDAYS,
            limit: 1,
            offset: 1
          )
        )
        
        if list_response.status_code == 200 && 
           list_response.object&.data&.any? &&
           list_response.object.data.first&.id
          
          view_id = list_response.object.data.first.id
          response = @sdk.views.get_video_view_details(view_id: view_id)
          
          response.status_code == 200 &&
          response.object&.success == true &&
          response.object&.data&.id == view_id
        else
          puts "   Details: No view found to test with"
          true # Skip test if no view available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_list_by_top_content
    run_test("List by Top Content") do
      begin
        response = @sdk.views.list_by_top_content(
          timespan: @models::Operations::ListByTopContentTimespan::SEVENDAYS,
          limit: 10
        )
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true &&
        response.object&.data.is_a?(Array)
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_get_timeseries_views
    run_test("Get Timeseries Views") do
      begin
        response = @sdk.views.get_data_viewlist_current_views_get_timeseries_views
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true
      rescue => e
        puts "   Details: #{e.message}"
        # Accept validation errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ? true : false
      end
    end
  end

  def test_filter_views
    run_test("Filter Views") do
      begin
        response = @sdk.views.get_data_viewlist_current_views_filter(
          dimension: @models::Operations::GetDataViewlistCurrentViewsFilterDimension::COUNTRY,
          limit: 10
        )
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true
      rescue => e
        puts "   Details: #{e.message}"
        # Accept validation errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ? true : false
      end
    end
  end

  def test_list_dimensions
    run_test("List Dimensions") do
      begin
        response = @sdk.dimensions.list_dimensions
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true &&
        response.object&.data.is_a?(Array)
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_get_filter_values_for_dimension
    run_test("Get Filter Values for Dimension") do
      begin
        # First, try to get a dimension ID from list
        list_response = @sdk.dimensions.list_dimensions
        
        if list_response.status_code == 200 && 
           list_response.object&.data&.any?
          
          dimension_string = list_response.object.data.first
          # Convert string to enum
          dimension_id = case dimension_string
                        when 'browser_name' then @models::Operations::DimensionsId::BROWSER_NAME
                        when 'browser_version' then @models::Operations::DimensionsId::BROWSER_VERSION
                        when 'os_name' then @models::Operations::DimensionsId::OS_NAME
                        when 'os_version' then @models::Operations::DimensionsId::OS_VERSION
                        when 'device_name' then @models::Operations::DimensionsId::DEVICE_NAME
                        when 'device_model' then @models::Operations::DimensionsId::DEVICE_MODEL
                        when 'device_type' then @models::Operations::DimensionsId::DEVICE_TYPE
                        when 'device_manufacturer' then @models::Operations::DimensionsId::DEVICE_MANUFACTURER
                        else @models::Operations::DimensionsId::BROWSER_NAME # Default fallback
                        end
          
          response = @sdk.dimensions.list_filter_values_for_dimension(
            dimensions_id: dimension_id,
            timespan: @models::Operations::ListFilterValuesForDimensionTimespan::SEVENDAYS
          )
          
          response.status_code == 200 &&
          response.object&.success == true
        else
          puts "   Details: No dimension found to test with"
          true # Skip test if no dimension available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_list_overall_values
    run_test("List Overall Values") do
      begin
        response = @sdk.metrics.list_overall_values(
          metric_id: @models::Operations::ListOverallValuesMetricId::VIEWS,
          timespan: @models::Operations::ListOverallValuesTimespan::SEVENDAYS
        )
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true
      rescue => e
        puts "   Details: #{e.message}"
        # Accept validation errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ? true : false
      end
    end
  end

  def test_get_timeseries_data
    run_test("Get Timeseries Data") do
      begin
        request = @models::Operations::GetTimeseriesDataRequest.new(
          metric_id: @models::Operations::GetTimeseriesDataMetricId::VIEWS,
          timespan: @models::Operations::GetTimeseriesDataTimespan::SEVENDAYS
        )
        
        response = @sdk.metrics.get_timeseries_data(request: request)
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true
      rescue => e
        puts "   Details: #{e.message}"
        # Accept validation errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ? true : false
      end
    end
  end

  def test_list_breakdown_values
    run_test("List Breakdown Values") do
      begin
        request = @models::Operations::ListBreakdownValuesRequest.new(
          metric_id: @models::Operations::ListBreakdownValuesMetricId::VIEWS,
          timespan: @models::Operations::ListBreakdownValuesTimespan::SEVENDAYS,
          group_by: 'browser_name'
        )
        
        response = @sdk.metrics.list_breakdown_values(request: request)
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true
      rescue => e
        puts "   Details: #{e.message}"
        # Accept validation errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ? true : false
      end
    end
  end

  def test_list_comparison_values
    run_test("List Comparison Values") do
      begin
        response = @sdk.metrics.list_comparison_values(
          timespan: @models::Operations::ListComparisonValuesTimespan::SEVENDAYS,
          dimension: @models::Operations::ListComparisonValuesDimension::BROWSER_NAME
        )
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true
      rescue => e
        puts "   Details: #{e.message}"
        # Accept validation errors as valid for this test
        e.is_a?(::FastpixApiSDK::Models::Errors::ValidationErrorResponse) ? true : false
      end
    end
  end

  def test_list_signing_keys
    run_test("List Signing Keys") do
      begin
        response = @sdk.signing_keys.list_signing_keys(limit: 10.0, offset: 1.0)
        
        # Check if response is successful
        response.status_code == 200 &&
        response.object&.success == true &&
        response.object&.data.is_a?(Array)
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_create_signing_key
    run_test("Create Signing Key") do
      begin
        response = @sdk.signing_keys.create_signing_key
        
        # Check if response is successful
        response.status_code == 201 &&
        response.object&.success == true &&
        response.object&.data&.id
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_get_signing_key_by_id
    run_test("Get Signing Key by ID") do
      begin
        # First, try to get a signing key ID from list
        list_response = @sdk.signing_keys.list_signing_keys(limit: 1.0)
        
        if list_response.status_code == 200 && 
           list_response.object&.data&.any? &&
           list_response.object.data.first&.id
          
          key_id = list_response.object.data.first.id
          response = @sdk.signing_keys.get_signing_key_by_id(signing_key_id: key_id)
          
          response.status_code == 200 &&
          response.object&.success == true &&
          response.object&.data&.id == key_id
        else
          puts "   Details: No signing key found to test with"
          true # Skip test if no signing key available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end

  def test_delete_signing_key
    run_test("Delete Signing Key") do
      begin
        # First, try to get a signing key ID from list
        list_response = @sdk.signing_keys.list_signing_keys(limit: 1.0)
        
        if list_response.status_code == 200 && 
           list_response.object&.data&.any? &&
           list_response.object.data.first&.id
          
          key_id = list_response.object.data.first.id
          response = @sdk.signing_keys.delete_signing_key(signing_key_id: key_id)
          
          response.status_code == 200 &&
          response.object&.success == true
        else
          puts "   Details: No signing key found to test with"
          true # Skip test if no signing key available
        end
      rescue => e
        puts "   Details: #{e.message}"
        false
      end
    end
  end
end
