# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Contains details about the track being added to the media file.
      class AddTrackRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The direct URL of the track file. It must point to a valid audio or subtitle file.
        field :url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('url') } }
        # Specifies the type of track being added. It can be either `audio` or `subtitle`.
        field :type, Crystalline::Nilable.new(Models::Components::AddTrackRequestType), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type'), 'decoder': Utils.enum_from_string(Models::Components::AddTrackRequestType, true) } }
        # The BCP 47 language code representing the track’s language.
        field :language_code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('languageCode') } }
        # The full name of the language corresponding to the `languageCode`.
        field :language_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('languageName') } }

        sig { params(url: T.nilable(::String), type: T.nilable(Models::Components::AddTrackRequestType), language_code: T.nilable(::String), language_name: T.nilable(::String)).void }
        def initialize(url: 'https://static.fastpix.io/music-1.mp3', type: Models::Components::AddTrackRequestType::AUDIO, language_code: 'it', language_name: 'Italian')
          @url = url
          @type = type
          @language_code = language_code
          @language_name = language_name
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @url == other.url
          return false unless @type == other.type
          return false unless @language_code == other.language_code
          return false unless @language_name == other.language_name
          true
        end
      end
    end
  end
end
