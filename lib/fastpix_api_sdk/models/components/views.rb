
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Displays the result of the request.
      class Views
        extend T::Sig
        include Crystalline::MetadataFields

        # It is a unique identifier associated with a specific workspace within the FastPix platform.
        # 
        field :workspace_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('workspaceId') } }
        # Events specifies the order of events journey of the video playback 
        # 
        field :events, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::Event)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('events') } }
        # Exit Before Video Start indicates whether a viewer abandoned the video before it started playing, typically due to long loading times.
        # 
        field :exit_before_video_start, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('exitBeforeVideoStart') } }
        # Experiment Name is used in A/B testing scenarios to categorize video views into different experiments.
        # 
        field :experiment_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('experimentName') } }
        # Insert Timestamp refers to the time instance when the view is started.
        # 
        field :insert_timestamp, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('insertTimestamp') } }
        # Player Autoplay On indicates whether the video player automatically initiated playback of the video content.
        # 
        field :player_autoplay_on, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerAutoplayOn') } }
        # Player Preload On indicates whether the player is configured to preload the video content upon page load.
        # 
        field :player_preload_on, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerPreloadOn') } }
        # Player Remote Played specifies if the video is being remotely played to devices such as AirPlay or Chromecast, obtained from the SDK.
        # 
        field :player_remote_played, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerRemotePlayed') } }
        # Used Fullscreen denotes whether the viewer utilized the full-screen mode while watching the video.
        # 
        field :used_full_screen, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('usedFullScreen') } }
        # Video Startup Failure is a boolean metric indicating whether a viewer encountered an error before the first frame of the video commenced playback.
        # 
        field :video_startup_failed, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoStartupFailed') } }
        # View Has Ad is a boolean metric indicating whether an advertisement played or attempted to play during the video view.
        # 
        field :view_has_ad, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewHasAd') } }
        # View ID is a unique identifier assigned to each individual video viewing session.
        # 
        field :view_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewId') } }
        # Operating System Version specifies the specific version of the operating system being used by the viewer
        # 
        field :os_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('osVersion') } }
        # The Name associated with the asnId.
        # 
        field :asn_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('asnName') } }
        # The unique identifier assigned to an Autonomous System (AS) on the Internet. The ASN is used to identify and exchange routing information between different networks.
        # 
        field :asn_id, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('asnId') } }
        # The media Id value if the video asset is internal to FastPix.
        # 
        field :media_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mediaId') } }
        # Buffer Count represents the number of rebuffering events occurring during the video view.
        # 
        field :buffer_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('bufferCount') } }
        # Buffer Fill indicates the total time, in milliseconds, that viewers wait for rebuffering per video view.         
        # 
        field :buffer_fill, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('bufferFill') } }
        # Buffer Frequency measures the rate at which rebuffering events occur, expressed as events per millisecond.
        # 
        field :buffer_frequency, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('BufferFrequency') } }
        # Content Delivery Network (CDN) refers to the network infrastructure responsible for delivering the video content to the viewer.        
        # 
        field :cdn, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('cdn') } }
        # City indicates the geographical location of the viewer accessing the video content.        
        # 
        field :city, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('city') } }
        # Continent represents the continent name of the viewer accessing the video content.    
        # 
        field :continent, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('continent') } }
        # Country Code denotes the two-letter ISO code representing the country of origin for the viewer accessing the video content.      
        # 
        field :country_code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('countryCode') } }
        # Country represents the coded text that represents the country name of viewer accessing the video content.      
        # 
        field :country, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('country') } }
        # User defined metadata. Only accessible once it is enabled in the organization settings.
        # 
        field :custom1, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('custom1') } }
        # User defined metadata. Only accessible once it is enabled in the organization settings.
        # 
        field :custom2, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('custom2') } }
        # User defined metadata. Only accessible once it is enabled in the organization settings.
        # 
        field :custom3, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('custom3') } }
        # User defined metadata. Only accessible once it is enabled in the organization settings.
        # 
        field :custom4, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('custom4') } }
        # User defined metadata. Only accessible once it is enabled in the organization settings.
        # 
        field :custom5, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('custom5') } }
        # User defined metadata. Only accessible once it is enabled in the organization settings.
        # 
        field :custom6, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('custom6') } }
        # User defined metadata. Only accessible once it is enabled in the organization settings.
        # 
        field :custom7, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('custom7') } }
        # User defined metadata. Only accessible once it is enabled in the organization settings.
        # 
        field :custom8, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('custom8') } }
        # User defined metadata. Only accessible once it is enabled in the organization settings.
        # 
        field :custom9, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('custom9') } }
        # User defined metadata. Only accessible once it is enabled in the organization settings.
        # 
        field :custom10, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('custom10') } }
        # Latitude refers to the geographical coordinate representing the north-south position of the viewer's location, truncated to one decimal place.
        # 
        field :latitude, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('latitude') } }
        # FastPix Live Stream ID is the unique identifier associated with a live stream video media within the FastPix Video platform.
        # 
        field :fp_live_stream_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('fpLiveStreamId') } }
        # Live Stream Latency measures the average time taken from the point of ingest to the point of display for live stream video views.
        # 
        field :live_stream_latency, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('liveStreamLatency') } }
        # Longitude denotes the geographical coordinate representing the east-west position of the viewer's location, truncated to one decimal place.
        # 
        field :longitude, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('longitude') } }
        # Page Load Time measures the time from when the user initiates loading the page to when all resources are loaded on the page.
        # 
        field :page_load_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('pageLoadTime') } }
        # Page Context provides contextual information about the type of page being accessed.
        # 
        field :page_context, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('pageContext') } }
        # View Page URL denotes the URL address of the web page where the video content is being accessed.
        # 
        field :view_page_url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewPageUrl') } }
        # FastPix Playback ID refers to the unique identifier associated with the playback instance of a video, particularly used in FastPix Video platform.
        # 
        field :fp_playback_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('fpPlaybackId') } }
        # Playback Success Score represents a numerical value indicating the success or quality of the video playback experience.
        # 
        field :playback_score, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playbackScore') } }
        # Error Code is an identifier representing a specific type of error that occurred during video playback, potentially leading to playback failure.
        # 
        field :error_code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('errorCode') } }
        # Error Message is a descriptive message generated by the video player when an error occurs during playback, associated with an error code.
        # 
        field :error_message, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('errorMessage') } }
        # Player Height refers to the vertical dimension, measured in pixels, of the video player as it appears on the webpage.
        # 
        field :player_height, Crystalline::Nilable.new(Crystalline::Union.new(::String, ::Float)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerHeight') } }
        # Player Instance ID is a unique identifier that distinguishes each instance of the Player class created when initializing a video.
        # 
        field :player_instance_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerInstanceId') } }
        # Player Language indicates the language used for text elements within the video player interface.
        # 
        field :player_language, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerLanguage') } }
        # FastPix SDK Name identifies the name of the FastPix Player SDK utilized within the player workspace.
        # 
        field :fp_sdk, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('fpSdk') } }
        # FastPix SDK Version specifies the version of the FastPix Player SDK integrated into the player.
        # 
        field :fp_sdk_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('fpSdkVersion') } }
        # Player Name serves to differentiate various configurations or types of players used across the website or application.
        # 
        field :player_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerName') } }
        # Player Poster refers to the image displayed as a preview before the video playback begins.
        # 
        field :player_poster, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerPoster') } }
        # Player Software Version indicates the version number of the player software installed.
        # 
        field :player_software_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerSoftwareVersion') } }
        # Player Software Name denotes the software utilized for video playback within the player workspace.
        # 
        field :player_software_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerSoftwareName') } }
        # Video Source Domain identifies the domain from which the video source originates.
        # 
        field :video_source_domain, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoSourceDomain') } }
        # Video Source Duration represents the duration of the video source content, measured in milliseconds.
        # 
        field :video_source_duration, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoSourceDuration') } }
        # Player Source Height denotes the vertical dimension, measured in pixels, of the source video content being transmitted to the player.
        # 
        field :player_source_height, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerSourceHeight') } }
        # Video Source Hostname represents the hostname of the video
        # 
        field :video_source_hostname, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoSourceHostname') } }
        # Video Source Stream Type denotes the type of stream used by the player, although it is currently unused.
        # 
        field :video_source_stream_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoSourceStreamType') } }
        # Video Source Type denotes the format of the video source as determined by the player, including formats
        # 
        field :video_source_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoSourceType') } }
        # Player Source URL refers to the URL of the video source accessed by the player.
        # 
        field :video_source_url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoSourceUrl') } }
        # Source Width represents the width of the source video as perceived by the player, typically measured in pixels.
        # 
        field :player_source_width, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerSourceWidth') } }
        # Player Initialisation Time measures the duration, in milliseconds, from the initialization of the player within the webpage to its readiness to receive further instructions.
        # 
        field :player_initialization_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerInitializationTime') } }
        # Player Version indicates the version of the player used to render the video content. It is often utilized for performance comparison between different player versions.
        # 
        field :player_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerVersion') } }
        # Player Width refers to the width of the player displayed within the webpage, measured in pixels.
        # 
        field :player_width, Crystalline::Nilable.new(Crystalline::Union.new(::String, ::Float)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerWidth') } }
        # Render Quality Score is a decimal value representing the score indicating the perceived quality of the video.
        # 
        field :render_quality_score, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('renderQualityScore') } }
        # Buffer Ratio refers to the percentage of time during video playback where the viewer experiences buffering or rebuffering events.  
        # 
        field :buffer_ratio, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('bufferRatio') } }
        # Stability Score quantifies the smoothness of video playback, typically represented as a decimal value.
        # 
        field :stability_score, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('stabilityScore') } }
        # Region denotes the geographical region of the viewer accessing the video content.
        # 
        field :region, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('region') } }
        # Session ID refers to the unique identifier tracking a viewer's session within the FastPix platform.
        # 
        field :session_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('sessionId') } }
        # Startup Time Score evaluates the startup performance of the player, usually represented as a decimal value      
        # 
        field :startup_score, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('startupScore') } }
        # Sub Property ID denotes the unique identifier assigned to FastPix properties, previously linked with a specific workspace.
        # 
        field :sub_property_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('subPropertyId') } }
        # Video Startup Time measures the duration, in milliseconds, from the initialization of the player within the webpage to its readiness to receive further instructions.
        # 
        field :video_startup_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoStartupTime') } }
        # Updated Timestamp refers to when the record is updated to a particular Video.
        # 
        field :updated_timestamp, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('updatedTimestamp') } }
        # Video Content Type specifies the classification of the video content.
        # 
        field :video_content_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoContentType') } }
        # Video Duration represents the length of the video, provided in milliseconds, typically supplied to FastPix via custom metadata.
        # 
        field :video_duration, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoDuration') } }
        # Video ID refers to an internal identifier assigned by the user or system to uniquely identify a particular video.
        # 
        field :video_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoId') } }
        # Video Language denotes the primary audio language of the video content, assuming it remains unchanged after playback initiation.
        # 
        field :video_language, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoLanguage') } }
        # Video Series denotes the name of a series to which the video content belongs.
        # 
        field :video_series, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoSeries') } }
        # Video Title refers to the title of the video content being viewed.
        # 
        field :video_title, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoTitle') } }
        # Average Request Latency average time it takes for a request to be made and processed during video playback
        # 
        field :avg_request_latency, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('avgRequestLatency') } }
        # Average Request Throughput refers to the average throughput or data transfer rate of HTTP requests made during video playback
        # 
        field :avg_request_throughput, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('avgRequestThroughput') } }
        # DRM Type indicates the type of Digital Rights Management (DRM) utilized during video playback
        # 
        field :drm_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('drmType') } }
        # Dropped Frame Count represents the number of frames dropped by the video player during playback.
        # 
        field :dropped_frame_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('droppedFrameCount') } }
        # View End refers to the date and time, in Coordinated Universal Time (UTC), when the video viewing session concluded.
        # 
        field :view_end, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewEnd') } }
        # Maximum Downscale Percentage represents the highest percentage of downscaling applied to the video during the view.
        # 
        field :max_downscaling, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('maxDownscaling') } }
        # View Max Playhead Position represents the furthest point reached by the playhead during the video view, measured in milliseconds.
        # 
        field :view_max_playhead_position, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewMaxPlayheadPosition') } }
        # Max request Latency refers to the maximum rate of data transfer (throughput) during requests made by the playback.
        # 
        field :max_request_latency, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('maxRequestLatency') } }
        # Maximum Upscale Percentage represents the highest percentage of upscaling applied to the video during the view.
        # 
        field :max_upscaling, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('maxUpscaling') } }
        # Playing Time denotes the total duration of time the video content was actively playing during the view, excluding time spent buffering, seeking, or joining.
        # 
        field :view_playing_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewPlayingTime') } }
        # View Seeked Count signifies the number of times the viewer attempted to seek to a new location within the video.
        # 
        field :view_seeked_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewSeekedCount') } }
        # View Seeked Duration indicates the total duration of time spent waiting for playback to resume after the viewer seeks to a new location. Seek Latency metric in the Dashboard is derived by dividing this value by the view_seek_count.
        # 
        field :view_seeked_duration, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewSeekedDuration') } }
        # View Start refers to the date and time, in Coordinated Universal Time (UTC), when the video viewing session commenced.
        # 
        field :view_start, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewStart') } }
        # View Total content Playback Time represents the cumulative duration of video content watched by the viewer, measured in milliseconds. This metric is internally utilized to calculate upscale and downscale percentages.
        # 
        field :view_total_content_playback_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewTotalContentPlaybackTime') } }
        # Average Downscaling refers to the average reduction in video resolution or quality during the playback of video content.
        # 
        field :avg_downscaling, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('avgDownscaling') } }
        # Average Upscaling refers to the average resolution of the video source is lower than the resolution of the playback device or screen.
        # 
        field :avg_upscaling, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('avgUpscaling') } }
        # Browser denotes the software application utilized by the viewer to access and watch the video content
        # 
        field :browser_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('browserName') } }
        # Browser version signifies the specific version of the browser software employed by the viewer
        # 
        field :browser_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('browserVersion') } }
        # Connection Type signifies the type of network connection utilized by the viewer's device
        # 
        field :connectiontype, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('connectiontype') } }
        # Device Type denotes the classification of the device used by the viewer
        # 
        field :device_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('deviceType') } }
        # Device Manufacturer indicates the brand or manufacturer of the device used by the viewer.
        # 
        field :device_manufacturer, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('deviceManufacturer') } }
        # Device Model represents the specific model of the device used by the viewer.
        # 
        field :device_model, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('deviceModel') } }
        # Device Name refers to the name or label assigned to the device used by the viewer.
        # 
        field :device_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('deviceName') } }
        # Quality Of Experience Score quantifies the overall viewer experience based on various metrics, providing a decimal score to assess the quality of the viewing experience.        
        # 
        field :quality_of_experience_score, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('qualityOfExperienceScore') } }
        # Operating System signifies the name of software platform utilized by the viewer.
        # 
        field :os_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('osName') } }
        # User Agent represents the user agent string transmitted by the viewer's device to identify itself to the server, typically including information about the device and browser.
        # 
        field :user_agent, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('userAgent') } }
        # Viewer ID refers to a customer-defined identifier representing the viewer who is watching the video stream. It should be anonymized and not contain any personally identifiable information.
        # 
        field :viewer_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewerId') } }
        # Total Watch Time denotes the total duration of video content watched by the viewer, encompassing startup time, playing time, and potential rebuffering time, measured in milliseconds.
        # 
        field :total_watch_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('totalWatchTime') } }
        # Average Bitrate represents the average bitrate of the video content watched by the viewer, expressed in bits per second (bps). This metric provides insight into the quality of the video stream.
        # 
        field :average_bitrate, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('averageBitrate') } }
        # Jump Latency refers to the delay or latency experienced when there is a jump or seek action performed by the viewer while watching a video. 
        # 
        field :jump_latency, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('jumpLatency') } }
        # Player Resolution refers to the resolution of the video player window or viewport where the video content is being displayed.
        # 
        field :player_resolution, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('playerResolution') } }
        # videoResolution refers to the resolution of the video being played.
        # 
        field :video_resolution, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoResolution') } }

        sig { params(workspace_id: T.nilable(::String), events: T.nilable(T::Array[Models::Components::Event]), exit_before_video_start: T.nilable(T::Boolean), experiment_name: T.nilable(::String), insert_timestamp: T.nilable(::String), player_autoplay_on: T.nilable(T::Boolean), player_preload_on: T.nilable(T::Boolean), player_remote_played: T.nilable(T::Boolean), used_full_screen: T.nilable(T::Boolean), video_startup_failed: T.nilable(T::Boolean), view_has_ad: T.nilable(T::Boolean), view_id: T.nilable(::String), os_version: T.nilable(::String), asn_name: T.nilable(::String), asn_id: T.nilable(::Integer), media_id: T.nilable(::String), buffer_count: T.nilable(::Integer), buffer_fill: T.nilable(::Integer), buffer_frequency: T.nilable(::Float), cdn: T.nilable(::String), city: T.nilable(::String), continent: T.nilable(::String), country_code: T.nilable(::String), country: T.nilable(::String), custom1: T.nilable(::String), custom2: T.nilable(::String), custom3: T.nilable(::String), custom4: T.nilable(::String), custom5: T.nilable(::String), custom6: T.nilable(::String), custom7: T.nilable(::String), custom8: T.nilable(::String), custom9: T.nilable(::String), custom10: T.nilable(::String), latitude: T.nilable(::String), fp_live_stream_id: T.nilable(::String), live_stream_latency: T.nilable(::Float), longitude: T.nilable(::String), page_load_time: T.nilable(::Integer), page_context: T.nilable(::String), view_page_url: T.nilable(::String), fp_playback_id: T.nilable(::String), playback_score: T.nilable(::Float), error_code: T.nilable(::String), error_message: T.nilable(::String), player_height: T.nilable(T.any(::String, ::Float)), player_instance_id: T.nilable(::String), player_language: T.nilable(::String), fp_sdk: T.nilable(::String), fp_sdk_version: T.nilable(::String), player_name: T.nilable(::String), player_poster: T.nilable(::String), player_software_version: T.nilable(::String), player_software_name: T.nilable(::String), video_source_domain: T.nilable(::String), video_source_duration: T.nilable(::Integer), player_source_height: T.nilable(::Integer), video_source_hostname: T.nilable(::String), video_source_stream_type: T.nilable(::String), video_source_type: T.nilable(::String), video_source_url: T.nilable(::String), player_source_width: T.nilable(::Integer), player_initialization_time: T.nilable(::Integer), player_version: T.nilable(::String), player_width: T.nilable(T.any(::String, ::Float)), render_quality_score: T.nilable(::Float), buffer_ratio: T.nilable(::Float), stability_score: T.nilable(::Float), region: T.nilable(::String), session_id: T.nilable(::String), startup_score: T.nilable(::Float), sub_property_id: T.nilable(::String), video_startup_time: T.nilable(::Integer), updated_timestamp: T.nilable(::String), video_content_type: T.nilable(::String), video_duration: T.nilable(::Integer), video_id: T.nilable(::String), video_language: T.nilable(::String), video_series: T.nilable(::String), video_title: T.nilable(::String), avg_request_latency: T.nilable(::Float), avg_request_throughput: T.nilable(::Float), drm_type: T.nilable(::String), dropped_frame_count: T.nilable(::Integer), view_end: T.nilable(::String), max_downscaling: T.nilable(::Float), view_max_playhead_position: T.nilable(::Integer), max_request_latency: T.nilable(::Float), max_upscaling: T.nilable(::Float), view_playing_time: T.nilable(::Integer), view_seeked_count: T.nilable(::Integer), view_seeked_duration: T.nilable(::Integer), view_start: T.nilable(::String), view_total_content_playback_time: T.nilable(::Integer), avg_downscaling: T.nilable(::Float), avg_upscaling: T.nilable(::Float), browser_name: T.nilable(::String), browser_version: T.nilable(::String), connectiontype: T.nilable(::String), device_type: T.nilable(::String), device_manufacturer: T.nilable(::String), device_model: T.nilable(::String), device_name: T.nilable(::String), quality_of_experience_score: T.nilable(::Float), os_name: T.nilable(::String), user_agent: T.nilable(::String), viewer_id: T.nilable(::String), total_watch_time: T.nilable(::Integer), average_bitrate: T.nilable(::Float), jump_latency: T.nilable(::Float), player_resolution: T.nilable(::String), video_resolution: T.nilable(::String)).void }
        def initialize(workspace_id: nil, events: nil, exit_before_video_start: nil, experiment_name: nil, insert_timestamp: nil, player_autoplay_on: nil, player_preload_on: nil, player_remote_played: nil, used_full_screen: nil, video_startup_failed: nil, view_has_ad: nil, view_id: nil, os_version: nil, asn_name: nil, asn_id: nil, media_id: nil, buffer_count: nil, buffer_fill: nil, buffer_frequency: nil, cdn: nil, city: nil, continent: nil, country_code: nil, country: nil, custom1: nil, custom2: nil, custom3: nil, custom4: nil, custom5: nil, custom6: nil, custom7: nil, custom8: nil, custom9: nil, custom10: nil, latitude: nil, fp_live_stream_id: nil, live_stream_latency: nil, longitude: nil, page_load_time: nil, page_context: nil, view_page_url: nil, fp_playback_id: nil, playback_score: nil, error_code: nil, error_message: nil, player_height: nil, player_instance_id: nil, player_language: nil, fp_sdk: nil, fp_sdk_version: nil, player_name: nil, player_poster: nil, player_software_version: nil, player_software_name: nil, video_source_domain: nil, video_source_duration: nil, player_source_height: nil, video_source_hostname: nil, video_source_stream_type: nil, video_source_type: nil, video_source_url: nil, player_source_width: nil, player_initialization_time: nil, player_version: nil, player_width: nil, render_quality_score: nil, buffer_ratio: nil, stability_score: nil, region: nil, session_id: nil, startup_score: nil, sub_property_id: nil, video_startup_time: nil, updated_timestamp: nil, video_content_type: nil, video_duration: nil, video_id: nil, video_language: nil, video_series: nil, video_title: nil, avg_request_latency: nil, avg_request_throughput: nil, drm_type: nil, dropped_frame_count: nil, view_end: nil, max_downscaling: nil, view_max_playhead_position: nil, max_request_latency: nil, max_upscaling: nil, view_playing_time: nil, view_seeked_count: nil, view_seeked_duration: nil, view_start: nil, view_total_content_playback_time: nil, avg_downscaling: nil, avg_upscaling: nil, browser_name: nil, browser_version: nil, connectiontype: nil, device_type: nil, device_manufacturer: nil, device_model: nil, device_name: nil, quality_of_experience_score: nil, os_name: nil, user_agent: nil, viewer_id: nil, total_watch_time: nil, average_bitrate: nil, jump_latency: nil, player_resolution: nil, video_resolution: nil)
          @workspace_id = workspace_id
          @events = events
          @exit_before_video_start = exit_before_video_start
          @experiment_name = experiment_name
          @insert_timestamp = insert_timestamp
          @player_autoplay_on = player_autoplay_on
          @player_preload_on = player_preload_on
          @player_remote_played = player_remote_played
          @used_full_screen = used_full_screen
          @video_startup_failed = video_startup_failed
          @view_has_ad = view_has_ad
          @view_id = view_id
          @os_version = os_version
          @asn_name = asn_name
          @asn_id = asn_id
          @media_id = media_id
          @buffer_count = buffer_count
          @buffer_fill = buffer_fill
          @buffer_frequency = buffer_frequency
          @cdn = cdn
          @city = city
          @continent = continent
          @country_code = country_code
          @country = country
          @custom1 = custom1
          @custom2 = custom2
          @custom3 = custom3
          @custom4 = custom4
          @custom5 = custom5
          @custom6 = custom6
          @custom7 = custom7
          @custom8 = custom8
          @custom9 = custom9
          @custom10 = custom10
          @latitude = latitude
          @fp_live_stream_id = fp_live_stream_id
          @live_stream_latency = live_stream_latency
          @longitude = longitude
          @page_load_time = page_load_time
          @page_context = page_context
          @view_page_url = view_page_url
          @fp_playback_id = fp_playback_id
          @playback_score = playback_score
          @error_code = error_code
          @error_message = error_message
          @player_height = player_height
          @player_instance_id = player_instance_id
          @player_language = player_language
          @fp_sdk = fp_sdk
          @fp_sdk_version = fp_sdk_version
          @player_name = player_name
          @player_poster = player_poster
          @player_software_version = player_software_version
          @player_software_name = player_software_name
          @video_source_domain = video_source_domain
          @video_source_duration = video_source_duration
          @player_source_height = player_source_height
          @video_source_hostname = video_source_hostname
          @video_source_stream_type = video_source_stream_type
          @video_source_type = video_source_type
          @video_source_url = video_source_url
          @player_source_width = player_source_width
          @player_initialization_time = player_initialization_time
          @player_version = player_version
          @player_width = player_width
          @render_quality_score = render_quality_score
          @buffer_ratio = buffer_ratio
          @stability_score = stability_score
          @region = region
          @session_id = session_id
          @startup_score = startup_score
          @sub_property_id = sub_property_id
          @video_startup_time = video_startup_time
          @updated_timestamp = updated_timestamp
          @video_content_type = video_content_type
          @video_duration = video_duration
          @video_id = video_id
          @video_language = video_language
          @video_series = video_series
          @video_title = video_title
          @avg_request_latency = avg_request_latency
          @avg_request_throughput = avg_request_throughput
          @drm_type = drm_type
          @dropped_frame_count = dropped_frame_count
          @view_end = view_end
          @max_downscaling = max_downscaling
          @view_max_playhead_position = view_max_playhead_position
          @max_request_latency = max_request_latency
          @max_upscaling = max_upscaling
          @view_playing_time = view_playing_time
          @view_seeked_count = view_seeked_count
          @view_seeked_duration = view_seeked_duration
          @view_start = view_start
          @view_total_content_playback_time = view_total_content_playback_time
          @avg_downscaling = avg_downscaling
          @avg_upscaling = avg_upscaling
          @browser_name = browser_name
          @browser_version = browser_version
          @connectiontype = connectiontype
          @device_type = device_type
          @device_manufacturer = device_manufacturer
          @device_model = device_model
          @device_name = device_name
          @quality_of_experience_score = quality_of_experience_score
          @os_name = os_name
          @user_agent = user_agent
          @viewer_id = viewer_id
          @total_watch_time = total_watch_time
          @average_bitrate = average_bitrate
          @jump_latency = jump_latency
          @player_resolution = player_resolution
          @video_resolution = video_resolution
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @workspace_id == other.workspace_id
          return false unless @events == other.events
          return false unless @exit_before_video_start == other.exit_before_video_start
          return false unless @experiment_name == other.experiment_name
          return false unless @insert_timestamp == other.insert_timestamp
          return false unless @player_autoplay_on == other.player_autoplay_on
          return false unless @player_preload_on == other.player_preload_on
          return false unless @player_remote_played == other.player_remote_played
          return false unless @used_full_screen == other.used_full_screen
          return false unless @video_startup_failed == other.video_startup_failed
          return false unless @view_has_ad == other.view_has_ad
          return false unless @view_id == other.view_id
          return false unless @os_version == other.os_version
          return false unless @asn_name == other.asn_name
          return false unless @asn_id == other.asn_id
          return false unless @media_id == other.media_id
          return false unless @buffer_count == other.buffer_count
          return false unless @buffer_fill == other.buffer_fill
          return false unless @buffer_frequency == other.buffer_frequency
          return false unless @cdn == other.cdn
          return false unless @city == other.city
          return false unless @continent == other.continent
          return false unless @country_code == other.country_code
          return false unless @country == other.country
          return false unless @custom1 == other.custom1
          return false unless @custom2 == other.custom2
          return false unless @custom3 == other.custom3
          return false unless @custom4 == other.custom4
          return false unless @custom5 == other.custom5
          return false unless @custom6 == other.custom6
          return false unless @custom7 == other.custom7
          return false unless @custom8 == other.custom8
          return false unless @custom9 == other.custom9
          return false unless @custom10 == other.custom10
          return false unless @latitude == other.latitude
          return false unless @fp_live_stream_id == other.fp_live_stream_id
          return false unless @live_stream_latency == other.live_stream_latency
          return false unless @longitude == other.longitude
          return false unless @page_load_time == other.page_load_time
          return false unless @page_context == other.page_context
          return false unless @view_page_url == other.view_page_url
          return false unless @fp_playback_id == other.fp_playback_id
          return false unless @playback_score == other.playback_score
          return false unless @error_code == other.error_code
          return false unless @error_message == other.error_message
          return false unless @player_height == other.player_height
          return false unless @player_instance_id == other.player_instance_id
          return false unless @player_language == other.player_language
          return false unless @fp_sdk == other.fp_sdk
          return false unless @fp_sdk_version == other.fp_sdk_version
          return false unless @player_name == other.player_name
          return false unless @player_poster == other.player_poster
          return false unless @player_software_version == other.player_software_version
          return false unless @player_software_name == other.player_software_name
          return false unless @video_source_domain == other.video_source_domain
          return false unless @video_source_duration == other.video_source_duration
          return false unless @player_source_height == other.player_source_height
          return false unless @video_source_hostname == other.video_source_hostname
          return false unless @video_source_stream_type == other.video_source_stream_type
          return false unless @video_source_type == other.video_source_type
          return false unless @video_source_url == other.video_source_url
          return false unless @player_source_width == other.player_source_width
          return false unless @player_initialization_time == other.player_initialization_time
          return false unless @player_version == other.player_version
          return false unless @player_width == other.player_width
          return false unless @render_quality_score == other.render_quality_score
          return false unless @buffer_ratio == other.buffer_ratio
          return false unless @stability_score == other.stability_score
          return false unless @region == other.region
          return false unless @session_id == other.session_id
          return false unless @startup_score == other.startup_score
          return false unless @sub_property_id == other.sub_property_id
          return false unless @video_startup_time == other.video_startup_time
          return false unless @updated_timestamp == other.updated_timestamp
          return false unless @video_content_type == other.video_content_type
          return false unless @video_duration == other.video_duration
          return false unless @video_id == other.video_id
          return false unless @video_language == other.video_language
          return false unless @video_series == other.video_series
          return false unless @video_title == other.video_title
          return false unless @avg_request_latency == other.avg_request_latency
          return false unless @avg_request_throughput == other.avg_request_throughput
          return false unless @drm_type == other.drm_type
          return false unless @dropped_frame_count == other.dropped_frame_count
          return false unless @view_end == other.view_end
          return false unless @max_downscaling == other.max_downscaling
          return false unless @view_max_playhead_position == other.view_max_playhead_position
          return false unless @max_request_latency == other.max_request_latency
          return false unless @max_upscaling == other.max_upscaling
          return false unless @view_playing_time == other.view_playing_time
          return false unless @view_seeked_count == other.view_seeked_count
          return false unless @view_seeked_duration == other.view_seeked_duration
          return false unless @view_start == other.view_start
          return false unless @view_total_content_playback_time == other.view_total_content_playback_time
          return false unless @avg_downscaling == other.avg_downscaling
          return false unless @avg_upscaling == other.avg_upscaling
          return false unless @browser_name == other.browser_name
          return false unless @browser_version == other.browser_version
          return false unless @connectiontype == other.connectiontype
          return false unless @device_type == other.device_type
          return false unless @device_manufacturer == other.device_manufacturer
          return false unless @device_model == other.device_model
          return false unless @device_name == other.device_name
          return false unless @quality_of_experience_score == other.quality_of_experience_score
          return false unless @os_name == other.os_name
          return false unless @user_agent == other.user_agent
          return false unless @viewer_id == other.viewer_id
          return false unless @total_watch_time == other.total_watch_time
          return false unless @average_bitrate == other.average_bitrate
          return false unless @jump_latency == other.jump_latency
          return false unless @player_resolution == other.player_resolution
          return false unless @video_resolution == other.video_resolution
          true
        end
      end
    end
  end
end
