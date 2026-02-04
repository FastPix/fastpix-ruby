# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Contains details for generating subtitle tracks for a media file.
      class TrackSubtitlesGenerateRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key" : "value" pairs. Dynamic metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        # 
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }
        # The full name of the language used to generate the subtitles.
        field :language_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('languageName') } }
        # Language code for content localization
        field :language_code, Crystalline::Nilable.new(Models::Components::LanguageCode), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('languageCode'), 'decoder': Utils.enum_from_string(Models::Components::LanguageCode, true) } }

        sig { params(metadata: T.nilable(T::Hash[Symbol, ::String]), language_name: T.nilable(::String), language_code: T.nilable(Models::Components::LanguageCode)).void }
        def initialize(metadata: nil, language_name: 'English', language_code: Models::Components::LanguageCode::EN_US)
          @metadata = metadata
          @language_name = language_name
          @language_code = language_code
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @metadata == other.metadata
          return false unless @language_name == other.language_name
          return false unless @language_code == other.language_code
          true
        end
      end
    end
  end
end
