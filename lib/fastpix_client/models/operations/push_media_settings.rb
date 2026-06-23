# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Configuration settings for uploading and processing media on the FastPix platform.  
      # These settings define how the uploaded video is handled, including access control, resolution, DRM, and optional metadata.  
      # For a complete explanation of how media uploads and processing work, refer to the  
      # <a href="https://fastpix.com/docs/get-started/overview" target="_blank">FastPix Video on Demand Overview</a>.
      # 
      class PushMediaSettings
        extend T::Sig
        include Crystalline::MetadataFields

        # Start time indicates where encoding must begin within the video file, in seconds.
        field :start_time, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('startTime') } }
        # End time indicates where encoding must end within the video file, in seconds.
        field :end_time, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('endTime') } }
        # Add one input object at a time. For example, first add a **WatermarkInput** object.   If you also need a audio, click **Add item** again and select **AudioInput**.   Repeat this process for **SubtitleInput** as needed.
        # 
        field :inputs, Crystalline::Nilable.new(Crystalline::Array.new(Crystalline::Union.new(Models::Components::VideoInput, Models::Components::WatermarkInput, Models::Components::AudioInput, Models::Components::SubtitleInput))), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('inputs') } }
        # "Tag a video in "key" : "value" pairs for searchable metadata. Maximum 10 entries, 255 characters each."
        # 
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }
        # UUID of the DRM configuration to be used.
        field :drm_configuration_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('drmConfigurationId') } }
        # Title of the media file.
        field :title, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('title') } }
        # The unique identifier of the user who created this media.
        field :creator_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('creatorId') } }
        # Generates subtitle files for audio/video files.
        # 
        field :subtitles, Crystalline::Nilable.new(Models::Operations::Subtitles), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('subtitles') } }
        # Enhance the quality and volume of the audio track. This is available for pre-recorded content only.
        # 
        field :optimize_audio, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('optimizeAudio') } }
        # The sourceAccess parameter determines whether the original media file is accessible. Set to true to enable access or false to restrict it
        field :source_access, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('sourceAccess') } }
        # Generates MP4 video up to 4K ("capped_4k"), m4a audio only ("audioOnly"), or both for offline viewing.
        # 
        field :mp4_support, Crystalline::Nilable.new(Models::Operations::DirectUploadVideoMediaMp4Support), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('mp4Support'), 'decoder': Utils.enum_from_string(Models::Operations::DirectUploadVideoMediaMp4Support, true) } }

        field :summary, Crystalline::Nilable.new(Models::Operations::Summary), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('summary') } }
        # Enable or disable the chapters feature for the media. Set to `true` to enable chapters or `false` to disable.
        # 
        field :chapters, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('chapters') } }
        # Enable or disable named entity extraction. Set to `true` to enable or `false` to disable.
        # 
        field :named_entities, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('namedEntities') } }

        field :moderation, Crystalline::Nilable.new(Models::Operations::DirectUploadVideoMediaModeration), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('moderation') } }

        field :access_restrictions, Crystalline::Nilable.new(Models::Operations::DirectUploadVideoMediaAccessRestrictions), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessRestrictions') } }
        # Determines if access to the streamed content is kept private, drm or available to all.
        field :access_policy, Crystalline::Nilable.new(Models::Operations::DirectUploadVideoMediaAccessPolicy), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessPolicy'), 'decoder': Utils.enum_from_string(Models::Operations::DirectUploadVideoMediaAccessPolicy, true) } }
        # Determines the highest quality resolution available.
        # 
        field :max_resolution, Crystalline::Nilable.new(Models::Operations::MaxResolution), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('maxResolution'), 'decoder': Utils.enum_from_string(Models::Operations::MaxResolution, true) } }
        # The quality tier applied to the media.
        field :media_quality, Crystalline::Nilable.new(Models::Operations::MediaQuality), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('mediaQuality'), 'decoder': Utils.enum_from_string(Models::Operations::MediaQuality, true) } }

        sig { params(start_time: T.nilable(::Float), end_time: T.nilable(::Float), inputs: T.nilable(T::Array[T.any(Models::Components::VideoInput, Models::Components::WatermarkInput, Models::Components::AudioInput, Models::Components::SubtitleInput)]), metadata: T.nilable(T::Hash[Symbol, ::String]), drm_configuration_id: T.nilable(::String), title: T.nilable(::String), creator_id: T.nilable(::String), subtitles: T.nilable(Models::Operations::Subtitles), optimize_audio: T.nilable(T::Boolean), source_access: T.nilable(T::Boolean), mp4_support: T.nilable(Models::Operations::DirectUploadVideoMediaMp4Support), summary: T.nilable(Models::Operations::Summary), chapters: T.nilable(T::Boolean), named_entities: T.nilable(T::Boolean), moderation: T.nilable(Models::Operations::DirectUploadVideoMediaModeration), access_restrictions: T.nilable(Models::Operations::DirectUploadVideoMediaAccessRestrictions), access_policy: T.nilable(Models::Operations::DirectUploadVideoMediaAccessPolicy), max_resolution: T.nilable(Models::Operations::MaxResolution), media_quality: T.nilable(Models::Operations::MediaQuality)).void }
        def initialize(start_time: nil, end_time: nil, inputs: nil, metadata: nil, drm_configuration_id: nil, title: nil, creator_id: nil, subtitles: nil, optimize_audio: nil, source_access: nil, mp4_support: nil, summary: nil, chapters: nil, named_entities: nil, moderation: nil, access_restrictions: nil, access_policy: Models::Operations::DirectUploadVideoMediaAccessPolicy::PUBLIC, max_resolution: Models::Operations::MaxResolution::ONE_THOUSAND_AND_EIGHTYP, media_quality: Models::Operations::MediaQuality::STANDARD)
          @start_time = start_time
          @end_time = end_time
          @inputs = inputs
          @metadata = metadata
          @drm_configuration_id = drm_configuration_id
          @title = title
          @creator_id = creator_id
          @subtitles = subtitles
          @optimize_audio = optimize_audio
          @source_access = source_access
          @mp4_support = mp4_support
          @summary = summary
          @chapters = chapters
          @named_entities = named_entities
          @moderation = moderation
          @access_restrictions = access_restrictions
          @access_policy = access_policy
          @max_resolution = max_resolution
          @media_quality = media_quality
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class

          [@start_time, @end_time, @inputs, @metadata, @drm_configuration_id,
           @title, @creator_id, @subtitles, @optimize_audio, @source_access,
           @mp4_support, @summary, @chapters, @named_entities, @moderation,
           @access_restrictions, @access_policy, @max_resolution, @media_quality] ==
            [other.start_time, other.end_time, other.inputs, other.metadata, other.drm_configuration_id,
             other.title, other.creator_id, other.subtitles, other.optimize_audio, other.source_access,
             other.mp4_support, other.summary, other.chapters, other.named_entities, other.moderation,
             other.access_restrictions, other.access_policy, other.max_resolution, other.media_quality]
        end
      end
    end
  end
end
