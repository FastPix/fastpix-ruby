# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Contains details about the track that was added or updated.
      class AddTrackResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier of the track.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('id') } }
        # Specifies the type of track (audio or subtitle).
        field :type, Crystalline::Nilable.new(Models::Components::AddTrackResponseType), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type'), 'decoder': Utils.enum_from_string(Models::Components::AddTrackResponseType, true) } }
        # The direct URL of the track file.
        field :url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('url') } }
        # The BCP 47 language code representing the track's language.
        field :language_code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('languageCode') } }
        # The full name of the language corresponding to the `languageCode`.
        field :language_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('languageName') } }

        sig { params(id: T.nilable(::String), type: T.nilable(Models::Components::AddTrackResponseType), url: T.nilable(::String), language_code: T.nilable(::String), language_name: T.nilable(::String)).void }
        def initialize(id: nil, type: nil, url: nil, language_code: nil, language_name: nil)
          @id = id
          @type = type
          @url = url
          @language_code = language_code
          @language_name = language_name
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @type == other.type
          return false unless @url == other.url
          return false unless @language_code == other.language_code
          return false unless @language_name == other.language_name
          true
        end
      end
    end
  end
end
