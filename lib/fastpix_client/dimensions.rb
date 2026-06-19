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
  class Dimensions
    extend T::Sig

    CONTENT_TYPE_JSON = 'application/json'
    UNKNOWN_CONTENT_TYPE_ERROR = 'Unknown content type received'
    API_ERROR_OCCURRED = 'API error occurred'

    # Operations involving dimensions

    sig { params(sdk_config: SDKConfiguration).void }
    def initialize(sdk_config)
      @sdk_configuration = sdk_config

    end

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
        raise StandardError, 'no response'
      end

      http_response
    end
    private :apply_after_request_hooks

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


    sig { params(timeout_ms: T.nilable(Integer)).returns(Models::Operations::ListDimensionsResponse) }
    def list_dimensions(timeout_ms: nil)
      # list_dimensions - List the dimensions
      # Retrieves a list of dimensions that can be used as query parameters across various data endpoints. Each dimension has a unique id that can be used to filter data effectively. 
      # 
      # The dimensions retrieved from this endpoint can be used in conjunction with the <a href="https://fastpix.com/docs/video-data-api/views/list-video-views">list video views</a> and <a href="https://fastpix.com/docs/video-data-api/views/list-by-top-content">list by top content</a> endpoints to filter results based on specific criteria. For example, you can filter views by `browser_name`, `os_name`, `device_type`, and more.
      # 
      # Related guides: <a href="https://fastpix.com/docs/concepts/what-video-data-do-we-capture#/">What Video Data do we capture?</a> ,   <a href="https://fastpix.com/docs/working-with-video-data/pass-custom-metadata-to-metrics">Use passable dimensions</a>
      # 
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = "#{base_url}/data/dimensions"
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      headers['Accept'] = CONTENT_TYPE_JSON
      headers['user-agent'] = @sdk_configuration.user_agent

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'list_dimensions',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).get(url) do |req|
          req.headers.merge!(headers)
          req.options.timeout = timeout unless timeout.nil?
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
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::ListDimensionsResponseBody)
          response = Models::Operations::ListDimensionsResponse.new(
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
          response = Models::Operations::ListDimensionsResponse.new(
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


    sig { params(dimensions_id: Models::Operations::DimensionsId, timespan: T.nilable(Models::Operations::ListFilterValuesForDimensionTimespan), filterby: T.nilable(::String), timeout_ms: T.nilable(Integer)).returns(Models::Operations::ListFilterValuesForDimensionResponse) }
    def list_filter_values_for_dimension(dimensions_id:, timespan: nil, filterby: nil, timeout_ms: nil)
      # list_filter_values_for_dimension - List the filter values for a dimension
      # This endpoint returns the filter values associated with a specific dimension, along with the total number of video views for each value. For example, it can list all `browser_name` (dimension) and show how many views occurred for all available browsers like Chrome, Safari (filter values). 
      # 
      # 
      # In order to use the <a href="https://fastpix.com/docs/working-with-video-data/use-custom-dimensions">Custom Dimensions</a>, you must enable them in the dashboard under settings option based on the plan you have opted for.
      # 
      # #### Example
      # 
      # A developer wants to know how their video content performs across different browsers. By calling this endpoint for the `device_type` dimension, they can retrieve a breakdown of video views by each device (for example, Desktop, Mobile, Tablet). This data helps the developer understand where optimizations or troubleshooting is necessary.
      # 
      # 
      # Related guide: <a href="https://fastpix.com/docs/working-with-video-data/explore-the-dashboard#filters-and-timeframes">Filters and timespan</a>
      # 
      request = Models::Operations::ListFilterValuesForDimensionRequest.new(
        dimensions_id: dimensions_id,
        timespan: timespan,
        filterby: filterby
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::ListFilterValuesForDimensionRequest,
        base_url,
        '/data/dimensions/{dimensionsId}',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::ListFilterValuesForDimensionRequest, request, nil)
      headers['Accept'] = CONTENT_TYPE_JSON
      headers['user-agent'] = @sdk_configuration.user_agent

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'list_filter_values_for_dimension',
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
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::ListFilterValuesForDimensionResponseBody)
          response = Models::Operations::ListFilterValuesForDimensionResponse.new(
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
          response = Models::Operations::ListFilterValuesForDimensionResponse.new(
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
