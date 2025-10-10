
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Contains details for generating subtitle tracks for a media file.
      class TrackSubtitlesGenerateRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The full name of the language in which subtitles will be generated.
        field :language_name, ::String, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageName'), required: true } }
        # Language code for content localization
        field :language_code, Models::Components::LanguageCode, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageCode'), required: true, 'decoder': Utils.enum_from_string(Models::Components::LanguageCode, false) } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key" : "value" pairs. Dynamic Metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }

        sig { params(language_name: ::String, language_code: Models::Components::LanguageCode, metadata: T.nilable(T::Hash[Symbol, ::String])).void }
        def initialize(language_name:, language_code:, metadata: nil)
          @language_name = language_name
          @language_code = language_code
          @metadata = metadata
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @language_name == other.language_name
          return false unless @language_code == other.language_code
          return false unless @metadata == other.metadata
          true
        end
      end
    end
  end
end
