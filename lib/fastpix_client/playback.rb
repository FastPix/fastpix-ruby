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
  class Playback
    extend T::Sig

    API_ERROR_OCCURRED = 'API error occurred'
    CONTENT_TYPE_HEADER = 'Content-Type'
    CONTENT_TYPE_JSON = 'application/json'
    DEFAULT_CONTENT_TYPE = 'application/octet-stream'
    PLAYBACK_IDS_PATH = '/on-demand/{mediaId}/playback-ids'
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
        raise RuntimeError, 'no response'
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
    
    # Operations for video playback management

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


    sig { params(body: Models::Operations::CreateMediaPlaybackIdRequestBody, media_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::CreateMediaPlaybackIdResponse) }
    def create_media_playback_id(body:, media_id:, timeout_ms: nil)
      # create_media_playback_id - Create a playback ID
      # You can create a new playback ID for a specific media asset. If you have already retrieved an existing `playbackId` using the <a href="https://fastpix.com/docs/video-on-demand-api/manage-videos/get-media">Get Media by ID</a> endpoint for a media asset, you can use this endpoint to generate a new playback ID with a specified access policy. 
      # 
      # 
      # 
      # If you want to create a private playback ID for a media asset that already has a public playback ID, this endpoint also allows you to do so by specifying the desired access policy. 
      # 
      # #### How it works
      # 
      # 1. Make a `POST` request to this endpoint, replacing `<mediaId>` with the `uploadId` or `id` of the media asset. 
      # 
      # 2. Include the `accessPolicy` in the request body with `private` or `public` as the value. 
      # 
      # 3. You receive a response containing the newly created playback ID with the specified access level.
      # 
      # 
      # #### Example
      # A video streaming service generates playback IDs for each media file when users request to view specific content. The video player then uses the playback ID to stream the video.
      # 
      request = Models::Operations::CreateMediaPlaybackIdRequest.new(
        media_id: media_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::CreateMediaPlaybackIdRequest,
        base_url,
        PLAYBACK_IDS_PATH,
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
        operation_id: 'create-media-playback-id',
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
        http_response = apply_after_request_hooks(http_response, error, hook_ctx)
      end
      
      content_type = http_response.headers.fetch(CONTENT_TYPE_HEADER, DEFAULT_CONTENT_TYPE)
      if Utils.match_status_code(http_response.status, ['201'])
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::CreateMediaPlaybackIdResponseBody)
          response = Models::Operations::CreateMediaPlaybackIdResponse.new(
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
          response = Models::Operations::CreateMediaPlaybackIdResponse.new(
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


    sig { params(media_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::ListPlaybackIdsResponse) }
    def list_playback_ids(media_id:, timeout_ms: nil)
      # list_playback_ids - Get all playback IDs details for a media
      # Retrieves all playback IDs associated with a given media asset, including each playback ID’s access policy and detailed access restrictions such as allowed or denied domains and user agents.
      # 
      # **How it works:**
      # 1. Send a `GET` request to this endpoint with the target `mediaId`.
      # 2. The response includes an array of playback ID records with their respective access controls.
      # 
      # **Use case:**
      # Useful for validating and managing playback permissions programmatically, reviewing restriction settings, or powering an access control dashboard.
      # 
      request = Models::Operations::ListPlaybackIdsRequest.new(
        media_id: media_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::ListPlaybackIdsRequest,
        base_url,
        PLAYBACK_IDS_PATH,
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
        operation_id: 'list-playback-ids',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::ListPlaybackIdsResponseBody)
          response = Models::Operations::ListPlaybackIdsResponse.new(
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
          response = Models::Operations::ListPlaybackIdsResponse.new(
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


    sig { params(media_id: ::String, playback_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::DeleteMediaPlaybackIdResponse) }
    def delete_media_playback_id(media_id:, playback_id:, timeout_ms: nil)
      # delete_media_playback_id - Delete a playback ID
      # This endpoint deletes a specific playback ID associated with a media asset. Deleting a `playback ID` revokes access to the media content linked to that ID.
      # 
      # 
      # #### How it works
      # 
      # 1. Make a `DELETE` request to this endpoint, replacing `<mediaId>` with the unique ID of the media asset from which you want to delete the playback ID. 
      # 
      # 2. Include the `playbackId` you want to delete in the request body.
      # 
      # #### Example
      # 
      # Your platform offers limited-time access to premium content. When the subscription expires, you can revoke access to the content by deleting the associated playback ID, preventing users from streaming the video further.
      # 
      request = Models::Operations::DeleteMediaPlaybackIdRequest.new(
        media_id: media_id,
        playback_id: playback_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::DeleteMediaPlaybackIdRequest,
        base_url,
        PLAYBACK_IDS_PATH,
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::DeleteMediaPlaybackIdRequest, request, nil)
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
        operation_id: 'delete-media-playback-id',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).delete(url) do |req|
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::DeleteMediaPlaybackIdResponseBody)
          response = Models::Operations::DeleteMediaPlaybackIdResponse.new(
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
          response = Models::Operations::DeleteMediaPlaybackIdResponse.new(
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


    sig { params(media_id: ::String, playback_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::GetPlaybackIdResponse) }
    def get_playback_id(media_id:, playback_id:, timeout_ms: nil)
      # get_playback_id - Get a playback ID
      # This endpoint retrieves details about a specific playback ID associated with a media asset. Use it to check the access policy for that specific playback ID, such as whether it is public or private.
      # 
      # **How it works:**
      # 1. Make a GET request to the endpoint, replacing `{mediaId}` with the media ID and `{playbackId}` with the playback ID.
      # 2. This request is useful for auditing or validation before granting playback access in your application.
      # 
      # **Example:**
      # A media platform might use this endpoint to verify if a playback ID is public or private before embedding the video in a frontend player or allowing access to a restricted group.
      # 
      request = Models::Operations::GetPlaybackIdRequest.new(
        media_id: media_id,
        playback_id: playback_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::GetPlaybackIdRequest,
        base_url,
        '/on-demand/{mediaId}/playback-ids/{playbackId}',
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
        operation_id: 'get-playback-id',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::GetPlaybackIdResponseBody)
          response = Models::Operations::GetPlaybackIdResponse.new(
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
          response = Models::Operations::GetPlaybackIdResponse.new(
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


    sig { params(body: Models::Operations::UpdateDomainRestrictionsRequestBody, media_id: ::String, playback_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdateDomainRestrictionsResponse) }
    def update_domain_restrictions(body:, media_id:, playback_id:, timeout_ms: nil)
      # update_domain_restrictions - Update domain restrictions for a playback ID
      # This endpoint updates domain-level restrictions for a specific playback ID associated with a media asset.
      # It allows you to restrict playback to specific domains or block known unauthorized domains.
      # 
      # **How it works:**
      # 1. Make a `PATCH` request to this endpoint with your desired domain access configuration.
      # 2. Set a default policy (`allow` or `deny`) and specify domain names in the `allow` or `deny` lists.
      # 3. This is commonly used to restrict video playback to your website or approved client domains.
      # 
      # **Example:**
      # A streaming service can allow playback only from `example.com` and deny all others by setting: `"defaultPolicy": "deny"` and `"allow": ["example.com"]`.
      # 
      request = Models::Operations::UpdateDomainRestrictionsRequest.new(
        media_id: media_id,
        playback_id: playback_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdateDomainRestrictionsRequest,
        base_url,
        '/on-demand/{mediaId}/playback-ids/{playbackId}/domains',
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
        operation_id: 'update-domain-restrictions',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::UpdateDomainRestrictionsResponseBody)
          response = Models::Operations::UpdateDomainRestrictionsResponse.new(
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
          response = Models::Operations::UpdateDomainRestrictionsResponse.new(
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


    sig { params(body: Models::Operations::UpdateUserAgentRestrictionsRequestBody, media_id: ::String, playback_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdateUserAgentRestrictionsResponse) }
    def update_user_agent_restrictions(body:, media_id:, playback_id:, timeout_ms: nil)
      # update_user_agent_restrictions - Update user-agent restrictions for a playback ID
      # This endpoint allows updating user-agent restrictions for a specific playback ID associated with a media asset. 
      # It can be used to allow or deny specific user-agents during playback request evaluation.
      # 
      # **How it works:**
      # 1. Make a `PATCH` request to this endpoint with your desired user-agent access configuration.
      # 2. Specify a default policy (`allow` or `deny`) and provide specific `allow` or `deny` lists.
      # 3. Use this to restrict access to specific browsers, devices, or bots.
      # 
      # **Example:**
      # A developer may configure a playback ID to deny access from known scraping user-agents while allowing all others by default.
      # 
      request = Models::Operations::UpdateUserAgentRestrictionsRequest.new(
        media_id: media_id,
        playback_id: playback_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdateUserAgentRestrictionsRequest,
        base_url,
        '/on-demand/{mediaId}/playback-ids/{playbackId}/user-agents',
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
        operation_id: 'update-user-agent-restrictions',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::UpdateUserAgentRestrictionsResponseBody)
          response = Models::Operations::UpdateUserAgentRestrictionsResponse.new(
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
          response = Models::Operations::UpdateUserAgentRestrictionsResponse.new(
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
