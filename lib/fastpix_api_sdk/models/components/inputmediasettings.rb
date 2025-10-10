
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Displays the result of the input Media settings.
      class InputMediaSettings
        extend T::Sig
        include Crystalline::MetadataFields

        # Basic access policy for media content
        field :media_policy, Crystalline::Nilable.new(Models::Components::BasicAccessPolicy), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mediaPolicy'), 'decoder': Utils.enum_from_string(Models::Components::BasicAccessPolicy, true) } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key":"value"s pairs. Dynamic Metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }
        # Enables DVR (Digital Video Recorder) functionality for the live stream. When set to true, viewers can pause, rewind, and resume playback during the live broadcast. This allows time-shifted viewing of the stream while it is still ongoing.
        field :enable_dvr_mode, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('enableDvrMode') } }
        # Max resolution can be used to control the maximum resolution your media is encoded, stored, and streamed at.
        field :max_resolution, Crystalline::Nilable.new(Models::Components::CreateLiveStreamRequestMaxResolution), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('maxResolution'), 'decoder': Utils.enum_from_string(Models::Components::CreateLiveStreamRequestMaxResolution, true) } }
        # In case the software streaming the live, gets disrupted for any reason and gets disconnected from FastPix, the reconnect window specifies the time span FastPix will wait before ending the stream. Before starting the stream, you can set the reconnect window time which is up to 1800 seconds.
        field :reconnect_window, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('reconnectWindow') } }

        sig { params(media_policy: T.nilable(Models::Components::BasicAccessPolicy), metadata: T.nilable(T::Hash[Symbol, ::String]), enable_dvr_mode: T.nilable(T::Boolean), max_resolution: T.nilable(Models::Components::CreateLiveStreamRequestMaxResolution), reconnect_window: T.nilable(::Integer)).void }
        def initialize(media_policy: nil, metadata: nil, enable_dvr_mode: nil, max_resolution: Models::Components::CreateLiveStreamRequestMaxResolution::ONE_THOUSAND_AND_EIGHTYP, reconnect_window: 60)
          @media_policy = media_policy
          @metadata = metadata
          @enable_dvr_mode = enable_dvr_mode
          @max_resolution = max_resolution
          @reconnect_window = reconnect_window
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @media_policy == other.media_policy
          return false unless @metadata == other.metadata
          return false unless @enable_dvr_mode == other.enable_dvr_mode
          return false unless @max_resolution == other.max_resolution
          return false unless @reconnect_window == other.reconnect_window
          true
        end
      end
    end
  end
end
