# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # A media consists of different media tracks, like video, audio, and subtitle, all combined.
      class VideoTrack
        extend T::Sig
        include Crystalline::MetadataFields

        # FastPix generates a unique identifier for each track.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('id') } }
        # Defines the type of input. This option is mandatory.
        field :type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type') } }
        # Track width denotes the range of widths applicable to a specific track. Currently, this setting can be modified only for video tracks
        field :width, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('width') } }
        # Track height denotes the range of height applicable to a specific track. Currently, this setting can be modified only for video tracks.
        field :height, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('height') } }
        # Frame rate quantifies the speed at which frames are displayed per second. It represents the range of frames available for a specific track. The indeterminable frame rate of the input file is indicated by a value of -1.
        field :frame_rate, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('frameRate') } }
        # Indicates the current state of the track. 'available' means the track has been processed successfully and is ready to be used or played.
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('status') } }
        # Title of the track.
        field :title, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('title') } }

        sig { params(id: T.nilable(::String), type: T.nilable(::String), width: T.nilable(::Float), height: T.nilable(::Float), frame_rate: T.nilable(::String), status: T.nilable(::String), title: T.nilable(::String)).void }
        def initialize(id: nil, type: nil, width: nil, height: nil, frame_rate: nil, status: nil, title: nil)
          @id = id
          @type = type
          @width = width
          @height = height
          @frame_rate = frame_rate
          @status = status
          @title = title
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @type == other.type
          return false unless @width == other.width
          return false unless @height == other.height
          return false unless @frame_rate == other.frame_rate
          return false unless @status == other.status
          return false unless @title == other.title
          true
        end
      end
    end
  end
end
