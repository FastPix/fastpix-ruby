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

  class Fastpixapi
    extend T::Sig

    attr_accessor :input_video, :manage_videos, :in_video_ai_features, :playback, :playlist, :drm_configurations, :start_live_stream, :manage_live_stream, :live_playback, :simulcast_stream, :signing_keys, :views, :dimensions, :metrics, :errors

    # Instantiates the SDK, configuring it with the provided parameters.
    #
    # @param client [Faraday::Connection, nil] The faraday HTTP client to use for all operations
    # @param retry_config [::FastpixClient::Utils::RetryConfig, nil] The retry configuration to use for all operations
    # @param timeout_ms [Integer, nil] Request timeout in milliseconds for all operations
    # @param security [Models::Components::Security, nil] The security details required for authentication
    # @param security_source [Proc{|| Models::Components::Security, nil}] A function that returns security details required for authentication
    # @param server_idx [Integer, nil] The index of the server to use for all operations
    # @param server_url [String, nil] The server URL to use for all operations
    # @param url_params [Hash{Symbol => String}, nil] Parameters to optionally template the server URL with
    sig do
      params(
        client: T.nilable(Faraday::Connection),
        retry_config: T.nilable(::FastpixClient::Utils::RetryConfig),
        timeout_ms: T.nilable(Integer),
        security: T.nilable(Models::Components::Security),
        security_source: T.nilable(T.proc.returns(Models::Components::Security)),
        server_idx: T.nilable(Integer),
        server_url: T.nilable(String),
        url_params: T.nilable(T::Hash[Symbol, String])
      ).void
    end
    def initialize(client: nil, retry_config: nil, timeout_ms: nil, security: nil, security_source: nil, server_idx: nil, server_url: nil, url_params: nil)

      connection_options = {
        request: {
          params_encoder: Faraday::FlatParamsEncoder
        }
      }
      connection_options[:request][:timeout] = (timeout_ms.to_f / 1000) unless timeout_ms.nil?

      client ||= Faraday.new(**connection_options) do |f|
        f.request :multipart, { flat_encode: true }
        # f.response :logger, nil, { headers: true, bodies: true, errors: true }
      end
      
      if !server_url.nil?
        if !url_params.nil?
          server_url = Utils.template_url(server_url, url_params)
        end
      end

      server_idx = 0 if server_idx.nil?
      hooks = SDKHooks::Hooks.new
      @sdk_configuration = SDKConfiguration.new(
        client,
        hooks,
        retry_config,
        timeout_ms,
        security,
        security_source,
        server_url,
        server_idx
      )
      @sdk_configuration = hooks.sdk_init(config: @sdk_configuration)
      init_sdks
    end

    sig { void }
    def init_sdks
      @input_video = InputVideo.new(@sdk_configuration)
      @manage_videos = ManageVideos.new(@sdk_configuration)
      @in_video_ai_features = InVideoAIFeatures.new(@sdk_configuration)
      @playback = Playback.new(@sdk_configuration)
      @playlist = Playlist.new(@sdk_configuration)
      @drm_configurations = DRMConfigurations.new(@sdk_configuration)
      @start_live_stream = StartLiveStream.new(@sdk_configuration)
      @manage_live_stream = ManageLiveStream.new(@sdk_configuration)
      @live_playback = LivePlayback.new(@sdk_configuration)
      @simulcast_stream = SimulcastStream.new(@sdk_configuration)
      @signing_keys = SigningKeys.new(@sdk_configuration)
      @views = Views.new(@sdk_configuration)
      @dimensions = Dimensions.new(@sdk_configuration)
      @metrics = Metrics.new(@sdk_configuration)
      @errors = Errors.new(@sdk_configuration)
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
  end
end
