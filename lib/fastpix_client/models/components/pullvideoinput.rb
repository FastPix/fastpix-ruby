# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class PullVideoInput
        extend T::Sig
        include Crystalline::MetadataFields

        # Start time indicates where encoding must begin within the video file. For example, if you want to encode a segment from 3 minutes (180 seconds) to 6 minutes (360 seconds) in a 10-minute (600 seconds) video, the start time is 3 minutes (180 seconds). Note: Start time is always mentioned in seconds.
        # 
        field :start_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('startTime') } }
        # End time indicates where encoding must end within the video file. For example, if you want to encode a segment from 3 minutes (180 seconds) to 6 minutes (360 seconds) in a 10-minute (600 seconds) video, the end time is 6 minutes (360 seconds). Note: End time is always mentioned in seconds.
        # 
        field :end_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('endTime') } }
        # The URL of the **intro video** to be added at the beginning of the media file.  
        # The URL must be **valid, publicly accessible, and downloadable** so that FastPix can fetch the file successfully.  
        # Supported video formats include **MP4, MOV, MKV, and TS** for optimal processing performance.
        # 
        field :intro_url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('introUrl') } }
        # The URL of the **outro video** to be added at the end of the media file.  
        # The URL must be **valid, publicly accessible, and downloadable** so that FastPix can retrieve the file successfully.  
        # Supported video formats include **MP4, MOV, MKV, and TS** for best compatibility and processing speed.
        # 
        field :outro_url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('outroUrl') } }
        # The list of start and end times (in seconds) of the segments to be removed from the actual video.
        # 
        field :expunge_segments, Crystalline::Nilable.new(Crystalline::Array.new(::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('expungeSegments') } }
        # A list of media segments to be added or processed. Each segment includes details such as the URL of the media file and instructions on where it should be inserted in the final media composition. A segment can either specify an exact timestamp  (`insertAt`) or indicate that it must be added at the end (`insertAtEnd`).
        field :segments, Crystalline::Nilable.new(Crystalline::Array.new(Crystalline::Union.new(Models::Components::PullVideoInputSegment1, Models::Components::PullVideoInputSegment2))), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('segments') } }
        # Defines the type of input.
        # 
        field :type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type') } }
        # The URL hosts the media file for FastPix, which needs to be downloaded to use further. It supports formats like MP3, MP4, MOV, MKV, or TS, and includes text tracks for subtitles or closed captions (SRT/VTT files). The URL must be valid, publicly accessible, and downloadable to ensure FastPix can fetch the file successfully.
        # 
        # While FastPix can handle various audio and video formats and codecs, using standard and widely supported formats helps achieve optimal processing speed.
        # 
        field :url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('url') } }

        sig { params(start_time: T.nilable(::Integer), end_time: T.nilable(::Integer), intro_url: T.nilable(::String), outro_url: T.nilable(::String), expunge_segments: T.nilable(T::Array[::String]), segments: T.nilable(T::Array[T.any(Models::Components::PullVideoInputSegment1, Models::Components::PullVideoInputSegment2)]), type: T.nilable(::String), url: T.nilable(::String)).void }
        def initialize(start_time: nil, end_time: nil, intro_url: nil, outro_url: nil, expunge_segments: nil, segments: nil, type: 'video', url: 'https://static.fastpix.io/fp-sample-video.mp4')
          @start_time = start_time
          @end_time = end_time
          @intro_url = intro_url
          @outro_url = outro_url
          @expunge_segments = expunge_segments
          @segments = segments
          @type = type
          @url = url
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @start_time == other.start_time
          return false unless @end_time == other.end_time
          return false unless @intro_url == other.intro_url
          return false unless @outro_url == other.outro_url
          return false unless @expunge_segments == other.expunge_segments
          return false unless @segments == other.segments
          return false unless @type == other.type
          return false unless @url == other.url
          true
        end
      end
    end
  end
end
