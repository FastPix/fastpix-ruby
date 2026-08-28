# Generated. Do not edit.

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

  # Contains the list of servers available to the SDK
  SERVERS = T.let(
    [
      'https://api.fastpix.com/v1/', # 1 - FastPix Video APIs
    ].freeze,
    T::Array[String]
  )

  class SDKConfiguration
    extend T::Sig

    sig { returns(T.nilable(Faraday::Connection)) }
    attr_accessor :client

    sig { returns(::FastpixClient::SDKHooks::Hooks) }
    attr_accessor :hooks

    sig { returns(T.nilable(::FastpixClient::Utils::RetryConfig)) }
    attr_accessor :retry_config

    sig { returns(T.nilable(Float)) }
    attr_accessor :timeout

    
    sig { returns(T.nilable(T.proc.returns(T.nilable(Models::Components::Security)))) }
    attr_accessor :security_source

    
    sig { returns(T.nilable(String)) }
    attr_accessor :server_url

    
    sig { returns(T.nilable(Integer)) }
    attr_accessor :server_idx

    
    sig { returns(String) }
    attr_accessor :language

    sig { returns(String) }
    attr_accessor :openapi_doc_version

    sig { returns(String) }
    attr_accessor :sdk_version

    sig { returns(String) }
    attr_accessor :gen_version

    sig { returns(String) }
    attr_accessor :user_agent

    sig do
      params(
        client: T.nilable(Faraday::Connection),
        hooks: ::FastpixClient::SDKHooks::Hooks,
        retry_config: T.nilable(::FastpixClient::Utils::RetryConfig),
        timeout_ms: T.nilable(Integer),
        security: T.nilable(Models::Components::Security),
        security_source: T.nilable(T.proc.returns(Models::Components::Security)),
        server_url: T.nilable(String),
        server_idx: T.nilable(Integer)
      ).void
    end
    def initialize(client, hooks, retry_config, timeout_ms, security, security_source, server_url, server_idx)
      @client = client
      @hooks = hooks
      @retry_config = retry_config
      @server_url = server_url
      @timeout = (timeout_ms.to_f / 1000) unless timeout_ms.nil?
      @server_idx = server_idx.nil? ? 0 : server_idx
      raise ArgumentError, "Invalid server index #{server_idx}" if @server_idx.negative? || @server_idx >= SERVERS.length
      if !security_source.nil?
        @security_source = security_source
      elsif !security.nil?
        @security_source = -> { security }
      end
      @language = 'ruby'
      @openapi_doc_version = '1.0.0'
      @sdk_version = '1.1.5'
      @gen_version = '2.801.0'
      @user_agent = 'fastpixapi-ruby 1.1.5'
    end

    sig { returns([String, T::Hash[Symbol, String]]) }
    def get_server_details
      return [@server_url.delete_suffix('/'), {}] if !@server_url.nil?
      @server_idx = T.must(@server_idx)
      [T.must(SERVERS[@server_idx]), {}]
    end
  end
end
