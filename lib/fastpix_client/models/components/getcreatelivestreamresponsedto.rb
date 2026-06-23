# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Displays the result of the request.
      class GetCreateLiveStreamResponseDTO
        extend T::Sig
        include Crystalline::MetadataFields

        # Upon creating a new live stream, FastPix assigns a unique identifier to the stream.
        field :stream_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('streamId') } }
        # A unique stream key is generated for streaming, allowing the user to start streaming on any third-party platform using this key.
        field :stream_key, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('streamKey') } }
        # A secret used for securing the SRT stream. This ensures that only authorized users can access the stream.
        field :srt_secret, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('srtSecret') } }
        # FastPix allows for a to trial the live stream for free. The duration of trial streams is five minutes. After five minutes of activity, the trial stream is turned off, and the recorded asset is removed after a day.
        field :trial, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('trial') } }
        # The current live stream status can be one of four values:Idle, Preparing, Active or Disabled.The Idle status signifies that there isn"t a broadcast in progress.The preparing status indicates that the stream is getting prepared. while, the Active status indicates that a broadcast is currently in progress. The Disabled status means that no more RTMPS streams can be published.
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('status') } }
        # Max resolution can be used to control the maximum resolution your media is encoded, stored, and streamed at.
        field :max_resolution, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('maxResolution') } }
        # The maximum duration in seconds that a live stream can have before it ends the stream.
        field :max_duration, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('maxDuration') } }
        # It is the moment when the stream was created Time the media was generated, defined as a localDateTime (UTC Time).
        field :created_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('createdAt'), 'decoder': Utils.datetime_from_iso_format(true) } }
        # When set to true, FastPix records and stores the livestream for on-demand viewing. When set to false, the livestream is not recorded.
        field :enable_recording, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('enableRecording') } }
        # Enables DVR (Digital Video Recorder) functionality for the live stream. When set to true, viewers can pause, rewind, and resume playback during the live broadcast. This allows time-shifted viewing of the stream while it is still ongoing.
        field :enable_dvr_mode, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('enableDvrMode') } }
        # Determines whether the recorded stream must be publicly accessible or private in Live to VOD (Video on Demand).
        field :media_policy, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('mediaPolicy') } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key":"value"s pairs. Dynamic metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }
        # Enables low-latency streaming mode to reduce playback delay.
        field :low_latency, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('lowLatency') } }
        # when provided true Enables closed captions for the livestream.
        field :closed_captions, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('closedCaptions') } }
        # A collection of Playback ID objects utilized for crafting HLS playback urls.
        field :playback_ids, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::PlaybackIdResponse)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playbackIds') } }
        # A list of simulcast responses created for the livestream.
        field :simulcast_responses, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::LiveSimulcast)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('simulcastResponses') } }
        # A list of media IDs created when recording is enabled. Each media ID represents a recorded video (Live to VOD). If the stream is stopped and started again outside the reconnect window, a new media ID is generated for each session.
        field :media_ids, Crystalline::Nilable.new(Crystalline::Array.new(::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('mediaIds') } }
        # This object contains the livestream playback response details for SRT Protocol
        field :srt_playback_response, Crystalline::Nilable.new(Models::Components::SrtPlaybackResponse), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('srtPlaybackResponse') } }
        # In case the software streaming the live, gets disrupted for any reason and gets disconnected from FastPix, the reconnect window specifies the time span FastPix will wait before ending the stream. Before starting the stream, you can set the reconnect window time which is up to 1800 seconds.
        field :reconnect_window, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('reconnectWindow') } }

        sig { params(stream_id: T.nilable(::String), stream_key: T.nilable(::String), srt_secret: T.nilable(::String), trial: T.nilable(T::Boolean), status: T.nilable(::String), max_resolution: T.nilable(::String), max_duration: T.nilable(::Integer), created_at: T.nilable(::DateTime), enable_recording: T.nilable(T::Boolean), enable_dvr_mode: T.nilable(T::Boolean), media_policy: T.nilable(::String), metadata: T.nilable(T::Hash[Symbol, ::String]), low_latency: T.nilable(T::Boolean), closed_captions: T.nilable(T::Boolean), playback_ids: T.nilable(T::Array[Models::Components::PlaybackIdResponse]), simulcast_responses: T.nilable(T::Array[Models::Components::LiveSimulcast]), media_ids: T.nilable(T::Array[::String]), srt_playback_response: T.nilable(Models::Components::SrtPlaybackResponse), reconnect_window: T.nilable(::Integer)).void }
        def initialize(stream_id: nil, stream_key: nil, srt_secret: nil, trial: nil, status: nil, max_resolution: nil, max_duration: nil, created_at: nil, enable_recording: nil, enable_dvr_mode: nil, media_policy: nil, metadata: nil, low_latency: nil, closed_captions: nil, playback_ids: nil, simulcast_responses: nil, media_ids: nil, srt_playback_response: nil, reconnect_window: 60)
          @stream_id = stream_id
          @stream_key = stream_key
          @srt_secret = srt_secret
          @trial = trial
          @status = status
          @max_resolution = max_resolution
          @max_duration = max_duration
          @created_at = created_at
          @enable_recording = enable_recording
          @enable_dvr_mode = enable_dvr_mode
          @media_policy = media_policy
          @metadata = metadata
          @low_latency = low_latency
          @closed_captions = closed_captions
          @playback_ids = playback_ids
          @simulcast_responses = simulcast_responses
          @media_ids = media_ids
          @srt_playback_response = srt_playback_response
          @reconnect_window = reconnect_window
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class

          [@stream_id, @stream_key, @srt_secret, @trial, @status,
           @max_resolution, @max_duration, @created_at, @enable_recording, @enable_dvr_mode,
           @media_policy, @metadata, @low_latency, @closed_captions, @playback_ids,
           @simulcast_responses, @media_ids, @srt_playback_response, @reconnect_window] ==
            [other.stream_id, other.stream_key, other.srt_secret, other.trial, other.status,
             other.max_resolution, other.max_duration, other.created_at, other.enable_recording, other.enable_dvr_mode,
             other.media_policy, other.metadata, other.low_latency, other.closed_captions, other.playback_ids,
             other.simulcast_responses, other.media_ids, other.srt_playback_response, other.reconnect_window]
        end
      end
    end
  end
end
