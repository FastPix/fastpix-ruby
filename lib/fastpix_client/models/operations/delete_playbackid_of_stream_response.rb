# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class DeletePlaybackIdOfStreamResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # HTTP response content type for this operation
        field :content_type, ::String
        # HTTP response status code for this operation
        field :status_code, ::Integer
        # Raw HTTP response; suitable for custom response parsing
        field :raw_response, ::Faraday::Response
        # Stream's playbackId deleted successfully
        field :live_stream_delete_response, Crystalline::Nilable.new(Models::Components::LiveStreamDeleteResponse)
        # See the range of possible <a href="https://fastpix.com/docs/error-codes">error</a> responses and their status codes.
        field :default_error, Crystalline::Nilable.new(Models::Components::DefaultError)

        sig { params(content_type: ::String, status_code: ::Integer, raw_response: ::Faraday::Response, live_stream_delete_response: T.nilable(Models::Components::LiveStreamDeleteResponse), default_error: T.nilable(Models::Components::DefaultError)).void }
        def initialize(content_type:, status_code:, raw_response:, live_stream_delete_response: nil, default_error: nil)
          @content_type = content_type
          @status_code = status_code
          @raw_response = raw_response
          @live_stream_delete_response = live_stream_delete_response
          @default_error = default_error
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @content_type == other.content_type
          return false unless @status_code == other.status_code
          return false unless @raw_response == other.raw_response
          return false unless @live_stream_delete_response == other.live_stream_delete_response
          return false unless @default_error == other.default_error
          true
        end
      end
    end
  end
end
