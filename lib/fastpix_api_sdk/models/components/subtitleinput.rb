# Code generated by Speakeasy (https://speakeasy.com). DO NOT EDIT.

# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Generates subtitle files for audio/video files.
      class SubtitleInput
        extend T::Sig
        include Crystalline::MetadataFields

        # Defines the type of input.
        # 
        field :type, ::String, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('type'), required: true } }
        # The direct URL of the subtitle file.
        field :url, ::String, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('url'), required: true } }
        # Name of the language in which the subtitles will be generated.
        field :language_name, ::String, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageName'), required: true } }
        # The BCP 47 language code representing the language of the generated track.
        # 
        field :language_code, Models::Components::SubtitleInputLanguageCode, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageCode'), required: true, 'decoder': Utils.enum_from_string(Models::Components::SubtitleInputLanguageCode, false) } }

        sig { params(type: ::String, url: ::String, language_name: ::String, language_code: Models::Components::SubtitleInputLanguageCode).void }
        def initialize(type:, url:, language_name:, language_code:)
          @type = type
          @url = url
          @language_name = language_name
          @language_code = language_code
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @type == other.type
          return false unless @url == other.url
          return false unless @language_name == other.language_name
          return false unless @language_code == other.language_code
          true
        end
      end
    end
  end
end
