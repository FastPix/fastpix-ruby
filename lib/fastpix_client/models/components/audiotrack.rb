# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # A media consists of different media tracks, like video, audio, and subtitle, all combined.
      class AudioTrack
        extend T::Sig
        include Crystalline::MetadataFields

        # FastPix generates a unique identifier for each track.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('id') } }
        # Defines the type of input track.
        field :type, Crystalline::Nilable.new(Models::Components::AudioTrackType), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type'), 'decoder': Utils.enum_from_string(Models::Components::AudioTrackType, true) } }
        # Indicates the current state of the track. 'available' means the track has been processed successfully and is ready to be used or played.
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('status') } }
        # Name of the language in which the subtitles will be generated.
        # 
        field :language_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('languageName') } }
        # Language codes are concise, standardized symbols that denote languages, utilizing either two or three characters for identification. The language code must be compliant with the BCP 47 standard to ensure compatibility. (for text only).
        # 
        field :language_code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('languageCode') } }

        sig { params(id: T.nilable(::String), type: T.nilable(Models::Components::AudioTrackType), status: T.nilable(::String), language_name: T.nilable(::String), language_code: T.nilable(::String)).void }
        def initialize(id: nil, type: nil, status: nil, language_name: nil, language_code: nil)
          @id = id
          @type = type
          @status = status
          @language_name = language_name
          @language_code = language_code
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @type == other.type
          return false unless @status == other.status
          return false unless @language_name == other.language_name
          return false unless @language_code == other.language_code
          true
        end
      end
    end
  end
end
