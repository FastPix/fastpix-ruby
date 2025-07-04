# Code generated by Speakeasy (https://speakeasy.com). DO NOT EDIT.

# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # A media consists of different media tracks, like video, audio, and subtitle, all combined.
      class Track
        extend T::Sig
        include Crystalline::MetadataFields

        # Defines the type of input. This option is mandatory.
        field :type, ::String, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('type'), required: true } }
        # FastPix generates a unique identifier for each track.
        field :id, T.nilable(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('id') } }
        # Track width denotes the range of widths applicable to a specific track. Currently, this setting can be modified only for video tracks
        field :width, T.nilable(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('width') } }
        # Track height denotes the range of height applicable to a specific track. Currently, this setting can be modified only for video tracks.
        field :height, T.nilable(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('height') } }
        # Frame rate quantifies the speed at which frames are displayed per second. It represents the range of frames available for a specific track. If the frame rate of the input file is indeterminable, it will be indicated by a value of -1.
        field :frame_rate, T.nilable(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('frameRate') } }
        # Indicates if the track contains closed captions.
        field :closed_captions, T.nilable(T::Boolean), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('closedCaptions') } }

        sig { params(type: ::String, id: T.nilable(::String), width: T.nilable(::Float), height: T.nilable(::Float), frame_rate: T.nilable(::String), closed_captions: T.nilable(T::Boolean)).void }
        def initialize(type:, id: nil, width: nil, height: nil, frame_rate: nil, closed_captions: nil)
          @type = type
          @id = id
          @width = width
          @height = height
          @frame_rate = frame_rate
          @closed_captions = closed_captions
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @type == other.type
          return false unless @id == other.id
          return false unless @width == other.width
          return false unless @height == other.height
          return false unless @frame_rate == other.frame_rate
          return false unless @closed_captions == other.closed_captions
          true
        end
      end
    end
  end
end
