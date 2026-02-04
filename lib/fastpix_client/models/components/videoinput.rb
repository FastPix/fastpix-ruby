# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class VideoInput
        extend T::Sig
        include Crystalline::MetadataFields

        # Defines the type of input.
        # 
        field :type, ::String, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type'), required: true } }
        # The url of the intro video which is to be added at the start of the video.
        # 
        field :intro_url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('introUrl') } }
        # The url of the outro video which is to be added at the end of the video.
        # 
        field :outro_url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('outroUrl') } }
        # The list of the startTime-endTime of the segments to be removed from the actual video.
        # 
        field :expunge_segments, Crystalline::Nilable.new(Crystalline::Array.new(::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('expungeSegments') } }
        # A list of media segments to be added or processed. Each segment includes details such as the URL of the media file and instructions on where it should be inserted in the final media composition. A segment can either specify an exact timestamp  (`insertAt`) or indicate that it should be added at the end (`insertAtEnd`).
        field :segments, Crystalline::Nilable.new(Crystalline::Array.new(Crystalline::Union.new(Models::Components::VideoInputSegment1, Models::Components::VideoInputSegment2))), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('segments') } }

        sig { params(type: ::String, intro_url: T.nilable(::String), outro_url: T.nilable(::String), expunge_segments: T.nilable(T::Array[::String]), segments: T.nilable(T::Array[T.any(Models::Components::VideoInputSegment1, Models::Components::VideoInputSegment2)])).void }
        def initialize(type:, intro_url: nil, outro_url: nil, expunge_segments: nil, segments: nil)
          @type = type
          @intro_url = intro_url
          @outro_url = outro_url
          @expunge_segments = expunge_segments
          @segments = segments
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @type == other.type
          return false unless @intro_url == other.intro_url
          return false unless @outro_url == other.outro_url
          return false unless @expunge_segments == other.expunge_segments
          return false unless @segments == other.segments
          true
        end
      end
    end
  end
end
