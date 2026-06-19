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
  class Views
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
    
    # Operations involving views

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


    sig { params(request: Models::Operations::ListVideoViewsRequest, timeout_ms: T.nilable(Integer)).returns(Models::Operations::ListVideoViewsResponse) }
    def list_video_views(request:, timeout_ms: nil)
      # list_video_views - List video views
      # Retrieves a list of video views that fall within the specified filters and have been completed within a defined timespan. It lets you to analyse viewer interactions with your video content effectively. 
      # 
      # 
      # #### How it works
      # 
      #   1. Send a `GET` request to this endpoint with the desired query parameters. 
      # 
      #   2. Specify the timespan for which you want to retrieve the video views using the `timespan[]` parameter. 
      # 
      #   3. Filter the views based on dimensions such as browser, device, video title, viewer ID, etc., using the `filterby[]` parameter. Get the dimensions by calling <a href="https://fastpix.com/docs/video-data-api/dimensions/list-dimensions">list the dimensions</a> endpoint. 
      # 
      #   4. Paginate the results using the `limit` and `offset` parameters. 
      # 
      #   5. You can also filter by `viewerId`, `errorCode`, `orderBy` a specific field, and `sortOrder` in ascending or descending order. 
      # 
      #   6. You receive a response containing the list of video views matching the specified criteria.
      # 
      # Each view in the response includes a unique `viewId`. You can use this `viewId` with the  <a href="https://fastpix.com/docs/video-data-api/views/get-video-view-details">Get Video View Details</a> endpoint to retrieve more detailed information about that specific view.
      # 
      # 
      # #### Example
      # 
      # If you manage a video streaming service and want to analyze content performance across devices and browsers. By calling the List Video Views endpoint with filters such as `browser_name` and `device_type`, you can identify which platforms are most popular with your audience. This information helps optimize content for widely used platforms and troubleshoot playback issues on less common devices.
      # 
      # 
      #   Related guide: <a href="https://fastpix.com/docs/concepts/audience-metrics">Audience metrics</a>, <a href="https://fastpix.com/docs/working-with-video-data/explore-the-dashboard#1-views-dashboard">Views dashboard</a>
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = "#{base_url}/data/viewlist"
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::ListVideoViewsRequest, request, nil)
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
        operation_id: 'list_video_views',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::ListVideoViewsResponseBody)
          response = Models::Operations::ListVideoViewsResponse.new(
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
          response = Models::Operations::ListVideoViewsResponse.new(
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


    sig { params(view_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::GetVideoViewDetailsResponse) }
    def get_video_view_details(view_id:, timeout_ms: nil)
      # get_video_view_details - Get details of video view
      # Retrieves detailed information about a specific video view using its unique `viewId`. This provides insights into individual viewer interactions with your video content, helping you enhance user experience and improve engagement with your videos. 
      # 
      # To use this endpoint, send `GET` request with the `viewId`. The response includes detailed metrics and attributes related to the specified video view. 
      # 
      # 
      # #### Example
      # 
      # If a developer receives a report of a poor viewing experience for a specific user. By using this endpoint with the users `viewId`, the developer can retrieve metrics like buffering duration, playback errors, and session length. This data allows the developer to pinpoint issues (such as poor connectivity or a browser-specific problem) and take steps to improve the user experience.
      # 
      # 
      # Related guide: <a href="https://fastpix.com/docs/concepts/what-video-data-do-we-capture#/">What Video Data do we capture?</a>
      request = Models::Operations::GetVideoViewDetailsRequest.new(
        view_id: view_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::GetVideoViewDetailsRequest,
        base_url,
        '/data/viewlist/{viewId}',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
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
        operation_id: 'get_video_view_details',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::GetVideoViewDetailsResponseBody)
          response = Models::Operations::GetVideoViewDetailsResponse.new(
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
          response = Models::Operations::GetVideoViewDetailsResponse.new(
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


    sig { params(timespan: T.nilable(Models::Operations::ListByTopContentTimespan), filterby: T.nilable(::String), limit: T.nilable(::Integer), timeout_ms: T.nilable(Integer)).returns(Models::Operations::ListByTopContentResponse) }
    def list_by_top_content(timespan: nil, filterby: nil, limit: nil, timeout_ms: nil)
      # list_by_top_content - List by top content
      # Retrieves a list of the top video views that fall within the specified filters and have been completed within a defined timespan. It lets you to identify the most popular content based on viewer interactions. 
      # 
      # #### How it works
      # 
      #   1. Send a `GET` request to this endpoint with the desired query parameters. 
      # 
      #   2. Specify the timespan for which you want to retrieve the top content using the `timespan[]` parameter. 
      # 
      #   3. Filter the views based on dimensions such as browser, device, video title, etc., using the `filterby[]` parameter. 
      # 
      #   4. You can use `Limit` to control number of top views returned. 
      # 
      #   5. You receive a response containing the list of top video views matching the specified criteria.
      # 
      # 
      #   Related guide: <a href="https://fastpix.com/docs/working-with-video-data/identify-top-performing-content">Get top-performing content</a>
      # 
      request = Models::Operations::ListByTopContentRequest.new(
        timespan: timespan,
        filterby: filterby,
        limit: limit
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = "#{base_url}/data/viewlist/top-content"
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::ListByTopContentRequest, request, nil)
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
        operation_id: 'list_by_top_content',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::ListByTopContentResponseBody)
          response = Models::Operations::ListByTopContentResponse.new(
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
          response = Models::Operations::ListByTopContentResponse.new(
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
