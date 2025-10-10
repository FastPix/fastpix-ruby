
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Displays the result of the request.
      class SimulcastResponseData
        extend T::Sig
        include Crystalline::MetadataFields

        # When you create the new simulcast, FastPix assign a universal unique identifier which can contain a maximum of 255 characters.
        field :simulcast_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('simulcastId') } }
        # The RTMPS hostname, combined with the application name, is crucial for connecting to third-party live streaming services and transmitting the live stream.
        field :url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('url') } }
        # A unique stream key is generated for streaming, allowing the user to start streaming on any third-party platform using this key.
        field :stream_key, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('streamKey') } }
        # When the value is true, the simulcast will be enabled for the given stream
        field :is_enabled, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('isEnabled') } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key":"value"s pairs. Dynamic Metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }

        sig { params(simulcast_id: T.nilable(::String), url: T.nilable(::String), stream_key: T.nilable(::String), is_enabled: T.nilable(T::Boolean), metadata: T.nilable(T::Hash[Symbol, ::String])).void }
        def initialize(simulcast_id: nil, url: nil, stream_key: nil, is_enabled: nil, metadata: nil)
          @simulcast_id = simulcast_id
          @url = url
          @stream_key = stream_key
          @is_enabled = is_enabled
          @metadata = metadata
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @simulcast_id == other.simulcast_id
          return false unless @url == other.url
          return false unless @stream_key == other.stream_key
          return false unless @is_enabled == other.is_enabled
          return false unless @metadata == other.metadata
          true
        end
      end
    end
  end
end
