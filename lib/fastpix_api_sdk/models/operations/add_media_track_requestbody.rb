
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class AddMediaTrackRequestBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Contains details about the track being added to the media file.
        field :tracks, Crystalline::Nilable.new(Models::Components::AddTrackRequest), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('tracks') } }

        sig { params(tracks: T.nilable(Models::Components::AddTrackRequest)).void }
        def initialize(tracks: nil)
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
