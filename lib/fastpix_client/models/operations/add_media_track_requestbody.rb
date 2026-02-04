# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class AddMediaTrackRequestBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Contains details about the track being added to the media file.
        field :tracks, Models::Components::AddTrackRequest, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('tracks'), required: true } }

        sig { params(tracks: Models::Components::AddTrackRequest).void }
        def initialize(tracks:)
          @tracks = tracks
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @tracks == other.tracks
          true
        end
      end
    end
  end
end
