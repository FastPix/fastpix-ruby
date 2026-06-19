# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true

require 'faraday'
require 'faraday/multipart'
require 'faraday/retry'
require 'sorbet-runtime'
require_relative 'sdk_hooks/hooks'
require_relative 'utils/retries'

module FastpixClient
  extend T::Sig
  class Metrics
    extend T::Sig

    API_ERROR_OCCURRED = 'API error occurred'
    CONTENT_TYPE_HEADER = 'Content-Type'
    CONTENT_TYPE_JSON = 'application/json'
    DEFAULT_CONTENT_TYPE = 'application/octet-stream'
    UNKNOWN_CONTENT_TYPE_ERROR = 'Unknown content type received'
    USER_AGENT_HEADER = 'user-agent'

    # Applies the SDK after-request hooks and ensures a usable response is present.
    sig { params(http_response: T.nilable(Faraday::Response), error: T.nilable(StandardError), hook_ctx: SDKHooks::HookContext).returns(Faraday::Response) }
    def apply_after_request_hooks(http_response, error, hook_ctx)
      if http_response.nil? || Utils.error_status?(http_response.status)
        http_response = @sdk_configuration.hooks.after_error(
          error: error,
          hook_ctx: SDKHooks::AfterErrorHookContext.new(
            hook_ctx: hook_ctx
          ),
          response: http_response
        )
      else
        http_response = @sdk_configuration.hooks.after_success(
          hook_ctx: SDKHooks::AfterSuccessHookContext.new(
            hook_ctx: hook_ctx
          ),
          response: http_response
        )
      end

      if http_response.nil?
        raise error unless error.nil?
        raise RuntimeError, 'no response'
      end

      http_response
    end
    private :apply_after_request_hooks
    
    # Operations involving metrics

    sig { params(sdk_config: SDKConfiguration).void }
    def initialize(sdk_config)
      @sdk_configuration = sdk_config
      
    end

    sig { params(base_url: String, url_variables: T.nilable(T::Hash[Symbol, T.any(String, T::Enum)])).returns(String) }
    def get_url(base_url:, url_variables: nil)
      sd_base_url, sd_options = @sdk_configuration.get_server_details

      if base_url.nil?
        base_url = sd_base_url
      end

      if url_variables.nil?
        url_variables = sd_options
      end

      return Utils.template_url base_url, url_variables
    end


    sig { params(request: Models::Operations::ListBreakdownValuesRequest, timeout_ms: T.nilable(Integer)).returns(Models::Operations::ListBreakdownValuesResponse) }
    def list_breakdown_values(request:, timeout_ms: nil)
      # list_breakdown_values - List breakdown values
      # Retrieves breakdown values for a specified metric and timespan, allowing you to analyze the performance of your content based on various dimensions. It provides insights into how different factors contribute to the overall metrics. 
      # 
      # #### How it works
      # 
      #   1. Before using this endpoint, you can call the <a href="https://fastpix.com/docs/video-data-api/dimensions/list-dimensions">List Dimensions</a> endpoint to retrieve all available dimensions that can be used in your query. 
      # 
      #   2. Send a `GET` request to this endpoint with the required `metricId` and other query parameters. 
      # 
      #   3. You receive a response containing the breakdown values for the specified metric, grouped and filtered according to your parameters. 
      # 
      #   4. Upon successful retrieval, the response includes the breakdown values based on the specified parameters. Note that the time values ( `totalWatchTime` and `totalPlayingTime` ) are in milliseconds 
      # 
      # 
      # #### Example
      # 
      # 
      # A developer wants to analyze how watch time varies across different device types. By calling this endpoint for the `playing_time` metric and filtering by `device_type`, they can understand how engagement differs between mobile, desktop, and tablet users. This data guides optimization efforts for different platforms.
      # 
      # #### Key fields in response
      # 
      # 
      #   * **views:** The count of views based based on the applied filters.
      # 
      #   * **value:** The specific metric value calculated based on the applied filters. 
      #   * **totalWatchTime:** Total time watched across all views, represented in milliseconds. 
      # 
      #   * **totalPlayTime:** Total time spent playing the video, represented in milliseconds. 
      #   * **field:** The grouping field value based on the groupBy parameter. 
      # 
      # 
      # Related guide: <a href="https://fastpix.com/docs/concepts/what-video-data-do-we-capture">Understand data definitions</a>
      # 
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::ListBreakdownValuesRequest,
        base_url,
        '/data/metrics/{metricId}/breakdown',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::ListBreakdownValuesRequest, request, nil)
      headers['Accept'] = CONTENT_TYPE_JSON
      headers[USER_AGENT_HEADER] = @sdk_configuration.user_agent

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'list_breakdown_values',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).get(url) do |req|
          req.headers.merge!(headers)
          req.options.timeout = timeout unless timeout.nil?
          req.params = query_params
          Utils.configure_request_security(req, security)

          @sdk_configuration.hooks.before_request(
            hook_ctx: SDKHooks::BeforeRequestHookContext.new(
              hook_ctx: hook_ctx
            ),
            request: req
          )
        end
      rescue StandardError => e
        error = e
      ensure
        http_response = apply_after_request_hooks(http_response, error, hook_ctx)
      end
      
      content_type = http_response.headers.fetch(CONTENT_TYPE_HEADER, DEFAULT_CONTENT_TYPE)
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::ListBreakdownValuesResponseBody)
          response = Models::Operations::ListBreakdownValuesResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), UNKNOWN_CONTENT_TYPE_ERROR
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), API_ERROR_OCCURRED
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), API_ERROR_OCCURRED
      else
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::ListBreakdownValuesResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), UNKNOWN_CONTENT_TYPE_ERROR
        end
      end
    end


    sig { params(metric_id: Models::Operations::ListOverallValuesMetricId, measurement: T.nilable(::String), timespan: T.nilable(Models::Operations::ListOverallValuesTimespan), filterby: T.nilable(::String), timeout_ms: T.nilable(Integer)).returns(Models::Operations::ListOverallValuesResponse) }
    def list_overall_values(metric_id:, measurement: nil, timespan: nil, filterby: nil, timeout_ms: nil)
      # list_overall_values - List overall values
      # Retrieves overall values for a specified metric, providing summary statistics that help you understand the performance of your content. The response includes key metrics such as `totalWatchTime`, `uniqueViews`, `totalPlayTime` and `totalViews`. 
      # 
      # #### How it works
      # 
      #   1. Before using this endpoint, you can call the <a href="https://fastpix.com/docs/video-data-api/dimensions/list-dimensions">list dimensions</a> endpoint to retrieve all available dimensions that can be used in your query. 
      # 
      #   2. Send a `GET` request to this endpoint with the required `metricId` and other query parameters. 
      # 
      #   3. You receive a response containing the overall values for the specified metric, which may vary based on the applied filters. 
      # 
      # 
      # 
      # 
      # 
      # 
      # #### Key fields in response
      # 
      # 
      #   * **value:** The specific metric value calculated based on the applied filters. 
      #   * **totalWatchTime:** Total time watched across all views, represented in milliseconds. 
      #   * **uniqueViews:** The count of unique viewers who interacted with the content. 
      #   * **totalViews:** The total number of views recorded. 
      #   * **totalPlayTime:** Total time spent playing the video, represented in milliseconds. 
      #   * **globalValue:** A global metric value that reflects the overall performance of the specified metric across the entire dataset for the given timespan. This value is not affected by specific filters. 
      # 
      # 
      #   Related guide: <a href="https://fastpix.com/docs/concepts/what-video-data-do-we-capture">Understand data definitions</a>
      # 
      request = Models::Operations::ListOverallValuesRequest.new(
        metric_id: metric_id,
        measurement: measurement,
        timespan: timespan,
        filterby: filterby
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::ListOverallValuesRequest,
        base_url,
        '/data/metrics/{metricId}/overall',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::ListOverallValuesRequest, request, nil)
      headers['Accept'] = CONTENT_TYPE_JSON
      headers[USER_AGENT_HEADER] = @sdk_configuration.user_agent

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'list_overall_values',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).get(url) do |req|
          req.headers.merge!(headers)
          req.options.timeout = timeout unless timeout.nil?
          req.params = query_params
          Utils.configure_request_security(req, security)

          @sdk_configuration.hooks.before_request(
            hook_ctx: SDKHooks::BeforeRequestHookContext.new(
              hook_ctx: hook_ctx
            ),
            request: req
          )
        end
      rescue StandardError => e
        error = e
      ensure
        http_response = apply_after_request_hooks(http_response, error, hook_ctx)
      end
      
      content_type = http_response.headers.fetch(CONTENT_TYPE_HEADER, DEFAULT_CONTENT_TYPE)
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::ListOverallValuesResponseBody)
          response = Models::Operations::ListOverallValuesResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), UNKNOWN_CONTENT_TYPE_ERROR
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), API_ERROR_OCCURRED
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), API_ERROR_OCCURRED
      else
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::ListOverallValuesResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), UNKNOWN_CONTENT_TYPE_ERROR
        end
      end
    end


    sig { params(request: Models::Operations::GetTimeseriesDataRequest, timeout_ms: T.nilable(Integer)).returns(Models::Operations::GetTimeseriesDataResponse) }
    def get_timeseries_data(request:, timeout_ms: nil)
      # get_timeseries_data - Get timeseries data
      # This endpoint retrieves timeseries data for a specified metric, providing insights into how the metric values change over time. The response includes an array of data points, each representing the metrics value at specific intervals. 
      # 
      # #### Key fields in response
      # 
      # * **intervalTime:** The timestamp for the data point indicating when the metric value was recorded. 
      # * **metricValue:** The value of the specified metric at the given interval, reflecting the performance or engagement level during that time. 
      # * **numberOfViews:** The total number of views recorded during that interval, providing context for the metric value.
      # 
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::GetTimeseriesDataRequest,
        base_url,
        '/data/metrics/{metricId}/timeseries',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::GetTimeseriesDataRequest, request, nil)
      headers['Accept'] = CONTENT_TYPE_JSON
      headers[USER_AGENT_HEADER] = @sdk_configuration.user_agent

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'get_timeseries_data',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).get(url) do |req|
          req.headers.merge!(headers)
          req.options.timeout = timeout unless timeout.nil?
          req.params = query_params
          Utils.configure_request_security(req, security)

          @sdk_configuration.hooks.before_request(
            hook_ctx: SDKHooks::BeforeRequestHookContext.new(
              hook_ctx: hook_ctx
            ),
            request: req
          )
        end
      rescue StandardError => e
        error = e
      ensure
        http_response = apply_after_request_hooks(http_response, error, hook_ctx)
      end
      
      content_type = http_response.headers.fetch(CONTENT_TYPE_HEADER, DEFAULT_CONTENT_TYPE)
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::GetTimeseriesDataResponseBody)
          response = Models::Operations::GetTimeseriesDataResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), UNKNOWN_CONTENT_TYPE_ERROR
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), API_ERROR_OCCURRED
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), API_ERROR_OCCURRED
      else
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::GetTimeseriesDataResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), UNKNOWN_CONTENT_TYPE_ERROR
        end
      end
    end


    sig { params(timespan: T.nilable(Models::Operations::ListComparisonValuesTimespan), filterby: T.nilable(::String), dimension: T.nilable(Models::Operations::Dimension), value: T.nilable(::String), timeout_ms: T.nilable(Integer)).returns(Models::Operations::ListComparisonValuesResponse) }
    def list_comparison_values(timespan: nil, filterby: nil, dimension: nil, value: nil, timeout_ms: nil)
      # list_comparison_values - List comparison values
      # This endpoint lets you to compare multiple metrics across specified dimensions. You can specify the metrics you want to compare in the query parameters, and the response includes the relevant metrics for the specified dimensions.
      # 
      # #### Key fields in response 
      # 
      # * **value:** The specific metric value calculated based on the applied filters.
      # * **type:** The data unit or format type (for example, "number", "milliseconds", "percentage").
      # * **name:** The display name of the metric (for example, "Views", "Overall Score").
      # * **metric:** The metric field represents the name of the Key Performance Indicator (KPI) being tracked or analyzed. It identifies a specific measurable aspect of the video playback experience, such as buffering time, video start failure rate, or playback quality.
      # * **items:** Nested breakdown of related metrics for more detailed analysis.
      # * **measurement:** Defines the aggregation type (for example, "avg", "sum", "median", "95th").
      # 
      # #### How it works 
      # 
      #   1. Before making a request to this endpoint, call the <a href="https://fastpix.com/docs/video-data-api/dimensions/list-dimensions">list dimensions</a> endpoint to obtain all available dimensions that can be used for comparison. 
      # 
      #   2. Send a `GET` request to this endpoint with the desired metrics specified in the query parameters. 
      # 
      #   3. You Receive a response containing the comparison values for the specified metrics across the selected dimensions. 
      # 
      # 
      #   Related guide: <a href="https://fastpix.com/docs/working-with-video-data/explore-the-dashboard#compare-metrics">Compare metrics in dashboard</a>
      # 
      request = Models::Operations::ListComparisonValuesRequest.new(
        timespan: timespan,
        filterby: filterby,
        dimension: dimension,
        value: value
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = "#{base_url}/data/metrics/comparison"
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::ListComparisonValuesRequest, request, nil)
      headers['Accept'] = CONTENT_TYPE_JSON
      headers[USER_AGENT_HEADER] = @sdk_configuration.user_agent

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'list_comparison_values',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).get(url) do |req|
          req.headers.merge!(headers)
          req.options.timeout = timeout unless timeout.nil?
          req.params = query_params
          Utils.configure_request_security(req, security)

          @sdk_configuration.hooks.before_request(
            hook_ctx: SDKHooks::BeforeRequestHookContext.new(
              hook_ctx: hook_ctx
            ),
            request: req
          )
        end
      rescue StandardError => e
        error = e
      ensure
        http_response = apply_after_request_hooks(http_response, error, hook_ctx)
      end
      
      content_type = http_response.headers.fetch(CONTENT_TYPE_HEADER, DEFAULT_CONTENT_TYPE)
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::ListComparisonValuesResponseBody)
          response = Models::Operations::ListComparisonValuesResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), UNKNOWN_CONTENT_TYPE_ERROR
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), API_ERROR_OCCURRED
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), API_ERROR_OCCURRED
      else
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::ListComparisonValuesResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), UNKNOWN_CONTENT_TYPE_ERROR
        end
      end
    end
  end
end
