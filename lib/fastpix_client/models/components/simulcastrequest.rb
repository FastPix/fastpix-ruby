# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class SimulcastRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # You can search for videos with specific key-value pairs using metadata, when you tag a video in "key":"value" pairs.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }
        # The RTMPS hostname, combined with the application name, is crucial for connecting to third-party live streaming services and transmitting the live stream.
        field :url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('url') } }
        # A unique stream key is generated for streaming, allowing the user to start streaming on any third-party platform using this key.
        field :stream_key, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('streamKey') } }

        sig { params(metadata: T.nilable(T::Hash[Symbol, ::String]), url: T.nilable(::String), stream_key: T.nilable(::String)).void }
        def initialize(metadata: nil, url: 'rtmp://example.com/', stream_key: 'd851d91d5b768b36k61a264dcc447b')
          @metadata = metadata
          @url = url
          @stream_key = stream_key
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @metadata == other.metadata
          return false unless @url == other.url
          return false unless @stream_key == other.stream_key
          true
        end
      end
    end
  end
end
