# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class UpdateLiveStreamUserAgentRestrictionsRequest
        extend T::Sig
        include Crystalline::MetadataFields


        field :stream_id, ::String, { 'path_param': { 'field_name': 'streamId', 'style': 'simple', 'explode': false } }

        field :playback_id, ::String, { 'path_param': { 'field_name': 'playbackId', 'style': 'simple', 'explode': false } }

        field :body, Models::Operations::UpdateLiveStreamUserAgentRestrictionsRequestBody, { 'request': { 'media_type': 'application/json' } }

        sig { params(stream_id: ::String, playback_id: ::String, body: Models::Operations::UpdateLiveStreamUserAgentRestrictionsRequestBody).void }
        def initialize(stream_id:, playback_id:, body:)
          @stream_id = stream_id
          @playback_id = playback_id
          @body = body
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @stream_id == other.stream_id
          return false unless @playback_id == other.playback_id
          return false unless @body == other.body
          true
        end
      end
    end
  end
end
