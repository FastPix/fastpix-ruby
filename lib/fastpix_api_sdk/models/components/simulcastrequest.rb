
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class SimulcastRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The RTMPS hostname, combined with the application name, is crucial for connecting to third-party live streaming services and transmitting the live stream.
        field :url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('url') } }
        # A unique stream key is generated for streaming, allowing the user to start streaming on any third-party platform using this key.
        field :stream_key, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('streamKey') } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key":"value"s pairs. Dynamic Metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }

        sig { params(url: T.nilable(::String), stream_key: T.nilable(::String), metadata: T.nilable(T::Hash[Symbol, ::String])).void }
        def initialize(url: nil, stream_key: nil, metadata: nil)
          @url = url
          @stream_key = stream_key
          @metadata = metadata
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @url == other.url
          return false unless @stream_key == other.stream_key
          return false unless @metadata == other.metadata
          true
        end
      end
    end
  end
end
