
# typed: true
# frozen_string_literal: true

require 'faraday'
require 'faraday/multipart'
require 'faraday/retry'
require 'sorbet-runtime'
require_relative 'sdk_hooks/hooks'
require_relative 'utils/retries'

module FastpixApiSDK
  extend T::Sig
  class ManageVideos
    extend T::Sig
    


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


    sig { params(limit: T.nilable(::Integer), offset: T.nilable(::Integer), order_by: T.nilable(Models::Components::SortOrder), retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::ListMediaResponse) }
    def list_media(limit: nil, offset: nil, order_by: nil, retries: nil, timeout_ms: nil)
      # list_media - Get list of all media
      # This endpoint returns a list of all media files uploaded to FastPix within a specific workspace. Each media entry contains data such as the media `id`, `createdAt`, `status`, `type` and more. It allows you to retrieve an overview of your media assets, making it easier to manage and review them. 
      # 
      # 
      # #### How it works
      # 
      # Use the access token and secret key related to the workspace in the request header. When called, the API provides a paginated response containing all the media items in that specific workspace. This is helpful for retrieving a large volume of media and managing content in bulk. 
      # 
      # 
      # 
      # #### Example
      # You're managing a video platform and need to check all the uploaded media in your library to ensure no outdated or low-quality content is being served. Using this endpoint, you can retrieve a complete list of media, allowing you to filter, sort, or update items as needed.
      # 
      request = Models::Operations::ListMediaRequest.new(
        limit: limit,
        offset: offset,
        order_by: order_by
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = "#{base_url}/on-demand"
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::ListMediaRequest, request, nil)
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'list-media',
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::ListMediaResponseBody)
          response = Models::Operations::ListMediaResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(livestream_id: ::String, limit: T.nilable(::Integer), offset: T.nilable(::Integer), order_by: T.nilable(Models::Components::SortOrder), retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::ListLiveClipsResponse) }
    def list_live_clips(livestream_id:, limit: nil, offset: nil, order_by: nil, retries: nil, timeout_ms: nil)
      # list_live_clips - Get all clips of a live stream
      # Retrieves a list of all media clips generated from a specific livestream. Each media entry includes metadata such as the clip media IDs, and other relevant details. A media clip is a segmented portion of an original media file (source live stream). Clips are often created for various purposes such as previews, highlights, or customized edits.
      # #### How it works
      # To use this endpoint, provide the `livestreamId` as a parameter. The API then returns a paginated list of clipped media items created from that livestream. Pagination ensures optimal performance and usability when dealing with a large number of media files, making it easier to organize and manage content in bulk.
      # 
      # Related guide: <a href="https://docs.fastpix.io/docs/instant-live-clipping">Instant live clipping</a>
      # 
      request = Models::Operations::ListLiveClipsRequest.new(
        livestream_id: livestream_id,
        limit: limit,
        offset: offset,
        order_by: order_by
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::ListLiveClipsRequest,
        base_url,
        '/on-demand/{livestreamId}/live-clips',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::ListLiveClipsRequest, request, nil)
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'list-live-clips',
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::ListLiveClipsResponseBody)
          response = Models::Operations::ListLiveClipsResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(media_id: ::String, retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::GetMediaResponse) }
    def get_media(media_id:, retries: nil, timeout_ms: nil)
      # get_media - Get a media by ID
      # By calling this endpoint, you can retrieve detailed information about a specific media item, including its current `status` and a `playbackId`. This is particularly useful for retrieving specific media details when managing large content libraries. 
      # 
      # 
      # 
      # #### How it works 
      # 
      # 
      # 
      # 1. Make a GET request to this endpoint, using the `<mediaId>` received after uploading the media file. 
      # 
      # 
      # 2. Receive a response that includes details about the media: 
      # 
      # * `status` Indicates whether the media is still `preparing` or has transitioned to `ready`.  
      # 
      # * The `playbackId` is a unique identifier that allows you to stream the media once it is `ready`. You can construct the stream URL in this format: `https://stream.fastpix.io/<playbackId>.m3u8`
      # 
      # 
      # #### Example
      # 
      # Suppose your platform provides users with an interface where they can manage their uploaded content. A user requests detailed information about a specific video to see if it has been fully processed and is available for playback. Using the media ID, you can fetch the information from FastPix and display it in the user's dashboard.
      # 
      request = Models::Operations::GetMediaRequest.new(
        media_id: media_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::GetMediaRequest,
        base_url,
        '/on-demand/{mediaId}',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'get-media',
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::GetMediaResponseBody)
          response = Models::Operations::GetMediaResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(request_body: Models::Operations::UpdatedMediaRequestBody, media_id: ::String, retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdatedMediaResponse) }
    def updated_media(request_body:, media_id:, retries: nil, timeout_ms: nil)
      # updated_media - Update a media by ID
      # This endpoint allows you to update specific parameters of an existing media file. You can modify the key-value pairs of the metadata that were provided in the payload during the creation of media from a URL or when uploading the media directly from device. 
      # 
      # 
      # #### How it works
      # 
      # 1. Make a PATCH request to this endpoint, replacing `<mediaId>` with the unique ID (`uploadId` or `id`) of the media received after uploading to FastPix. 
      # 
      # 2. Include the updated parameters in the request body. 
      # 
      # 3. Receive a response containing the updated media data, confirming the changes made. 
      # 
      # Once you have made the update request, you can also look for the webhook event <a href="https://docs.fastpix.io/docs/media-events#videomediaupdated">video.media.updated</a> to notify your system about update status. 
      # 
      # #### Example
      # Imagine a scenario where a user uploads a video and later realizes they need to change the title, add a new description or tags. You can use this endpoint to update the media metadata without having to re-upload the entire video.
      # 
      request = Models::Operations::UpdatedMediaRequest.new(
        media_id: media_id,
        request_body: request_body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdatedMediaRequest,
        base_url,
        '/on-demand/{mediaId}',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :request_body, :json)
      headers['content-type'] = req_content_type
      raise StandardError, 'request body is required' if data.nil? && form.nil?

      if form
        body = Utils.encode_form(form)
      elsif Utils.match_content_type(req_content_type, 'application/x-www-form-urlencoded')
        body = URI.encode_www_form(T.cast(data, T::Hash[Symbol, Object]))
      else
        body = data
      end
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'updated-media',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).patch(url) do |req|
          req.body = body
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::UpdatedMediaResponseBody)
          response = Models::Operations::UpdatedMediaResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(media_id: ::String, retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::DeleteMediaResponse) }
    def delete_media(media_id:, retries: nil, timeout_ms: nil)
      # delete_media - Delete a media by ID
      # This endpoint allows you to permanently delete a a specific video or audio media file along with all associated data. If you wish to remove a media from FastPix storage, use this endpoint with the `mediaId` (either `uploadId` or `id`) received during the media's creation or upload. 
      # 
      # 
      # #### How it works
      # 
      # 
      # 1. Make a DELETE request to this endpoint, replacing `<mediaId>` with the `uploadId` or the `id` of the media you want to delete. 
      # 
      # 2. Since this action is irreversible, ensure that you no longer need the media before proceeding. Once deleted, the media cannot be retrieved or played back. 
      # 
      # 3. Webhook event to look for: <a href="https://docs.fastpix.io/docs/media-events#videomediadeleted">video.media.deleted</a>
      # 
      # #### Example
      # A user on a video-sharing platform decides to remove an old video from their profile, or suppose you're running a content moderation system, and one of the videos uploaded by a user violates your platform's policies. Using this endpoint, the media is permanently deleted from your library, ensuring it's no longer accessible or viewable by other users.
      # 
      request = Models::Operations::DeleteMediaRequest.new(
        media_id: media_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::DeleteMediaRequest,
        base_url,
        '/on-demand/{mediaId}',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'delete-media',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).delete(url) do |req|
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::DeleteMediaResponseBody)
          response = Models::Operations::DeleteMediaResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(request_body: Models::Operations::AddMediaTrackRequestBody, media_id: ::String, retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::AddMediaTrackResponse) }
    def add_media_track(request_body:, media_id:, retries: nil, timeout_ms: nil)
      # add_media_track - Add audio / subtitle track
      # This endpoint allows you to add an audio or subtitle track to an existing media file using its `mediaId`. You need to provide the track `url` along with its `type` (audio or subtitle), `languageName` and `languageCode` in the request payload.
      # 
      # 
      # #### How it works
      # 
      # 1. Send a POST request to this endpoint, replacing `{mediaId}` with the media ID (`uploadId` or `id`).
      # 
      # 2. Provide the necessary details in the request body.
      # 
      # 3. Receive a response containing a unique track ID and the details of the newly added track.
      # 
      # 
      # #### Webhook events
      # 
      # 1. After successfully adding a track, your system will receive the webhook event <a href="https://docs.fastpix.io/docs/transform-media-events#videomediatrackcreated">video.media.track.created</a>.
      # 
      # 2. Once the track is processed and ready, you will receive the webhook event <a href="https://docs.fastpix.io/docs/transform-media-events#videomediatrackready">video.media.track.ready</a>.
      # 
      # 3. Finally, an update event <a href="https://docs.fastpix.io/docs/media-events#videomediaupdated">video.media.updated</a> will notify your system about the media's updated status.
      # 
      # 
      # #### Example
      # Suppose you have a video uploaded to the FastPix platform, and you want to add an Italian audio track to it. By calling this API, you can attach an external audio file (https://static.fastpix.io/music-1.mp3) to the media file. Similarly, if you need to add subtitles in different languages, you can specify type: `subtitle` with the corresponding subtitle `url`, `languageCode` and `languageName`.
      # 
      # Related guides: <a href="https://docs.fastpix.io/docs/manage-subtitle-tracks">Add own subtitle tracks</a>, <a href="https://docs.fastpix.io/docs/manage-audio-tracks">Add own audio tracks</a>
      # 
      request = Models::Operations::AddMediaTrackRequest.new(
        media_id: media_id,
        request_body: request_body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::AddMediaTrackRequest,
        base_url,
        '/on-demand/{mediaId}/tracks',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :request_body, :json)
      headers['content-type'] = req_content_type
      raise StandardError, 'request body is required' if data.nil? && form.nil?

      if form
        body = Utils.encode_form(form)
      elsif Utils.match_content_type(req_content_type, 'application/x-www-form-urlencoded')
        body = URI.encode_www_form(T.cast(data, T::Hash[Symbol, Object]))
      else
        body = data
      end
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'Add-media-track',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).post(url) do |req|
          req.body = body
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['201'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::AddMediaTrackResponseBody)
          response = Models::Operations::AddMediaTrackResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['400'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::TrackDuplicateRequestError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(upload_id: ::String, retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::CancelUploadResponse) }
    def cancel_upload(upload_id:, retries: nil, timeout_ms: nil)
      # cancel_upload - Cancel ongoing upload
      # This endpoint allows you to cancel ongoing upload by its `uploadId`. Once cancelled, the upload will be marked as cancelled. Use this if a user aborts an upload or if you want to programmatically stop an in-progress upload.
      # 
      # #### How it works
      # 
      # 1. Make a PUT request to this endpoint, replacing `{uploadId}` with the unique upload ID received after starting the upload.
      # 2. The response will confirm the cancellation and provide the status of the upload.
      # 
      # #### Webhook Events
      # 
      # Once the upload is cancelled, you will receive the webhook event <a href="https://docs.fastpix.io/docs/media-events#videomediauploadcancelled-event">video.media.upload.cancelled</a>.
      # 
      # #### Example
      # 
      # Suppose a user starts uploading a large video file but decides to cancel before completion. By calling this API, you can immediately stop the upload and free up resources.
      # 
      request = Models::Operations::CancelUploadRequest.new(
        upload_id: upload_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::CancelUploadRequest,
        base_url,
        '/on-demand/upload/{uploadId}/cancel',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'cancel-upload',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).put(url) do |req|
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::CancelUploadResponseBody)
          response = Models::Operations::CancelUploadResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['400'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::BadRequestError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(update_track_request: Models::Components::UpdateTrackRequest, track_id: ::String, media_id: ::String, retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdateMediaTrackResponse) }
    def update_media_track(update_track_request:, track_id:, media_id:, retries: nil, timeout_ms: nil)
      # update_media_track - Update audio / subtitle track
      # This endpoint allows you to update an existing audio or subtitle track associated with a media file. When updating a track, you must provide the new track `url`, `languageName`, and `languageCode`, ensuring all three parameters are included in the request.
      # 
      # 
      # #### How it works
      # 
      # 1. Send a PATCH request to this endpoint, replacing `{mediaId}` with the media ID, and `{trackId}` with the ID of the track you want to update.
      # 
      # 2. Provide the necessary details in the request body.
      # 
      # 3. Receive a response confirming the track update.
      # 
      # #### Webhook Events
      # 
      # After updating a track, your system will receive webhook notifications:
      # 
      # 1. After successfully updating a track, your system will receive the webhook event <a href="https://docs.fastpix.io/docs/transform-media-events#videomediatrackupdated">video.media.track.updated</a>.
      # 
      # 2. Once the new track is processed and ready, you will receive the webhook event <a href="https://docs.fastpix.io/docs/transform-media-events#videomediatrackready">video.media.track.ready</a>.
      # 
      # 3. Once the media file is updated with the new track details, a <a href="https://docs.fastpix.io/docs/media-events#videomediaupdated">video.media.updated</a> event will be triggered.
      # 
      # 
      # #### Example
      # Suppose you previously added a French subtitle track to a video but now need to update it with a different file. By calling this API, you can replace the existing subtitle file (.vtt) with a new one while keeping the same track ID. This is useful when:
      # 
      #   - The original track file has errors and needs correction.
      #   - You want to improve subtitle translations or replace an audio track with a better-quality version.
      #   
      # Related guides: <a href="https://docs.fastpix.io/docs/manage-subtitle-tracks">Add own subtitle tracks</a>, <a href="https://docs.fastpix.io/docs/manage-audio-tracks">Add own audio tracks</a>
      # 
      request = Models::Operations::UpdateMediaTrackRequest.new(
        track_id: track_id,
        media_id: media_id,
        update_track_request: update_track_request
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdateMediaTrackRequest,
        base_url,
        '/on-demand/{mediaId}/tracks/{trackId}',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :update_track_request, :json)
      headers['content-type'] = req_content_type
      raise StandardError, 'request body is required' if data.nil? && form.nil?

      if form
        body = Utils.encode_form(form)
      elsif Utils.match_content_type(req_content_type, 'application/x-www-form-urlencoded')
        body = URI.encode_www_form(T.cast(data, T::Hash[Symbol, Object]))
      else
        body = data
      end
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'update-media-track',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).patch(url) do |req|
          req.body = body
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::UpdateMediaTrackResponseBody)
          response = Models::Operations::UpdateMediaTrackResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['400'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::TrackDuplicateRequestError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(media_id: ::String, track_id: ::String, retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::DeleteMediaTrackResponse) }
    def delete_media_track(media_id:, track_id:, retries: nil, timeout_ms: nil)
      # delete_media_track - Delete audio / subtitle track
      # This endpoint allows you to delete an existing audio or subtitle track from a media file. Once deleted, the track will no longer be available for playback.
      # 
      # 
      # #### How it works
      # 
      # 
      # 1. Send a DELETE request to this endpoint, replacing `{mediaId}` with the media ID, and `{trackId}` with the ID of the track you want to remove.
      # 
      # 2. The track will be deleted from the media file, and you will receive a confirmation response.
      # 
      # #### Webhook events
      # 
      # 1. After successfully deleting a track, your system will receive the webhook event **video.media.track.deleted**.
      # 
      # 2. Once the media file is updated to reflect the track removal, a <a href="https://docs.fastpix.io/docs/media-events#videomediaupdated">video.media.updated</a> event will be triggered.
      # 
      # 
      # #### Example
      # Suppose you uploaded an audio track in Italian for a video but later realize it's incorrect or no longer needed. By calling this API, you can remove the specific track while keeping the rest of the media file unchanged. This is useful when:
      # 
      #   - A track was mistakenly added and needs to be removed.
      #   - The content owner requests the removal of a specific subtitle or audio track.
      #   - A new version of the track will be uploaded to replace the existing one.
      #   
      # Related guides: <a href="https://docs.fastpix.io/docs/manage-subtitle-tracks">Add own subtitle tracks</a>, <a href="https://docs.fastpix.io/docs/manage-audio-tracks">Add own audio tracks</a>
      # 
      request = Models::Operations::DeleteMediaTrackRequest.new(
        media_id: media_id,
        track_id: track_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::DeleteMediaTrackRequest,
        base_url,
        '/on-demand/{mediaId}/tracks/{trackId}',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'delete-media-track',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).delete(url) do |req|
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::DeleteMediaTrackResponseBody)
          response = Models::Operations::DeleteMediaTrackResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(track_subtitles_generate_request: Models::Components::TrackSubtitlesGenerateRequest, media_id: ::String, track_id: ::String, retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::GenerateSubtitleTrackResponse) }
    def generate_subtitle_track(track_subtitles_generate_request:, media_id:, track_id:, retries: nil, timeout_ms: nil)
      # generate_subtitle_track - Generate track subtitle
      # This endpoint allows you to generate subtitles for an existing audio track in a media file. By calling this API, you can generate subtitles automatically using speech recognition
      # 
      # #### How it works
      # 
      # 1. Send a `POST` request to this endpoint, replacing `{mediaId}` with the media ID and `{trackId}` with the track ID.
      # 
      # 2. Provide the necessary details in the request body, including the languageName and languageCode.
      # 
      # 3. Receive a response containing a unique subtitle track ID and its details.
      # 
      # #### Webhook Events
      # 
      # 1. Once the subtitle track is generated and ready, you will receive the webhook event <a href="https://docs.fastpix.io/docs/transform-media-events#videomediasubtitlegeneratedready">video.media.subtitle.generated.ready</a>.
      # 
      # 2. Finally, an update event <a href="https://docs.fastpix.io/docs/media-events#videomediaupdated">video.media.updated</a> will notify your system about the media's updated status.
      # 
      # </br> Related guide: <a href="https://docs.fastpix.io/docs/add-auto-generated-subtitles-to-videos">Add auto-generated subtitles</a>
      # 
      request = Models::Operations::GenerateSubtitleTrackRequest.new(
        media_id: media_id,
        track_id: track_id,
        track_subtitles_generate_request: track_subtitles_generate_request
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::GenerateSubtitleTrackRequest,
        base_url,
        '/on-demand/{mediaId}/tracks/{trackId}/generate-subtitles',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :track_subtitles_generate_request, :json)
      headers['content-type'] = req_content_type
      raise StandardError, 'request body is required' if data.nil? && form.nil?

      if form
        body = Utils.encode_form(form)
      elsif Utils.match_content_type(req_content_type, 'application/x-www-form-urlencoded')
        body = URI.encode_www_form(T.cast(data, T::Hash[Symbol, Object]))
      else
        body = data
      end
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'Generate-subtitle-track',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).post(url) do |req|
          req.body = body
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::GenerateSubtitleTrackResponseBody)
          response = Models::Operations::GenerateSubtitleTrackResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['400'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::TrackDuplicateRequestError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(request_body: Models::Operations::UpdatedSourceAccessRequestBody, media_id: ::String, retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdatedSourceAccessResponse) }
    def updated_source_access(request_body:, media_id:, retries: nil, timeout_ms: nil)
      # updated_source_access - Update the source access of a media by ID
      # This endpoint allows you to update the `sourceAccess` setting of an existing media file. The `sourceAccess` parameter determines whether the original media file is accessible or restricted. Setting this to `true` enables access to the media source, while setting it to `false` restricts access. 
      # 
      # #### How it works
      # 
      # 1. Make a `PATCH` request to this endpoint, replacing `{mediaId}` with the ID of the media you want to update.
      # 
      # 2. Include the updated `sourceAccess` parameter in the request body.
      # 
      # 3. Receive a response confirming the update to the media's source access status.
      # 4. Webhook events: <a href="https://docs.fastpix.io/docs/transform-media-events#videomediasourceready">video.media.source.ready</a>, <a href="https://docs.fastpix.io/docs/transform-media-events#videomediasourcedeleted">video.media.source.deleted</a>
      # 
      request = Models::Operations::UpdatedSourceAccessRequest.new(
        media_id: media_id,
        request_body: request_body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdatedSourceAccessRequest,
        base_url,
        '/on-demand/{mediaId}/source-access',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :request_body, :json)
      headers['content-type'] = req_content_type
      raise StandardError, 'request body is required' if data.nil? && form.nil?

      if form
        body = Utils.encode_form(form)
      elsif Utils.match_content_type(req_content_type, 'application/x-www-form-urlencoded')
        body = URI.encode_www_form(T.cast(data, T::Hash[Symbol, Object]))
      else
        body = data
      end
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'updated-source-access',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).patch(url) do |req|
          req.body = body
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::UpdatedSourceAccessResponseBody)
          response = Models::Operations::UpdatedSourceAccessResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(request_body: Models::Operations::UpdatedMp4SupportRequestBody, media_id: ::String, retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdatedMp4SupportResponse) }
    def updated_mp4_support(request_body:, media_id:, retries: nil, timeout_ms: nil)
      # updated_mp4_support - Update the mp4Support of a media by ID
      # This endpoint allows you to update the `mp4Support` setting of an existing media file using its media ID. You can specify the MP4 support level, such as `none`, `capped_4k`, `audioOnly`, or a combination of `audioOnly`, `capped_4k`, in the request payload.
      # 
      # #### How it works
      # 
      # 1. Send a PATCH request to this endpoint, replacing `{mediaId}` with the media ID.
      # 
      # 2. Provide the desired `mp4Support` value in the request body.
      # 
      # 3. Receive a response confirming the update, including the media's updated MP4 support status.
      # 
      # #### MP4 Support Options
      # 
      # - `none` – MP4 support is disabled for this media.
      # 
      # - `capped_4k` – The media will have mp4 renditions up to 4K resolution.
      # 
      # - `audioOnly` – The media will generate an m4a file containing only the audio track.
      # 
      # - `audioOnly,capped_4k` – The media will have both an audio-only m4a file and mp4 renditions up to 4K resolution.
      # 
      # #### Webhook events
      # 
      # - <a href="https://docs.fastpix.io/docs/transform-media-events#videomediamp4supportready">video.media.mp4Support.ready</a> – Triggered when the MP4 support setting is successfully updated.
      # 
      # #### Example
      # Suppose you have a video uploaded to the FastPix platform, and you want to allow users to download the video in MP4 format. By setting "mp4Support": "capped_4k", the system will generate an MP4 rendition of the video up to 4K resolution, making it available for download via the stream URL(`https://stream.fastpix.io/{playbackId}/{capped-4k.mp4 | audio.m4a}`).
      # If you want users to stream only the audio from the media file, you can set "mp4Support": "audioOnly". This will provide an audio-only stream URL that allows users to listen to the media without video.
      # By setting "mp4Support": "audioOnly,capped_4k", both options will be enabled. Users will be able to download the MP4 video and also stream just the audio version of the media.
      # 
      # 
      # Related guide: <a href="https://docs.fastpix.io/docs/mp4-support-for-offline-viewing">Use MP4 support for offline viewing</a>
      # 
      request = Models::Operations::UpdatedMp4SupportRequest.new(
        media_id: media_id,
        request_body: request_body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdatedMp4SupportRequest,
        base_url,
        '/on-demand/{mediaId}/update-mp4Support',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :request_body, :json)
      headers['content-type'] = req_content_type
      raise StandardError, 'request body is required' if data.nil? && form.nil?

      if form
        body = Utils.encode_form(form)
      elsif Utils.match_content_type(req_content_type, 'application/x-www-form-urlencoded')
        body = URI.encode_www_form(T.cast(data, T::Hash[Symbol, Object]))
      else
        body = data
      end
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'updated-mp4Support',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).patch(url) do |req|
          req.body = body
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::UpdatedMp4SupportResponseBody)
          response = Models::Operations::UpdatedMp4SupportResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['400'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::DuplicateMp4SupportError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(media_id: ::String, retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::RetrieveMediaInputInfoResponse) }
    def retrieve_media_input_info(media_id:, retries: nil, timeout_ms: nil)
      # retrieve_media_input_info - Get info of media inputs
      # Allows you to retrieve detailed information about the media inputs associated with a specific media item. You can use this endpoint to verify the media file's input URL, track creation status, and container format. The `mediaId` (either `uploadId` or `id`) must be provided to fetch the information. 
      # 
      # 
      # #### How it works
      # 
      # Upon making a `GET` request with the mediaId, FastPix returns a response with: 
      # 
      # * The public storage input `url` of the uploaded media file. 
      # 
      # * Information about the `tracks` associated with the media, including both video and audio tracks, indicating whether they have been successfully created. 
      # 
      # * The format of the uploaded media file container (e.g., MP4, MKV). 
      # 
      # This endpoint is particularly useful for ensuring that all necessary tracks (video and audio) have been correctly associated with the media during the upload or media creation process.
      # 
      request = Models::Operations::RetrieveMediaInputInfoRequest.new(
        media_id: media_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::RetrieveMediaInputInfoRequest,
        base_url,
        '/on-demand/{mediaId}/input-info',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'retrieveMediaInputInfo',
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::RetrieveMediaInputInfoResponseBody)
          response = Models::Operations::RetrieveMediaInputInfoResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(limit: T.nilable(::Integer), offset: T.nilable(::Integer), order_by: T.nilable(Models::Components::SortOrder), retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::ListUploadsResponse) }
    def list_uploads(limit: nil, offset: nil, order_by: nil, retries: nil, timeout_ms: nil)
      # list_uploads - Get all unused upload URLs
      # This endpoint retrieves a paginated list of all unused upload signed URLs within your organization. It provides comprehensive metadata including upload IDs, creation dates, status, and URLs, helping you manage your media resources efficiently.
      # 
      # An unused upload URL is a signed URL that gets generated when an user initiates upload but never completed the upload process. This can happen due to reasons like network issues, manual cancellation of upload, browser/app crashes or session timeouts.These URLs remain in the system as "unused" since they were created but never resulted in a successful media file upload.
      # 
      # #### How it works
      # 
      #  - The endpoint returns metadata for all unused upload URLs in your organization's library.
      #  - Results are paginated to manage large datasets effectively.
      #  - Signed URLs expire after 24 hours from creation.
      #  - Each entry includes full metadata about the unused upload.
      # 
      # 
      # 
      # #### Example
      # 
      # A video management team for a media organization regularly uploads content to their system but often forgets to delete or utilize unused uploads. These unused uploads, which have signed URLs that expire after 24 hours, need to be managed efficiently. By using this API, they can retrieve metadata for all unused uploads, identify expired signed URLs, and decide whether to regenerate URLs, reuse the uploads, or delete them.
      # 
      request = Models::Operations::ListUploadsRequest.new(
        limit: limit,
        offset: offset,
        order_by: order_by
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = "#{base_url}/on-demand/uploads"
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::ListUploadsRequest, request, nil)
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'list-uploads',
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::ListUploadsResponseBody)
          response = Models::Operations::ListUploadsResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            object: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end


    sig { params(source_media_id: ::String, offset: T.nilable(::Integer), limit: T.nilable(::Integer), order_by: T.nilable(Models::Components::SortOrder), retries: T.nilable(Utils::RetryConfig), timeout_ms: T.nilable(Integer)).returns(Models::Operations::GetMediaClipsResponse) }
    def get_media_clips(source_media_id:, offset: nil, limit: nil, order_by: nil, retries: nil, timeout_ms: nil)
      # get_media_clips - Get all clips of a media
      # This endpoint retrieves a list of all media clips associated with a given source media ID. It helps in organizing and managing media's efficiently by providing metadata, including clip media IDs and other relevant details.
      # 
      # A media clip is a segmented portion of an original media file (source media). Clips are often created for various purposes such as previews, highlights, or customized edits. This API allows you to fetch all such clips linked to a specific source media, making it easier to track and manage clips.
      # 
      # 
      # #### How it works
      # 
      # - The endpoint returns metadata for all media clips associated with the given `sourceMediaId`.
      # - Results are paginated to efficiently handle large datasets.
      # - Each entry includes detailed metadata such as media `id`, `duration`, and `status`.
      # - Helps in organizing clips effectively by providing structured information.
      # 
      # 
      # #### Example
      # 
      # Imagine you're managing a video editing platform where users upload full-length videos and create short clips for social media sharing. To keep track of all clips linked to a particular video, you call this API with the sourceMediaId. The response provides a list of all associated clips, allowing you to manage, edit, or repurpose them as needed.
      # 
      # Related guide: <a href="https://docs.fastpix.io/docs/create-clips-from-existing-media">Create clips from existing media</a>
      # 
      request = Models::Operations::GetMediaClipsRequest.new(
        source_media_id: source_media_id,
        offset: offset,
        limit: limit,
        order_by: order_by
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::GetMediaClipsRequest,
        base_url,
        '/on-demand/{sourceMediaId}/media-clips',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::GetMediaClipsRequest, request, nil)
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent
      retries ||= @sdk_configuration.retry_config
      retries ||= Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.5,
          initial_interval: 1000,
          max_elapsed_time: 3_600_000,
          max_interval: 10_000
        ),
        retry_connection_errors: true,
        strategy: 'backoff'
      )
      retry_options = retries.to_faraday_retry_options(initial_time: Time.now)
      retry_options[:retry_statuses] = [408, 429, 500, 502, 503, 504]

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client.dup
      connection.request :retry, retry_options

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'get-media-clips',
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
          raise error if !error.nil?
          raise 'no response'
        end
      end
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['200'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::MediaClipResponse)
          response = Models::Operations::GetMediaClipsResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            media_clip_response: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['401'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::InvalidPermissionError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['403'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ForbiddenError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['404'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::MediaClipNotFoundError)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['422'])
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Errors::ValidationErrorResponse)
          obj.raw_response = http_response
          raise obj
        else
          raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        raise ::FastpixApiSDK::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown status code received'

      end
    end
  end
end
