# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class DirectUploadResponse
        extend T::Sig
        include Crystalline::MetadataFields


        field :playback_ids, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::PlaybackId)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playbackIds') } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key" : "value" pairs. Dynamic metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        # 
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }
        # The quality tier applied to the media.
        field :media_quality, Crystalline::Nilable.new(Models::Components::DirectUploadResponseMediaQuality), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('mediaQuality'), 'decoder': Utils.enum_from_string(Models::Components::DirectUploadResponseMediaQuality, true) } }
        # The sourceAccess parameter determines whether the original media file is accessible. Set to true to enable access or false to restrict it.
        # 
        field :source_access, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('sourceAccess') } }
        # Enhance the quality and volume of the audio track. This is available for pre-recorded content only.
        # 
        field :optimize_audio, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('optimizeAudio') } }

        sig { params(playback_ids: T.nilable(T::Array[Models::Components::PlaybackId]), metadata: T.nilable(T::Hash[Symbol, ::String]), media_quality: T.nilable(Models::Components::DirectUploadResponseMediaQuality), source_access: T.nilable(T::Boolean), optimize_audio: T.nilable(T::Boolean)).void }
        def initialize(playback_ids: nil, metadata: nil, media_quality: nil, source_access: nil, optimize_audio: nil)
          @playback_ids = playback_ids
          @metadata = metadata
          @media_quality = media_quality
          @source_access = source_access
          @optimize_audio = optimize_audio
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @playback_ids == other.playback_ids
          return false unless @metadata == other.metadata
          return false unless @media_quality == other.media_quality
          return false unless @source_access == other.source_access
          return false unless @optimize_audio == other.optimize_audio
          true
        end
      end
    end
  end
end
