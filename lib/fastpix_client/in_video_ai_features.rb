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
  class InVideoAIFeatures
    extend T::Sig

    API_ERROR_OCCURRED = 'API error occurred'
    CONTENT_TYPE_HEADER = 'Content-Type'
    CONTENT_TYPE_JSON = 'application/json'
    DEFAULT_CONTENT_TYPE = 'application/octet-stream'
    REQUEST_CONTENT_TYPE_HEADER = 'content-type'
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
        raise 'no response'
      end

      http_response
    end
    private :apply_after_request_hooks

    # Encodes the request body based on its serialized content type.
    sig { params(req_content_type: T.nilable(String), data: T.untyped, form: T.untyped).returns(T.untyped) }
    def encode_request_body(req_content_type, data, form)
      raise StandardError, 'request body is required' if data.nil? && form.nil?

      if form
        Utils.encode_form(form)
      elsif Utils.match_content_type(req_content_type, 'application/x-www-form-urlencoded')
        URI.encode_www_form(T.cast(data, T::Hash[Symbol, Object]))
      else
        data
      end
    end
    private :encode_request_body
    
    # Operations for AI-powered video features

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


    sig { params(body: Models::Operations::UpdateMediaSummaryRequestBody, media_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdateMediaSummaryResponse) }
    def update_media_summary(body:, media_id:, timeout_ms: nil)
      # update_media_summary - Generate video summary
      # This endpoint allows you to generate the summary for an existing media.
      # 
      # #### How it works
      # 1. Send a `PATCH` request to this endpoint, replacing `<mediaId>` with the ID of the media you want to summarize.
      # 2. Include the `generate` parameter in the request body.
      # 3. Include the `summaryLength` parameter, specify the desired length of the summary in words (for example, 120 words), this determines how concise or detailed the summary will be. If no specific summary length is provided, the default length will be 100 words.
      # 4. The response includes the updated media data and confirmation of the changes applied.
      # 
      # You can use the <a href="https://fastpix.com/docs/ai-events/in-video-ai-events#videomediaaisummaryready">video.mediaAI.summary.ready</a> webhook event to track and notify about the summary generation.
      # 
      # 
      # 
      # 
      # 
      # **Use case**: This is particularly useful when a user uploads a video and later chooses to generate a summary without needing to re-upload the video.
      # 
      # Related guide: <a href="https://fastpix.com/docs/video-intelligence/generate-a-video-summary">Video summary</a>
      # 
      request = Models::Operations::UpdateMediaSummaryRequest.new(
        media_id: media_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdateMediaSummaryRequest,
        base_url,
        '/on-demand/{mediaId}/summary',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :body, :json)
      headers[REQUEST_CONTENT_TYPE_HEADER] = req_content_type
      body = encode_request_body(req_content_type, data, form)
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
        operation_id: 'update-media-summary',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::UpdateMediaSummaryResponseBody)
          response = Models::Operations::UpdateMediaSummaryResponse.new(
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
          response = Models::Operations::UpdateMediaSummaryResponse.new(
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


    sig { params(body: Models::Operations::UpdateMediaChaptersRequestBody, media_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdateMediaChaptersResponse) }
    def update_media_chapters(body:, media_id:, timeout_ms: nil)
      # update_media_chapters - Generate video chapters
      # This endpoint enables you to generate chapters for an existing media file.
      # 
      # #### How it works
      # 1. Make a `PATCH` request to this endpoint, replacing `<mediaId>` with the ID of the media for which you want to generate chapters.
      # 2. Include the `chapters` parameter in the request body to enable.
      # 3. The response contains the updated media data, confirming the changes made.
      # 
      # You can use the <a href="https://fastpix.com/docs/ai-events/in-video-ai-events#videomediaaichaptersready">video.mediaAI.chapters.ready</a> webhook event to track and notify about the chapters generation.
      # 
      # **Use case:** This is particularly useful when a user uploads a video and later decides to enable chapters without re-uploading the entire video.
      # 
      # Related guide: <a href="https://fastpix.com/docs/video-intelligence/generate-video-chapters">Video chapters</a>
      # 
      request = Models::Operations::UpdateMediaChaptersRequest.new(
        media_id: media_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdateMediaChaptersRequest,
        base_url,
        '/on-demand/{mediaId}/chapters',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :body, :json)
      headers[REQUEST_CONTENT_TYPE_HEADER] = req_content_type
      body = encode_request_body(req_content_type, data, form)
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
        operation_id: 'update-media-chapters',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::UpdateMediaChaptersResponseBody)
          response = Models::Operations::UpdateMediaChaptersResponse.new(
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
          response = Models::Operations::UpdateMediaChaptersResponse.new(
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


    sig { params(body: Models::Operations::UpdateMediaNamedEntitiesRequestBody, media_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdateMediaNamedEntitiesResponse) }
    def update_media_named_entities(body:, media_id:, timeout_ms: nil)
      # update_media_named_entities - Generate named entities
      # This endpoint allows you to extract named entities from an existing media.
      # Named Entity Recognition (NER) is a fundamental natural language processing (NLP) technique that identifies and classifies key information (entities) in text into predefined categories. For instance:
      # 
      #   - Organizations (for example, "Microsoft", "United Nations")
      #   - Locations (for example, "Paris", "Mount Everest")
      #   - Product names (for example, "iPhone", "Coca-Cola")
      # 
      # #### How it works
      # 1. Make a PATCH request to this endpoint, replacing `<mediaId>` with the ID of the media you want to extract named-entities.
      # 2. Include the `namedEntities` parameter in the request body to enable.
      # 3. Receive a response containing the updated media data, confirming the changes made.
      # 
      # You can use the <a href="https://fastpix.com/docs/ai-events/in-video-ai-events#videomediaainamedentitiesready">video.mediaAI.named-entities.ready</a> webhook event to track and notify about the named entities extraction.
      # 
      # **Use case:** If a user uploads a video and later decides to enable named entity extraction without re-uploading the entire video.
      # 
      # Related guide: <a href="https://fastpix.com/docs/video-intelligence/extract-named-entities-from-a-video">Named entities</a>
      # 
      request = Models::Operations::UpdateMediaNamedEntitiesRequest.new(
        media_id: media_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdateMediaNamedEntitiesRequest,
        base_url,
        '/on-demand/{mediaId}/named-entities',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :body, :json)
      headers[REQUEST_CONTENT_TYPE_HEADER] = req_content_type
      body = encode_request_body(req_content_type, data, form)
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
        operation_id: 'update-media-named-entities',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::UpdateMediaNamedEntitiesResponseBody)
          response = Models::Operations::UpdateMediaNamedEntitiesResponse.new(
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
          response = Models::Operations::UpdateMediaNamedEntitiesResponse.new(
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


    sig { params(body: Models::Operations::UpdateMediaModerationRequestBody, media_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdateMediaModerationResponse) }
    def update_media_moderation(body:, media_id:, timeout_ms: nil)
      # update_media_moderation - Enable video moderation
      # This endpoint enables moderation features, such as NSFW and profanity filtering, to detect inappropriate content in existing media.
      # 
      # #### How it works
      # 1. Make a `PATCH` request to this endpoint, replacing `<mediaId>` with the ID of the media you want to update.
      # 2. Include the `moderation` object and provide the requried `type` parameter in the request body to specify the media type (for example, video/audio/av).
      # 4. The response contains the updated media data, confirming the changes made.
      # 
      # You can use the <a href="https://fastpix.com/docs/ai-events/in-video-ai-events#videomediaaimoderationready">video.mediaAI.moderation.ready</a> webhook event to track and notify about the detected moderation results.
      # 
      # **Use case:** This is particularly useful when a user uploads a video and later decides to enable moderation detection without the need to re-upload it.
      # 
      # Related guide: <a href="https://fastpix.com/docs/video-intelligence/detect-nsfw-content-and-profanity">Moderate NSFW & Profanity</a>
      # 
      request = Models::Operations::UpdateMediaModerationRequest.new(
        media_id: media_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdateMediaModerationRequest,
        base_url,
        '/on-demand/{mediaId}/moderation',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :body, :json)
      headers[REQUEST_CONTENT_TYPE_HEADER] = req_content_type
      body = encode_request_body(req_content_type, data, form)
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
        operation_id: 'update-media-moderation',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::UpdateMediaModerationResponseBody)
          response = Models::Operations::UpdateMediaModerationResponse.new(
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
          response = Models::Operations::UpdateMediaModerationResponse.new(
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
