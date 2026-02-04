# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class GetMediaClipsResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # HTTP response content type for this operation
        field :content_type, ::String
        # HTTP response status code for this operation
        field :status_code, ::Integer
        # Raw HTTP response; suitable for custom response parsing
        field :raw_response, ::Faraday::Response
        # Get media clips
        field :media_clip_response, Crystalline::Nilable.new(Models::Components::MediaClipResponse)
        # See the range of possible <a href="https://docs.fastpix.io/reference/error-codes">error</a> responses and their status codes.
        field :default_error, Crystalline::Nilable.new(Models::Components::DefaultError)

        sig { params(content_type: ::String, status_code: ::Integer, raw_response: ::Faraday::Response, media_clip_response: T.nilable(Models::Components::MediaClipResponse), default_error: T.nilable(Models::Components::DefaultError)).void }
        def initialize(content_type:, status_code:, raw_response:, media_clip_response: nil, default_error: nil)
          @content_type = content_type
          @status_code = status_code
          @raw_response = raw_response
          @media_clip_response = media_clip_response
          @default_error = default_error
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @content_type == other.content_type
          return false unless @status_code == other.status_code
          return false unless @raw_response == other.raw_response
          return false unless @media_clip_response == other.media_clip_response
          return false unless @default_error == other.default_error
          true
        end
      end
    end
  end
end
