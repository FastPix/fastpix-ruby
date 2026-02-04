# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Contains configuration details for applying a watermark overlay to a video.  
      # The watermark is placed over the media content during processing.  
      # For detailed setup steps and customization options, refer to the 
      # <a href="https://docs.fastpix.io/docs/watermark-your-videos" target="_blank">FastPix Watermark Guide</a>.
      # 
      class WatermarkInput
        extend T::Sig
        include Crystalline::MetadataFields

        # Type of overlay (currently only supports "watermark").
        field :type, Models::Components::WatermarkInputType, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type'), required: true, 'decoder': Utils.enum_from_string(Models::Components::WatermarkInputType, false) } }
        # URL of the watermark image.
        field :url, ::String, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('url'), required: true } }

        field :placement, Crystalline::Nilable.new(Models::Components::Placement), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('placement') } }
        # Width of the watermark in percentage or pixels.
        field :width, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('width') } }
        # Height of the watermark in percentage or pixels.
        field :height, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('height') } }
        # Opacity of the watermark in percentage.
        field :opacity, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('opacity') } }

        sig { params(type: Models::Components::WatermarkInputType, url: ::String, placement: T.nilable(Models::Components::Placement), width: T.nilable(::String), height: T.nilable(::String), opacity: T.nilable(::String)).void }
        def initialize(type:, url:, placement: nil, width: nil, height: nil, opacity: nil)
          @type = type
          @url = url
          @placement = placement
          @width = width
          @height = height
          @opacity = opacity
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @type == other.type
          return false unless @url == other.url
          return false unless @placement == other.placement
          return false unless @width == other.width
          return false unless @height == other.height
          return false unless @opacity == other.opacity
          true
        end
      end
    end
  end
end
