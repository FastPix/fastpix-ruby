
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Contains details about the track being added to the media file.
      class UpdateTrackRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # The direct URL of the track file. It should point to a valid audio or subtitle file.
        field :url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('url') } }
        # The BCP 47 language code representing the track's language.
        field :language_code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageCode') } }
        # The full name of the language corresponding to the `languageCode`.
        field :language_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageName') } }

        sig { params(url: T.nilable(::String), language_code: T.nilable(::String), language_name: T.nilable(::String)).void }
        def initialize(url: nil, language_code: nil, language_name: nil)
          @url = url
          @language_code = language_code
          @language_name = language_name
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @url == other.url
          return false unless @language_code == other.language_code
          return false unless @language_name == other.language_name
          true
        end
      end
    end
  end
end
