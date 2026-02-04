# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class CreateMediaResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # The Media is assigned a universal unique identifier, which can contain a maximum of 255 characters.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('id') } }
        # Determines the media's status, which can be one of the possible values.
        field :status, Crystalline::Nilable.new(Models::Components::CreateMediaResponseStatus), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('status'), 'decoder': Utils.enum_from_string(Models::Components::CreateMediaResponseStatus, true) } }
        # Time the media was created, defined as a localDateTime (UTC Time).
        field :created_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('createdAt'), 'decoder': Utils.datetime_from_iso_format(true) } }
        # Time the media was updated, defined as a localDateTime (UTC Time).
        field :updated_at, Crystalline::Nilable.new(::DateTime), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('updatedAt'), 'decoder': Utils.datetime_from_iso_format(true) } }
        # A collection of Playback ID objects utilized for crafting HLS playback URLs.
        field :playback_ids, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::PlaybackId)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playbackIds') } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key" : "value" pairs. Dynamic metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        # 
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }
        # The quality tier applied to the media.
        field :media_quality, Crystalline::Nilable.new(Models::Components::CreateMediaResponseMediaQuality), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('mediaQuality'), 'decoder': Utils.enum_from_string(Models::Components::CreateMediaResponseMediaQuality, true) } }
        # The sourceAccess parameter determines whether the original media file is accessible. Set to true to enable access or false to restrict it.
        # 
        field :source_access, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('sourceAccess') } }
        # The maximum resolution tier defines the highest quality at which your media is available.
        field :max_resolution, Crystalline::Nilable.new(Models::Components::CreateMediaResponseMaxResolution), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('maxResolution'), 'decoder': Utils.enum_from_string(Models::Components::CreateMediaResponseMaxResolution, true) } }
        # A list of media input sources to be processed.
        field :inputs, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::CreateMediaResponseInput)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('inputs') } }
        # Enhance the quality and volume of the audio track. This is available for pre-recorded content only.
        # 
        field :optimize_audio, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('optimizeAudio') } }
        # FastPix allows for a free trial. Create as many media files as you like during the trial period. Remember, each clip can only be 10 seconds long and will be deleted after 24 hours. Also, all trial content will have the FastPix logo watermark.
        # 
        field :trial, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('trial') } }

        sig { params(id: T.nilable(::String), status: T.nilable(Models::Components::CreateMediaResponseStatus), created_at: T.nilable(::DateTime), updated_at: T.nilable(::DateTime), playback_ids: T.nilable(T::Array[Models::Components::PlaybackId]), metadata: T.nilable(T::Hash[Symbol, ::String]), media_quality: T.nilable(Models::Components::CreateMediaResponseMediaQuality), source_access: T.nilable(T::Boolean), max_resolution: T.nilable(Models::Components::CreateMediaResponseMaxResolution), inputs: T.nilable(T::Array[Models::Components::CreateMediaResponseInput]), optimize_audio: T.nilable(T::Boolean), trial: T.nilable(T::Boolean)).void }
        def initialize(id: nil, status: nil, created_at: nil, updated_at: nil, playback_ids: nil, metadata: nil, media_quality: nil, source_access: nil, max_resolution: nil, inputs: nil, optimize_audio: nil, trial: true)
          @id = id
          @status = status
          @created_at = created_at
          @updated_at = updated_at
          @playback_ids = playback_ids
          @metadata = metadata
          @media_quality = media_quality
          @source_access = source_access
          @max_resolution = max_resolution
          @inputs = inputs
          @optimize_audio = optimize_audio
          @trial = trial
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @status == other.status
          return false unless @created_at == other.created_at
          return false unless @updated_at == other.updated_at
          return false unless @playback_ids == other.playback_ids
          return false unless @metadata == other.metadata
          return false unless @media_quality == other.media_quality
          return false unless @source_access == other.source_access
          return false unless @max_resolution == other.max_resolution
          return false unless @inputs == other.inputs
          return false unless @optimize_audio == other.optimize_audio
          return false unless @trial == other.trial
          true
        end
      end
    end
  end
end
