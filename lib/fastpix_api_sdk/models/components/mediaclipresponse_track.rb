
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class MediaClipResponseTrack
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier for the media track.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('id') } }
        # The type of media track.
        field :type, Crystalline::Nilable.new(Models::Components::MediaClipResponseType), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('type'), 'decoder': Utils.enum_from_string(Models::Components::MediaClipResponseType, true) } }
        # The width of the video track (applicable to video only).
        field :width, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('width') } }
        # The height of the video track (applicable to video only).
        field :height, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('height') } }
        # The current processing status of the track.
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('status') } }
        # The language code of the audio or subtitle track.
        field :language_code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageCode') } }
        # The language name of the audio or subtitle track.
        field :language_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('languageName') } }

        sig { params(id: T.nilable(::String), type: T.nilable(Models::Components::MediaClipResponseType), width: T.nilable(::Integer), height: T.nilable(::Integer), status: T.nilable(::String), language_code: T.nilable(::String), language_name: T.nilable(::String)).void }
        def initialize(id: nil, type: nil, width: nil, height: nil, status: nil, language_code: nil, language_name: nil)
          @id = id
          @type = type
          @width = width
          @height = height
          @status = status
          @language_code = language_code
          @language_name = language_name
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @type == other.type
          return false unless @width == other.width
          return false unless @height == other.height
          return false unless @status == other.status
          return false unless @language_code == other.language_code
          return false unless @language_name == other.language_name
          true
        end
      end
    end
  end
end
