
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # Generates subtitle files for audio/video files.
      # 
      class Subtitles
        extend T::Sig
        include Crystalline::MetadataFields

        # Name of the language for the subtitles.
        field :language_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageName') } }
        # Tag a video in "key" : "value" pairs for searchable metadata. Maximum 10 entries, 255 characters each.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }
        # Language codes (BCP 47 compliant) used for text files.
        # 
        field :language_code, Crystalline::Nilable.new(Models::Operations::LanguageCode), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageCode'), 'decoder': Utils.enum_from_string(Models::Operations::LanguageCode, true) } }

        sig { params(language_name: T.nilable(::String), metadata: T.nilable(T::Hash[Symbol, ::String]), language_code: T.nilable(Models::Operations::LanguageCode)).void }
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
