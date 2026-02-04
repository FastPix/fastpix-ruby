# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class UpdateSpecificSimulcastOfStreamRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Upon creating a new live stream, FastPix assigns a unique identifier to the stream.
        field :stream_id, ::String, { 'path_param': { 'field_name': 'streamId', 'style': 'simple', 'explode': false } }
        # When you create the new simulcast, FastPix assign a universal unique identifier which can contain a maximum of 255 characters.
        field :simulcast_id, ::String, { 'path_param': { 'field_name': 'simulcastId', 'style': 'simple', 'explode': false } }

        field :body, Models::Components::SimulcastUpdateRequest, { 'request': { 'media_type': 'application/json' } }

        sig { params(stream_id: ::String, simulcast_id: ::String, body: Models::Components::SimulcastUpdateRequest).void }
        def initialize(stream_id:, simulcast_id:, body:)
          @stream_id = stream_id
          @simulcast_id = simulcast_id
          @body = body
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @stream_id == other.stream_id
          return false unless @simulcast_id == other.simulcast_id
          return false unless @body == other.body
          true
        end
      end
    end
  end
end
