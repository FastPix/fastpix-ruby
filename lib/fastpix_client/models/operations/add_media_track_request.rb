# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class AddMediaTrackRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier assigned to the media when created. The value must be a valid UUID.
        field :media_id, ::String, { 'path_param': { 'field_name': 'mediaId', 'style': 'simple', 'explode': false } }

        field :body, Models::Operations::AddMediaTrackRequestBody, { 'request': { 'media_type': 'application/json' } }

        sig { params(media_id: ::String, body: Models::Operations::AddMediaTrackRequestBody).void }
        def initialize(media_id:, body:)
          @media_id = media_id
          @body = body
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @media_id == other.media_id
          return false unless @body == other.body
          true
        end
      end
    end
  end
end
