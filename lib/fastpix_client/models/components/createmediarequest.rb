# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class CreateMediaRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Add one input object at a time. For example, first add a **VideoInput** object.   If you also need a watermark, click **Add item** again and select **WatermarkInput**.   Repeat this process for **AudioInput** or **SubtitleInput** as needed. For a complete explanation of how media uploads from URL and processing work, refer to the  
        #         <a href="https://docs.fastpix.io/docs/video-on-demand-overview" target="_blank">FastPix Video on Demand Overview</a>.
        # 
        field :inputs, Crystalline::Array.new(Crystalline::Union.new(Models::Components::PullVideoInput, Models::Components::WatermarkInput, Models::Components::AudioInput, Models::Components::SubtitleInput)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('inputs'), required: true } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key" : "value" pairs. Dynamic metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        # 
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }
        # UUID of the DRM configuration to be used
        field :drm_configuration_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('drmConfigurationId') } }
        # Title of the media file.
        field :title, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('title') } }
        # The unique identifier of the user who created this media.
        field :creator_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('creatorId') } }
        # Generates subtitle files for audio/video files.
        # 
        field :subtitles, Crystalline::Nilable.new(Models::Components::Subtitles), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('subtitles') } }
        # "capped_4k": Generates an mp4 video file up to 4k resolution "audioOnly": Generates an m4a audio file of the media file "audioOnly,capped_4k": Generates both video and audio media files for offline viewing
        # 
        field :mp4_support, Crystalline::Nilable.new(Models::Components::CreateMediaRequestMp4Support), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('mp4Support'), 'decoder': Utils.enum_from_string(Models::Components::CreateMediaRequestMp4Support, true) } }
        # The sourceAccess parameter determines whether the original media file is accessible. Set to true to enable access or false to restrict it
        field :source_access, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('sourceAccess') } }
        # normalize volume of the audio track. This is available for pre-recorded content only.
        # 
        field :optimize_audio, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('optimizeAudio') } }

        field :summary, Crystalline::Nilable.new(Models::Components::Summary), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('summary') } }
        # Enable or disable the chapters feature for the media. Set to `true` to enable chapters or `false` to disable.
        # 
        field :chapters, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('chapters') } }
        # Enable or disable named entity extraction. Set to `true` to enable or `false` to disable.
        # 
        field :named_entities, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('namedEntities') } }

        field :moderation, Crystalline::Nilable.new(Models::Components::Moderation), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('moderation') } }

        field :access_restrictions, Crystalline::Nilable.new(Models::Components::CreateMediaRequestAccessRestrictions), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessRestrictions') } }
        # Determines whether access to the streamed content is kept private or available to all.
        # 
        field :access_policy, Crystalline::Nilable.new(Models::Components::CreateMediaRequestAccessPolicy), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessPolicy'), 'decoder': Utils.enum_from_string(Models::Components::CreateMediaRequestAccessPolicy, true) } }
        # The maximum resolution tier defines the highest quality at which your media is available.
        # 
        field :max_resolution, Crystalline::Nilable.new(Models::Components::CreateMediaRequestMaxResolution), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('maxResolution'), 'decoder': Utils.enum_from_string(Models::Components::CreateMediaRequestMaxResolution, true) } }
        # The quality tier applied to the media.
        field :media_quality, Crystalline::Nilable.new(Models::Components::CreateMediaRequestMediaQuality), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('mediaQuality'), 'decoder': Utils.enum_from_string(Models::Components::CreateMediaRequestMediaQuality, true) } }

        sig { params(inputs: T::Array[T.any(Models::Components::PullVideoInput, Models::Components::WatermarkInput, Models::Components::AudioInput, Models::Components::SubtitleInput)], metadata: T.nilable(T::Hash[Symbol, ::String]), drm_configuration_id: T.nilable(::String), title: T.nilable(::String), creator_id: T.nilable(::String), subtitles: T.nilable(Models::Components::Subtitles), mp4_support: T.nilable(Models::Components::CreateMediaRequestMp4Support), source_access: T.nilable(T::Boolean), optimize_audio: T.nilable(T::Boolean), summary: T.nilable(Models::Components::Summary), chapters: T.nilable(T::Boolean), named_entities: T.nilable(T::Boolean), moderation: T.nilable(Models::Components::Moderation), access_restrictions: T.nilable(Models::Components::CreateMediaRequestAccessRestrictions), access_policy: T.nilable(Models::Components::CreateMediaRequestAccessPolicy), max_resolution: T.nilable(Models::Components::CreateMediaRequestMaxResolution), media_quality: T.nilable(Models::Components::CreateMediaRequestMediaQuality)).void }
        def initialize(inputs:, metadata: nil, drm_configuration_id: nil, title: nil, creator_id: nil, subtitles: nil, mp4_support: nil, source_access: nil, optimize_audio: nil, summary: nil, chapters: nil, named_entities: nil, moderation: nil, access_restrictions: nil, access_policy: Models::Components::CreateMediaRequestAccessPolicy::PUBLIC, max_resolution: Models::Components::CreateMediaRequestMaxResolution::ONE_THOUSAND_AND_EIGHTYP, media_quality: Models::Components::CreateMediaRequestMediaQuality::STANDARD)
          @inputs = inputs
          @metadata = metadata
          @drm_configuration_id = drm_configuration_id
          @title = title
          @creator_id = creator_id
          @subtitles = subtitles
          @mp4_support = mp4_support
          @source_access = source_access
          @optimize_audio = optimize_audio
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
          return false unless @inputs == other.inputs
          return false unless @metadata == other.metadata
          return false unless @drm_configuration_id == other.drm_configuration_id
          return false unless @title == other.title
          return false unless @creator_id == other.creator_id
          return false unless @subtitles == other.subtitles
          return false unless @mp4_support == other.mp4_support
          return false unless @source_access == other.source_access
          return false unless @optimize_audio == other.optimize_audio
          return false unless @summary == other.summary
          return false unless @chapters == other.chapters
          return false unless @named_entities == other.named_entities
          return false unless @moderation == other.moderation
          return false unless @access_restrictions == other.access_restrictions
          return false unless @access_policy == other.access_policy
          return false unless @max_resolution == other.max_resolution
          return false unless @media_quality == other.media_quality
          true
        end
      end
    end
  end
end
