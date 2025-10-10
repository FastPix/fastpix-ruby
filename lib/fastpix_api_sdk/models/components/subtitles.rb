
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Generates subtitle files for audio/video files.
      # 
      class Subtitles
        extend T::Sig
        include Crystalline::MetadataFields

        # Name of the language in which the subtitles will be generated.
        # 
        field :language_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageName') } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key" : "value" pairs. Dynamic Metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }
        # Language codes are concise, standardized symbols that denote languages, utilizing either two or three characters for identification. The language code must be compliant with the BCP 47 standard to ensure compatibility. (for text only).
        # 
        field :language_code, Crystalline::Nilable.new(Models::Components::CreateMediaRequestLanguageCode), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageCode'), 'decoder': Utils.enum_from_string(Models::Components::CreateMediaRequestLanguageCode, true) } }

        sig { params(language_name: T.nilable(::String), metadata: T.nilable(T::Hash[Symbol, ::String]), language_code: T.nilable(Models::Components::CreateMediaRequestLanguageCode)).void }
        def initialize(language_name: nil, metadata: nil, language_code: nil)
          @language_name = language_name
          @metadata = metadata
          @language_code = language_code
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @language_name == other.language_name
          return false unless @metadata == other.metadata
          return false unless @language_code == other.language_code
          true
        end
      end
    end
  end
end
