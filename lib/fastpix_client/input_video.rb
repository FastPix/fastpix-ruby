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
  class InputVideo
    extend T::Sig

    API_ERROR_OCCURRED = 'API error occurred'
    CONTENT_TYPE_JSON = 'application/json'
    UNKNOWN_CONTENT_TYPE_ERROR = 'Unknown content type received'

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
    
    # Operations for inputting and creating video media

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


    sig { params(request: Models::Components::CreateMediaRequest, timeout_ms: T.nilable(Integer)).returns(Models::Operations::CreateMediaResponse) }
    def create_media(request:, timeout_ms: nil)
      # create_media - Create media from URL
      # This endpoint allows developers or users to create a new video or audio media in FastPix using a publicly accessible URL. FastPix fetches the media from the provided URL, processes it, and stores it on the platform for use.
      # 
      # 
      # 
      # #### Public URL requirement:
      # 
      # 
      #   The provided URL must be publicly accessible and must point to a video stored in one of the following supported formats: .m4v, .ogv, .mpeg, .mov, .3gp, .f4v, .rm, .ts, .wtv, .avi, .mp4, .wmv, .webm, .mts, .vob, .mxf, asf, m2ts 
      # 
      # 
      # 
      # #### Supported storage types:
      # 
      # The URL can originate from various cloud storage services or content delivery networks (CDNs) such as: 
      # 
      # 
      # * **Amazon S3:** URLs from Amazon's Simple Storage Service. 
      # 
      # * **Google Cloud Storage:** URLs from Google Cloud's storage solution. 
      # 
      # * **Azure Blob Storage:** URLs from Microsoft's Azure storage. 
      # 
      # * **Public CDNs:** URLs from public content delivery networks that host video files. 
      # 
      # Upon successful creation, the API returns an `id` that must be retained for future operations related to this media. 
      # 
      # #### How it works
      # 
      # 
      # 1. Send a POST request to this endpoint with the media URL (typically a video or audio file) and optional media settings. 
      # 
      # 2. FastPix uploads the video from the provided URL to its storage. 
      # 
      # 3. Receive a response containing the unique id for the newly created media item. 
      # 
      # 4. Use the id in subsequent API calls, such as checking the status of the media with the <a href="https://fastpix.com/docs/video-on-demand-api/manage-videos/get-media">Get Media by ID</a> endpoint to determine when the media is ready for playback. 
      # 
      # FastPix uses webhooks to tell your application about things that happen in the background, outside of the API regular request flow. For instance, after the media file is created (but not yet processed or encoded), FastPix sends a `POST` request to your specified webhook URL with the event <a href="https://fastpix.com/docs/vod-events/media-events#videomediacreated">video.media.created</a>. 
      # 
      # 
      # After processing completes, monitor the events <a href="https://fastpix.com/docs/vod-events/media-events#videomediaready">video.media.ready</a> and <a href="https://fastpix.com/docs/vod-events/media-events#videomediafailed">video.media.failed</a> to track the status of the media file.
      # 
      # Related guide: <a href="https://fastpix.com/docs/upload-videos/upload-videos-from-a-url">Upload videos from URL</a>
      # 
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = "#{base_url}/on-demand"
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :request, :json)
      headers['content-type'] = req_content_type
      body = encode_request_body(req_content_type, data, form)
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
        operation_id: 'create-media',
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
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['201'])
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::CreateMediaSuccessResponse)
          response = Models::Operations::CreateMediaResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            create_media_success_response: T.unsafe(obj)
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
          response = Models::Operations::CreateMediaResponse.new(
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


    sig { params(request: Models::Operations::DirectUploadVideoMediaRequest, timeout_ms: T.nilable(Integer)).returns(Models::Operations::DirectUploadVideoMediaResponse) }
    def direct_upload_video_media(request:, timeout_ms: nil)
      # direct_upload_video_media - Upload media from device
      # This endpoint enables accelerated uploads of large media files directly from your local device to FastPix for processing and storage.
      # 
      # > **NOTE**
      # >
      # > This version now supports uploads with no file size limitations and offers faster uploads. The previous endpoint (which had a 500MB size limit) is now deprecated. You can find details in the [changelog](https://fastpix.com/docs/changelog/release-notes).
      # 
      # #### How it works
      # 
      # 1. Send a POST request to this endpoint with optional media settings.  
      # 
      # 2. The response includes an `uploadId` and a signed `url` for direct video file upload.
      # 
      # 3. Upload your video file to the provided url by making a PUT request. The API accepts the media file from your device and uploads it to the FastPix platform. (Refer to <a href="https://fastpix.com/docs/upload-videos/upload-videos-from-device#step-3-initiate-the-upload">Step 3: Initiate the upload</a> for complete instructions.)
      # 
      # 
      # 4. Once uploaded, the media undergoes processing and is assigned a unique ID for tracking. Retain this `uploadId` for any future operations related to this upload. 
      # 
      # 
      # 
      # After uploading, you can use the <a href="https://fastpix.com/docs/video-on-demand-api/manage-videos/get-media">Get Media by ID</a> endpoint to check the status of the uploaded media asset and see if it has transitioned to a `Ready` status for playback. 
      # 
      # To notify your application about the status of this API request check for the webhooks for <a href="https://fastpix.com/docs/webhooks/webhook-event-reference#media-related-events">media related events</a>.  
      # 
      # 
      # #### Example
      # 
      # A social media platform allows users to upload video content directly from their phones or computers. This endpoint facilitates the upload process. For example, if you are developing a video-sharing app where users can upload short clips from their mobile devices, this endpoint enables them to select a video, upload it to the platform.
      # 
      # Related guide: <a href="https://fastpix.com/docs/upload-videos/upload-videos-from-device">Upload videos directly</a>
      # 
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = "#{base_url}/on-demand/upload"
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :request, :json)
      headers['content-type'] = req_content_type
      body = encode_request_body(req_content_type, data, form)
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
        operation_id: 'direct-upload-video-media',
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
      
      content_type = http_response.headers.fetch('Content-Type', 'application/octet-stream')
      if Utils.match_status_code(http_response.status, ['201'])
        if Utils.match_content_type(content_type, CONTENT_TYPE_JSON)
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Operations::DirectUploadVideoMediaResponseBody)
          response = Models::Operations::DirectUploadVideoMediaResponse.new(
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
          response = Models::Operations::DirectUploadVideoMediaResponse.new(
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
