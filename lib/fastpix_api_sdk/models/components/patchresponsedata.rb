
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Displays the result of the request.
      class PatchResponseData
        extend T::Sig
        include Crystalline::MetadataFields

        # Upon creating a new live stream, FastPix assigns a unique identifier to the stream.
        field :stream_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('streamId') } }
        # A unique stream key is generated for streaming, allowing the user to start streaming on any third-party platform using this key.
        field :stream_key, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('streamKey') } }
        # A secret used for securing the SRT stream. This ensures that only authorized users can access the stream.
        field :srt_secret, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('srtSecret') } }
        # FastPix allows for a to trial the live stream for free. The duration of trial streams is five minutes. After five minutes of activity, the trial stream is turned off, and the recorded asset is removed after a day.
        field :trial, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('trial') } }
        # The current live stream status can be one of four values:Idle, Preparing, Active or Disabled.The Idle status signifies that there isn't a broadcast in progress.The preparing status indicates that the stream is getting prepared. while, the Active status indicates that a broadcast is currently in progress. The Disabled status means that no more RTMPS streams can be published.
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('status') } }
        # Max resolution can be used to control the maximum resolution your media is encoded, stored, and streamed at.
        field :max_resolution, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('maxResolution') } }
        # The maximum duration in seconds that a live stream can have before it ends the stream.
        field :max_duration, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('maxDuration') } }
        # It is the moment when the stream was created Time the media was generated, defined as a localDateTime (UTC Time).
        field :created_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('createdAt'), 'decoder': Utils.datetime_from_iso_format(true) } }
        # In case the software streaming the live, gets disrupted for any reason and gets disconnected from FastPix, the reconnect window specifies the time span FastPix will wait before ending the stream. Before starting the stream, you can set the reconnect window time which is up to 1800 seconds.
        field :reconnect_window, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('reconnectWindow') } }
        # When set to true, the livestream will be recorded and stored for later viewing purposes. If set to false, the livestream will not be recorded.
        field :enable_recording, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('enableRecording') } }
        # Determines whether the recorded stream should be publicly accessible or private in Live to VOD (Video on Demand).
        field :media_policy, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mediaPolicy') } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key":"value"s pairs. Dynamic Metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }

        field :playback_ids, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::PlaybackIdResponse)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playbackIds') } }
        # This object contains the livestream playback response details for SRT Protocol
        field :srt_playback_response, Crystalline::Nilable.new(Models::Components::SrtPlaybackResponse), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('srtPlaybackResponse') } }

        sig { params(stream_id: T.nilable(::String), stream_key: T.nilable(::String), srt_secret: T.nilable(::String), trial: T.nilable(T::Boolean), status: T.nilable(::String), max_resolution: T.nilable(::String), max_duration: T.nilable(::Integer), created_at: T.nilable(::DateTime), reconnect_window: T.nilable(::Integer), enable_recording: T.nilable(T::Boolean), media_policy: T.nilable(::String), metadata: T.nilable(T::Hash[Symbol, ::String]), playback_ids: T.nilable(T::Array[Models::Components::PlaybackIdResponse]), srt_playback_response: T.nilable(Models::Components::SrtPlaybackResponse)).void }
        def initialize(stream_id: nil, stream_key: nil, srt_secret: nil, trial: nil, status: nil, max_resolution: nil, max_duration: nil, created_at: nil, reconnect_window: nil, enable_recording: nil, media_policy: nil, metadata: nil, playback_ids: nil, srt_playback_response: nil)
          @stream_id = stream_id
          @stream_key = stream_key
          @srt_secret = srt_secret
          @trial = trial
          @status = status
          @max_resolution = max_resolution
          @max_duration = max_duration
          @created_at = created_at
          @reconnect_window = reconnect_window
          @enable_recording = enable_recording
          @media_policy = media_policy
          @metadata = metadata
          @playback_ids = playback_ids
          @srt_playback_response = srt_playback_response
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @stream_id == other.stream_id
          return false unless @stream_key == other.stream_key
          return false unless @srt_secret == other.srt_secret
          return false unless @trial == other.trial
          return false unless @status == other.status
          return false unless @max_resolution == other.max_resolution
          return false unless @max_duration == other.max_duration
          return false unless @created_at == other.created_at
          return false unless @reconnect_window == other.reconnect_window
          return false unless @enable_recording == other.enable_recording
          return false unless @media_policy == other.media_policy
          return false unless @metadata == other.metadata
          return false unless @playback_ids == other.playback_ids
          return false unless @srt_playback_response == other.srt_playback_response
          true
        end
      end
    end
  end
end
