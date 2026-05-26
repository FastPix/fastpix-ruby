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
  class Playlist
    extend T::Sig
    
    # Operations for playlist management

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


    sig { params(request: T.any(Models::Components::CreatePlaylistRequestManual, Models::Components::CreatePlaylistRequestSmart), timeout_ms: T.nilable(Integer)).returns(Models::Operations::CreateAPlaylistResponse) }
    def create_a_playlist(request:, timeout_ms: nil)
      # create_a_playlist - Create a new playlist
      # This endpoint creates a new playlist within a specified workspace. A playlist acts as a container for organizing media items either manually or based on filters and metadata. <br> <br>
      # ### Playlists can be created in two modes
      # - **Manual:** Creates an empty playlist without any initial media items. Use this mode for manual curation, where you add items later in a user-defined sequence.
      # - **Smart:** Auto-populates the playlist at creation time based on the filter criteria (for example, a video creation date range) that you provide in the request.
      # 
      # For more details, see <a href="https://fastpix.com/docs/playback-and-delivery/create-and-manage-playlists">Create and manage playlist</a>.
      # 
      # #### How it works 
      # 
      #  - When you send a `POST` request to this endpoint, FastPix creates a playlist and returns a playlist ID, using which items can be added later in a user-defined sequence.
      #  - You can create a smart playlist that is auto-populated based on the metadata in the request body.
      # 
      # 
      # #### Example
      # An e-learning platform creates a new playlist titled Beginner Python Series through the API. The response returns a unique playlist ID. The platform uses this ID to add a series of video tutorials to the playlist in a defined order. The playlist appears on the frontend as a structured learning path for learners.
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = "#{base_url}/on-demand/playlists"
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :request, :json)
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

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'create-a-playlist',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::PlaylistCreatedResponse)
          response = Models::Operations::CreateAPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            playlist_created_response: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::CreateAPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      end
    end


    sig { params(limit: T.nilable(::Integer), offset: T.nilable(::Integer), timeout_ms: T.nilable(Integer)).returns(Models::Operations::GetAllPlaylistsResponse) }
    def get_all_playlists(limit: nil, offset: nil, timeout_ms: nil)
      # get_all_playlists - Get all playlists
      # This endpoint retrieves all playlists in a specified workspace. It allows you to view the collection of manual and smart playlists along with their associated metadata.
      # #### How it works
      # 
      #  - When a user sends a GET request to this endpoint, FastPix returns a list of all playlists in the workspace, including details such as playlist IDs, titles, creation mode (manual or smart), and other relevant metadata.
      # 
      # #### Example
      # 
      #   An e-learning platform requests all playlists within a workspace to display an overview of available learning paths. The response includes multiple playlists like "Beginner Python Series" and "Advanced Java Tutorials," enabling the platform to show users a catalog of curated content collections.
      request = Models::Operations::GetAllPlaylistsRequest.new(
        limit: limit,
        offset: offset
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = "#{base_url}/on-demand/playlists"
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      query_params = Utils.get_query_params(Models::Operations::GetAllPlaylistsRequest, request, nil)
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'get-all-playlists',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::GetAllPlaylistsResponse)
          response = Models::Operations::GetAllPlaylistsResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            get_all_playlists_response: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::GetAllPlaylistsResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      end
    end


    sig { params(playlist_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::GetPlaylistByIdResponse) }
    def get_playlist_by_id(playlist_id:, timeout_ms: nil)
      # get_playlist_by_id - Get a playlist by ID
      # This endpoint retrieves detailed information about a specific playlist using its unique `playlistId`. It provides comprehensive metadata about the playlist, including its title, creation mode (manual or smart), media items along with the metadata of each media in the playlist.
      # 
      # 
      # #### Example
      # An e-learning platform requests details for the playlist "Beginner Python Series" by providing its unique `playlistId`. The response includes the playlist"s title, creation mode, and the ordered list of video tutorials contained within, enabling the platform to present the full learning path to users.
      request = Models::Operations::GetPlaylistByIdRequest.new(
        playlist_id: playlist_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::GetPlaylistByIdRequest,
        base_url,
        '/on-demand/playlists/{playlistId}',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'get-playlist-by-id',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::PlaylistByIdResponse)
          response = Models::Operations::GetPlaylistByIdResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            playlist_by_id_response: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::GetPlaylistByIdResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      end
    end


    sig { params(body: Models::Components::UpdatePlaylistRequest, playlist_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::UpdateAPlaylistResponse) }
    def update_a_playlist(body:, playlist_id:, timeout_ms: nil)
      # update_a_playlist - Update a playlist by ID
      # This endpoint allows you to update the name and description of an existing playlist. It enables modifications to the playlist's metadata without altering the media items or playlist structure.
      # #### How it works
      # 
      #  - When a user sends a PUT request to this endpoint with the `playlistId` and updated name and description in the request body, FastPix updates the playlist metadata accordingly and returns the updated playlist details.
      # 
      # #### Example
      # An e-learning platform updates the playlist titled "Beginner Python Series" to rename it as "Python Basics" and add a more detailed description. The updated metadata is reflected when retrieving the playlist, helping users better understand the playlist content.
      request = Models::Operations::UpdateAPlaylistRequest.new(
        playlist_id: playlist_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::UpdateAPlaylistRequest,
        base_url,
        '/on-demand/playlists/{playlistId}',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :body, :json)
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

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'update-a-playlist',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::PlaylistCreatedResponse)
          response = Models::Operations::UpdateAPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            playlist_created_response: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::UpdateAPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      end
    end


    sig { params(playlist_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::DeleteAPlaylistResponse) }
    def delete_a_playlist(playlist_id:, timeout_ms: nil)
      # delete_a_playlist - Delete a playlist by ID
      # This endpoint allows you to delete an existing playlist from the workspace. After deleted, the playlist and its metadata are permanently removed and cannot be recovered.
      # #### How it works
      #  - When a user sends a DELETE request to this endpoint with the `playlistId`, FastPix removes the specified playlist from the workspace and returns a confirmation of successful deletion.
      # 
      # #### Example
      # An e-learning platform deletes an outdated playlist titled "Old Python Tutorials" by providing its unique playlist ID. The platform receives confirmation that the playlist has been removed, ensuring learners no longer see the obsolete content.
      request = Models::Operations::DeleteAPlaylistRequest.new(
        playlist_id: playlist_id
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::DeleteAPlaylistRequest,
        base_url,
        '/on-demand/playlists/{playlistId}',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      headers['Accept'] = 'application/json'
      headers['user-agent'] = @sdk_configuration.user_agent

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'delete-a-playlist',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::PlaylistDeleteResponse)
          response = Models::Operations::DeleteAPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            playlist_delete_response: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::DeleteAPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      end
    end


    sig { params(body: Models::Components::MediaIdsRequest, playlist_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::AddMediaToPlaylistResponse) }
    def add_media_to_playlist(body:, playlist_id:, timeout_ms: nil)
      # add_media_to_playlist - Add media to a playlist by ID
      # This endpoint allows you to add one or more media items to an existing playlist. By passing the media ID(s) in the request, the specified media items are appended to the playlist in the order provided.
      # #### How it works
      # 
      #  - When a user sends a PATCH request to this endpoint with the `playlistId` as path parameter and a list of media ID(s) in the request body, FastPix adds the specified media items to the playlist and returns the updated playlist details.
      # 
      # #### Example
      # An e-learning platform adds new video tutorials to the "Beginner Python Series" playlist by sending their media IDs in the request. The playlist is updated with the new content, ensuring learners have access to the latest tutorials in sequence.
      request = Models::Operations::AddMediaToPlaylistRequest.new(
        playlist_id: playlist_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::AddMediaToPlaylistRequest,
        base_url,
        '/on-demand/playlists/{playlistId}/media',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :body, :json)
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

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'add-media-to-playlist',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::PlaylistByIdResponse)
          response = Models::Operations::AddMediaToPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            playlist_by_id_response: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::AddMediaToPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      end
    end


    sig { params(body: Models::Components::MediaIdsRequest, playlist_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::ChangeMediaOrderInPlaylistResponse) }
    def change_media_order_in_playlist(body:, playlist_id:, timeout_ms: nil)
      # change_media_order_in_playlist - Change media order in a playlist by ID
      # This endpoint allows you to change the order of media items within a playlist. By passing the complete list of media IDs in the desired sequence, the playlist's play order is updated accordingly.
      # #### How it works
      # 
      #  - When a user sends a PUT request to this endpoint with the `playlistId` as path parameter and the reordered list of all media IDs in the request body, FastPix updates the playlist to reflect the new media sequence and returns the updated playlist details.
      # 
      # #### Example
      # An e-learning platform rearranges the "Beginner Python Series" playlist by submitting a reordered list of media IDs. The playlist now follows the new sequence, providing learners with a better structured learning path.
      request = Models::Operations::ChangeMediaOrderInPlaylistRequest.new(
        playlist_id: playlist_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::ChangeMediaOrderInPlaylistRequest,
        base_url,
        '/on-demand/playlists/{playlistId}/media',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :body, :json)
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

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'change-media-order-in-playlist',
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::PlaylistByIdResponse)
          response = Models::Operations::ChangeMediaOrderInPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            playlist_by_id_response: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::ChangeMediaOrderInPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      end
    end


    sig { params(body: Models::Components::MediaIdsRequest, playlist_id: ::String, timeout_ms: T.nilable(Integer)).returns(Models::Operations::DeleteMediaFromPlaylistResponse) }
    def delete_media_from_playlist(body:, playlist_id:, timeout_ms: nil)
      # delete_media_from_playlist - Delete media in a playlist by ID
      # This endpoint allows you to delete one or more media items from an existing playlist. By passing the media ID(s) in the request, the specified media items are removed from the playlist.
      # #### How it works
      # 
      #  - When a user sends a DELETE request to this endpoint with the playlist ID as the path parameter and the media ID(s) to be removed in the request body, FastPix deletes the specified media items from the playlist and returns the updated playlist details.
      # 
      # #### Example
      # An e-learning platform removes outdated video tutorials from the "Beginner Python Series" playlist by specifying their media IDs in the request. The playlist is updated to exclude these items, ensuring learners only access relevant content.
      request = Models::Operations::DeleteMediaFromPlaylistRequest.new(
        playlist_id: playlist_id,
        body: body
      )
      url, params = @sdk_configuration.get_server_details
      base_url = Utils.template_url(url, params)
      url = Utils.generate_url(
        Models::Operations::DeleteMediaFromPlaylistRequest,
        base_url,
        '/on-demand/playlists/{playlistId}/media',
        request
      )
      headers = {}
      headers = T.cast(headers, T::Hash[String, String])
      req_content_type, data, form = Utils.serialize_request_body(request, false, false, :body, :json)
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

      security = @sdk_configuration.security_source&.call

      timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      timeout ||= @sdk_configuration.timeout
      

      connection = @sdk_configuration.client

      hook_ctx = SDKHooks::HookContext.new(
        config: @sdk_configuration,
        base_url: base_url,
        oauth2_scopes: nil,
        operation_id: 'delete-media-from-playlist',
        security_source: @sdk_configuration.security_source
      )

      error = T.let(nil, T.nilable(StandardError))
      http_response = T.let(nil, T.nilable(Faraday::Response))
      
      
      begin
        http_response = T.must(connection).delete(url) do |req|
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
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::PlaylistByIdResponse)
          response = Models::Operations::DeleteMediaFromPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            playlist_by_id_response: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      elsif Utils.match_status_code(http_response.status, ['4XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      elsif Utils.match_status_code(http_response.status, ['5XX'])
        raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'API error occurred'
      else
        if Utils.match_content_type(content_type, 'application/json')
          http_response = @sdk_configuration.hooks.after_success(
            hook_ctx: SDKHooks::AfterSuccessHookContext.new(
              hook_ctx: hook_ctx
            ),
            response: http_response
          )
          response_data = http_response.env.response_body
          obj = Crystalline.unmarshal_json(JSON.parse(response_data), Models::Components::DefaultError)
          response = Models::Operations::DeleteMediaFromPlaylistResponse.new(
            status_code: http_response.status,
            content_type: content_type,
            raw_response: http_response,
            default_error: T.unsafe(obj)
          )

          return response
        else
          raise ::FastpixClient::Models::Errors::APIError.new(status_code: http_response.status, body: http_response.env.response_body, raw_response: http_response), 'Unknown content type received'
        end
      end
    end
  end
end
