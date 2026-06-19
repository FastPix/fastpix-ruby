# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true

require 'cgi'
require 'date'
require 'base64'
require 'sorbet-runtime'

module FastpixClient
  module Utils
    extend T::Sig

    SECURITY_NOT_SUPPORTED = 'not supported'
    BEARER_PREFIX = 'bearer '

    sig { params(req: Faraday::Request, security: Object).void }
    def self.configure_request_security(req, security)
      return if security.nil?
      T.unsafe(security).fields.each do |sec_field|
        value = security.send(sec_field.name)
        next if value.nil?

        metadata = sec_field.metadata[:security]
        next if metadata.nil?

        _parse_security_option(req, value) if metadata[:option]

        if metadata[:scheme]
          # Special case for basic auth which could be a flattened struct
          if metadata[:sub_type] == 'basic' && !value.respond_to?(:fields)
            _parse_security_scheme(req, metadata, security)
          else
            _parse_security_scheme(req, metadata, value)
          end
        end
      end
    end

    sig { params(req: Faraday::Request, option: Object).void }
    def self._parse_security_option(req, option)
      T.unsafe(option).fields.each do |opt_field|
        metadata = opt_field.metadata[:security]
        next if metadata.nil? || !metadata.include?(:scheme)

        _parse_security_scheme(req, metadata, option.send(opt_field.name))
      end
    end

    sig { params(req: Faraday::Request, scheme_metadata: T::Hash[Symbol, String], scheme: Object).void }
    def self._parse_security_scheme(req, scheme_metadata, scheme)
      scheme_type = scheme_metadata[:type]
      sub_type = scheme_metadata[:sub_type]

      if scheme.respond_to? :fields
        if scheme_type == 'http' && sub_type == 'basic'
          _parse_basic_auth_scheme(req, scheme)
          return
        end

        T.unsafe(scheme).fields.each do |field|
          metadata = field.metadata[:security]
          next if metadata.nil? || metadata[:field_name].nil?

          value = scheme.send(field.name)
          _parse_security_scheme_value(req, scheme_metadata, metadata, T.cast(value, String))
        end
      else
        _parse_security_scheme_value(req, scheme_metadata, scheme_metadata, T.cast(scheme, String))
      end
    end

    sig do
      params(req: Faraday::Request, scheme_metadata: T::Hash[Symbol, String],
             security_metadata: T::Hash[Symbol, String], value: String).void
    end
    def self._parse_security_scheme_value(req, scheme_metadata, security_metadata, value)
      scheme_type = scheme_metadata[:type]
      sub_type = scheme_metadata[:sub_type]
      header_name = security_metadata[:field_name]

      case scheme_type
      when 'apiKey'
        _apply_api_key_scheme(req, sub_type, header_name, value)
      when 'openIdConnect', 'oauth2'
        req.headers[header_name] = _bearerize(value)
      when 'http'
        if sub_type == 'bearer'
          req.headers[header_name] = _bearerize(value)
        elsif sub_type != 'custom'
          raise StandardError, SECURITY_NOT_SUPPORTED
        end
      else
        raise StandardError, SECURITY_NOT_SUPPORTED
      end
    end

    # Prefixes the value with `Bearer ` unless it is already a bearer token.
    sig { params(value: String).returns(String) }
    def self._bearerize(value)
      value.downcase.start_with?(BEARER_PREFIX) ? value : "Bearer #{value}"
    end

    # Applies an apiKey security scheme to the request for the given sub_type.
    sig { params(req: Faraday::Request, sub_type: T.nilable(String), header_name: T.nilable(String), value: String).void }
    def self._apply_api_key_scheme(req, sub_type, header_name, value)
      case sub_type
      when 'header'
        req.headers[header_name] = value
      when 'query'
        req.params[header_name] = value
      when 'cookie'
        req.headers['Cookie'][header_name] = value
      else
        raise StandardError, SECURITY_NOT_SUPPORTED
      end
    end

    sig { params(req: Faraday::Request, scheme: Object).void }
    def self._parse_basic_auth_scheme(req, scheme)
      username = T.let('', String)
      password = T.let('', String)

      T.unsafe(scheme).fields.each do |scheme_field|
        metadata = scheme_field.metadata[:security]
        next if metadata.nil? || !metadata.include?(:field_name)

        field_name = metadata[:field_name]
        value = scheme.send(scheme_field.name)

        username = T.let(value, String) if field_name == 'username'
        password = T.let(value, String) if field_name == 'password'
      end

      data = "#{username}:#{password}".encode
      # Use strict_encode, because encode adds newlines after 60 chars
      # https://docs.ruby-lang.org/en/3.0/Base64.html#method-i-encode64
      req.headers['Authorization'] = "Basic #{Base64.strict_encode64(data)}"
    end
  end
end
