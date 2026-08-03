# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # UpdateMediaMp4Support - One MP4 rendition generated for the media when MP4 support is requested.
      class UpdateMediaMp4Support
        extend T::Sig
        include Crystalline::MetadataFields

        # The MP4 rendition type. `capped_4k` is a downloadable MP4 video capped at 4K resolution, `audioOnly` is a downloadable m4a audio-only file.
        field :type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type') } }
        # Generation status of this MP4 rendition. One of `preparing`, `ready`, or `failed`.
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('status') } }
        # Pixel height of the rendition. Omitted for the `audioOnly` type.
        field :height, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('height') } }
        # Pixel width of the rendition. Omitted for the `audioOnly` type.
        field :width, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('width') } }
        # File extension of the downloadable rendition. One of `mp4` or `m4a`.
        field :ext, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('ext') } }

        sig { params(type: T.nilable(::String), status: T.nilable(::String), height: T.nilable(::Integer), width: T.nilable(::Integer), ext: T.nilable(::String)).void }
        def initialize(type: nil, status: nil, height: nil, width: nil, ext: nil)
          @type = type
          @status = status
          @height = height
          @width = width
          @ext = ext
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @type == other.type
          return false unless @status == other.status
          return false unless @height == other.height
          return false unless @width == other.width
          return false unless @ext == other.ext
          true
        end
      end
    end
  end
end
