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
  class SimulcastStream
    extend T::Sig

    API_ERROR_OCCURRED = 'API error occurred'
    CONTENT_TYPE_HEADER = 'Content-Type'
    CONTENT_TYPE_JSON = 'application/json'
    DEFAULT_CONTENT_TYPE = 'application/octet-stream'
    SIMULCAST_PATH = '/live/streams/{streamId}/simulcast/{simulcastId}'
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
        raise StandardError, 'no response'
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
    
    # Operations for simulcast stream management

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


    sig { params(body: Models::Components::SimulcastRequest, stream_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::CreateSimulcastOfStreamResponse) }
    def create_simulcast_of_stream(body:, stream_id:, timeout_ms: nil)
      # create_simulcast_of_stream - Create a simulcast
      # Creates a simulcast for a parent live stream. Simulcasting allows you to broadcast a live stream to multiple social platforms simultaneously (for example, YouTube, Facebook, or Twitch). This helps expand your audience reach across platforms. A simulcast can only be created when the parent live stream is in the idle state (not currently live or disabled). Only one simulcast target can be created per API call. 
      # #### How it works
      # 
      # 1. Change to: When you call this endpoint, provide the parent `streamId` along with the simulcast target details (such as platform and credentials). The API returns a unique `simulcastId`, which you can use to manage the simulcast later.  
      # 
      # 2. To notify your application about the status of simulcast related events check for the <a href="https://fastpix.com/docs/webhooks/webhook-event-reference#simulcast-target-events">webhooks for simulcast</a> target events. 
      # 
      # #### Example
      # An event manager sets up a live stream for a virtual conference and wants to simulcast the stream on YouTube and Facebook Live. They first create the primary live stream in FastPix, ensuring it's in the idle state. Then, they use the API to create a simulcast target for YouTube. 
      # 
      # Related guide: <a href="https://fastpix.com/docs/edit-and-transform-live-stream/simulcast-to-multiple-platforms">Simulcast to 3rd party platforms</a>
      request = Models::Operations::CreateSimulcastOfStreamRequest.new(
        stream_id: stream_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::CreateSimulcastOfStreamRequest,
        base_url,
        '/live/streams/{streamId}/simulcast',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :body, :json)
      headers['content-type'] = req_content_type
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
        operation_id: 'create-simulcast-of-stream',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::SimulcastResponse)
          response = Models::Operations::CreateSimulcastOfStreamResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            simulcast_response: T.unsafe(obj)
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
          response = Models::Operations::CreateSimulcastOfStreamResponse.new(
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


    sig { params(stream_id: ::String, simulcast_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::DeleteSimulcastOfStreamResponse) }
    def delete_simulcast_of_stream(stream_id:, simulcast_id:, timeout_ms: nil)
      # delete_simulcast_of_stream - Delete a simulcast
      # Deletes a simulcast using its unique simulcastId, which you received during the simulcast creation process. Deleting a simulcast stops the broadcast to the associated platform, while the parent stream continues if it’s live. This action can’t be undone, and you must create a new simulcast to resume streaming to the same platform.
      # 
      # Webhook event: <a href="https://fastpix.com/docs/live-stream-events/live-events#videolive_streamsimulcast_targetdeleted">video.live_stream.simulcast_target.deleted</a>
      # 
      # 
      # #### Example
      # A broadcaster may need to stop simulcasting to one platform while keeping the stream active on others. For example, a tech company is simulcasting a product launch across multiple platforms. Midway through the event, they decide to stop the simulcast on Facebook due to performance issues but continue streaming on YouTube. They use this API to delete the Facebook simulcast target. 
      request = Models::Operations::DeleteSimulcastOfStreamRequest.new(
        stream_id: stream_id,
        simulcast_id: simulcast_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::DeleteSimulcastOfStreamRequest,
        base_url,
        SIMULCAST_PATH,
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
        operation_id: 'delete-simulcast-of-stream',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::SimulcastdeleteResponse)
          response = Models::Operations::DeleteSimulcastOfStreamResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            simulcastdelete_response: T.unsafe(obj)
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
          response = Models::Operations::DeleteSimulcastOfStreamResponse.new(
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


    sig { params(stream_id: ::String, simulcast_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::GetSpecificSimulcastOfStreamResponse) }
    def get_specific_simulcast_of_stream(stream_id:, simulcast_id:, timeout_ms: nil)
      # get_specific_simulcast_of_stream - Get a specific simulcast
      # Retrieves the details of a specific simulcast associated with a parent live stream. By providing both the `streamId` of the parent stream and the `simulcastId`, FastPix returns detailed information about the simulcast, such as the stream URL, the status of the simulcast, and metadata. 
      # 
      # #### Example
      # This endpoint can be used to verify the status of the simulcast on external platforms before the live stream begins. For example, before starting a live gaming event, the organizer wants to ensure that the simulcast to Twitch is set up correctly. They retrieve the simulcast information to confirm that everything is properly configured.
      request = Models::Operations::GetSpecificSimulcastOfStreamRequest.new(
        stream_id: stream_id,
        simulcast_id: simulcast_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::GetSpecificSimulcastOfStreamRequest,
        base_url,
        SIMULCAST_PATH,
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
        operation_id: 'get-specific-simulcast-of-stream',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::SimulcastResponse)
          response = Models::Operations::GetSpecificSimulcastOfStreamResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            simulcast_response: T.unsafe(obj)
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
          response = Models::Operations::GetSpecificSimulcastOfStreamResponse.new(
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


    sig { params(body: Models::Components::SimulcastUpdateRequest, stream_id: ::String, simulcast_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdateSpecificSimulcastOfStreamResponse) }
    def update_specific_simulcast_of_stream(body:, stream_id:, simulcast_id:, timeout_ms: nil)
      # update_specific_simulcast_of_stream - Update a simulcast
      # Updates the status of a specific simulcast linked to a parent live stream. You can enable or disable the simulcast at any time while the parent stream is active or idle. After the live stream is disabled, the simulcast can no longer be modified.
      # 
      # Webhook event: <a href="https://fastpix.com/docs/live-stream-events/live-events#videolive_streamsimulcast_targetupdated">video.live_stream.simulcast_target.updated</a>
      # 
      # #### Example
      # When a `PATCH` request is made to this endpoint, the API updates the status of the simulcast. This can be useful for pausing or resuming a simulcast on a particular platform without stopping the parent live stream.
      request = Models::Operations::UpdateSpecificSimulcastOfStreamRequest.new(
        stream_id: stream_id,
        simulcast_id: simulcast_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdateSpecificSimulcastOfStreamRequest,
        base_url,
        SIMULCAST_PATH,
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :body, :json)
      headers['content-type'] = req_content_type
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
        operation_id: 'update-specific-simulcast-of-stream',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).put(url) do |req|
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::SimulcastUpdateResponse)
          response = Models::Operations::UpdateSpecificSimulcastOfStreamResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            simulcast_update_response: T.unsafe(obj)
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
          response = Models::Operations::UpdateSpecificSimulcastOfStreamResponse.new(
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
