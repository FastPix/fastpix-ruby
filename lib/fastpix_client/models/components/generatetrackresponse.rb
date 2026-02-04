# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Represents the response for a successfully generated subtitle track.
      class GenerateTrackResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # A unique identifier for the generated track.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('id') } }
        # The type of track generated ("subtitle").
        field :type, Crystalline::Nilable.new(Models::Components::GenerateTrackResponseType), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type'), 'decoder': Utils.enum_from_string(Models::Components::GenerateTrackResponseType, true) } }
        # The BCP 47 language code representing the language of the generated track.
        # 
        field :language_code, Crystalline::Nilable.new(Models::Components::GenerateTrackResponseLanguageCode), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('languageCode'), 'decoder': Utils.enum_from_string(Models::Components::GenerateTrackResponseLanguageCode, true) } }
        # The full name of the language for the generated track.
        field :language_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('languageName') } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key" : "value" pairs. Dynamic metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        # 
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }

        sig { params(id: T.nilable(::String), type: T.nilable(Models::Components::GenerateTrackResponseType), language_code: T.nilable(Models::Components::GenerateTrackResponseLanguageCode), language_name: T.nilable(::String), metadata: T.nilable(T::Hash[Symbol, ::String])).void }
        def initialize(id: nil, type: nil, language_code: nil, language_name: nil, metadata: nil)
          @id = id
          @type = type
          @language_code = language_code
          @language_name = language_name
          @metadata = metadata
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @type == other.type
          return false unless @language_code == other.language_code
          return false unless @language_name == other.language_name
          return false unless @metadata == other.metadata
          true
        end
      end
    end
  end
end
