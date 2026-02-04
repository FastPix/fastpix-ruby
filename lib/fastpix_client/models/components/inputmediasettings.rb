# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Contains configuration details for input media settings.
      class InputMediaSettings
        extend T::Sig
        include Crystalline::MetadataFields

        # Custom key–value pairs for tagging livestreams.  
        # Allows up to 10 entries with a maximum of 255 characters each.
        # 
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }
        # Enables DVR (Digital Video Recorder) functionality, allowing viewers to pause, rewind, and resume live playback.
        # 
        field :enable_dvr_mode, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('enableDvrMode') } }
        # Defines the maximum resolution for encoding, storage, and playback of the live stream.
        # 
        field :max_resolution, Crystalline::Nilable.new(Models::Components::CreateLiveStreamRequestMaxResolution), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('maxResolution'), 'decoder': Utils.enum_from_string(Models::Components::CreateLiveStreamRequestMaxResolution, true) } }
        # Time period (in seconds) FastPix waits to reconnect before ending the stream when disconnected.
        # 
        field :reconnect_window, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('reconnectWindow') } }
        # Basic access policy for media content
        field :media_policy, Crystalline::Nilable.new(Models::Components::BasicAccessPolicy), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('mediaPolicy'), 'decoder': Utils.enum_from_string(Models::Components::BasicAccessPolicy, true) } }

        sig { params(metadata: T.nilable(T::Hash[Symbol, ::String]), enable_dvr_mode: T.nilable(T::Boolean), max_resolution: T.nilable(Models::Components::CreateLiveStreamRequestMaxResolution), reconnect_window: T.nilable(::Integer), media_policy: T.nilable(Models::Components::BasicAccessPolicy)).void }
        def initialize(metadata: nil, enable_dvr_mode: nil, max_resolution: Models::Components::CreateLiveStreamRequestMaxResolution::ONE_THOUSAND_AND_EIGHTYP, reconnect_window: 60, media_policy: Models::Components::BasicAccessPolicy::PUBLIC)
          @metadata = metadata
          @enable_dvr_mode = enable_dvr_mode
          @max_resolution = max_resolution
          @reconnect_window = reconnect_window
          @media_policy = media_policy
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @metadata == other.metadata
          return false unless @enable_dvr_mode == other.enable_dvr_mode
          return false unless @max_resolution == other.max_resolution
          return false unless @reconnect_window == other.reconnect_window
          return false unless @media_policy == other.media_policy
          true
        end
      end
    end
  end
end
