# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Displays the result of the request.
      class Views
        extend T::Sig
        include Crystalline::MetadataFields

        # Beacon Domain specifies the domain endpoint used by the player or SDK to send analytics or tracking beacons for playback events.
        # 
        field :beacon_domain, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('beaconDomain') } }
        # User defined metadata. Only accessible once it is enabled in the organization settings.
        # 
        field :custom, Crystalline::Nilable.new(Models::Components::Custom2), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('custom') } }
        # Exit Before Video Start indicates whether a viewer abandoned the video before it started playing, typically due to long loading times.
        # 
        field :exit_before_video_start, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('exitBeforeVideoStart') } }
        # Insert Timestamp refers to the time instance when the view is started.
        # 
        field :insert_timestamp, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('insertTimestamp') } }
        # Represents the IP address of the user or device that initiated the playback session.
        # 
        field :ip_address, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('ipAddress') } }
        # Operating System Version specifies the specific version of the operating system being used by the viewer
        # 
        field :os_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('osVersion') } }
        # Player Autoplay On indicates whether the video player automatically initiated playback of the video content.
        # 
        field :player_autoplay_on, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerAutoplayOn') } }
        # Player Preload On indicates whether the player is configured to preload the video content upon page load.
        # 
        field :player_preload_on, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerPreloadOn') } }
        # Player Remote Played specifies if the video is being remotely played to devices such as AirPlay or Chromecast, obtained from the SDK.
        # 
        field :player_remote_played, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerRemotePlayed') } }
        # Used Fullscreen denotes whether the viewer utilized the full-screen mode while watching the video.
        # 
        field :used_full_screen, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('usedFullScreen') } }
        # Video Startup Failure is a boolean metric indicating whether a viewer encountered an error before the first frame of the video commenced playback.
        # 
        field :video_startup_failed, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoStartupFailed') } }
        # View Has Ad is a boolean metric indicating whether an advertisement played or attempted to play during the video view.
        # 
        field :view_has_ad, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewHasAd') } }
        # Indicates whether any playback error occurred during the video view. This boolean flag helps identify failed or interrupted playback sessions caused by player, network, or media-related issues.
        # 
        field :view_has_error, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewHasError') } }
        # View ID is a unique identifier assigned to each individual video viewing session.
        # 
        field :view_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewId') } }
        # It is a unique identifier associated with a specific workspace within the FastPix platform.
        # 
        field :workspace_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('workspaceId') } }
        # Events specifies the order of events journey of the video playback
        # 
        field :events, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::Event)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('events') } }
        # The unique identifier assigned to an Autonomous System (AS) on the Internet. The ASN is used to identify and exchange routing information between different networks.
        # 
        field :asn_id, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('asnId') } }
        # The Name associated with the asnId.
        # 
        field :asn_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('asnName') } }
        # Average Bitrate represents the average bitrate of the video content watched by the viewer, expressed in bits per second (bps). This metric provides insight into the quality of the video stream.
        # 
        field :average_bitrate, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('averageBitrate') } }
        # Average Downscaling refers to the average reduction in video resolution or quality during the playback of video content.
        # 
        field :avg_downscaling, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('avgDownscaling') } }
        # Average Request Latency average time it takes for a request to be made and processed during video playback
        # 
        field :avg_request_latency, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('avgRequestLatency') } }
        # Average Request Throughput refers to the average throughput or data transfer rate of HTTP requests made during video playback
        # 
        field :avg_request_throughput, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('avgRequestThroughput') } }
        # Average Upscaling refers to the average resolution of the video source is lower than the resolution of the playback device or screen.
        # 
        field :avg_upscaling, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('avgUpscaling') } }
        # Browser Engine denotes the rendering engine used by the browser (e.g., Blink, Gecko, WebKit).
        # 
        field :browser_engine, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('browserEngine') } }
        # Browser Name denotes the software application utilized by the viewer to access and watch the video content
        # 
        field :browser_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('browserName') } }
        # Browser Version signifies the specific version of the browser software employed by the viewer
        # 
        field :browser_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('browserVersion') } }
        # Buffer Count represents the number of rebuffering events occurring during the video view.
        # 
        field :buffer_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('bufferCount') } }
        # Buffer Fill indicates the total time, in milliseconds, that viewers wait for rebuffering per video view.
        # 
        field :buffer_fill, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('bufferFill') } }
        # Buffer Frequency measures the rate at which rebuffering events occur, expressed as events per millisecond.
        # 
        field :buffer_frequency, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('bufferFrequency') } }
        # Buffer Ratio refers to the percentage of time during video playback where the viewer experiences buffering or rebuffering events.
        # 
        field :buffer_ratio, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('bufferRatio') } }
        # Content Delivery Network (CDN) refers to the network infrastructure responsible for delivering the video content to the viewer.
        # 
        field :cdn, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('cdn') } }
        # City indicates the geographical location of the viewer accessing the video content.
        # 
        field :city, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('city') } }
        # Connection Type signifies the type of network connection utilized by the viewers device
        # 
        field :connection_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('connectionType') } }
        # Continent represents the continent name of the viewer accessing the video content.
        # 
        field :continent, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('continent') } }
        # Country represents the coded text that represents the country name of viewer accessing the video content.
        # 
        field :country, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('country') } }
        # Country Code denotes the two-letter ISO code representing the country of origin for the viewer accessing the video content.
        # 
        field :country_code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('countryCode') } }
        # Device Manufacturer indicates the brand or manufacturer of the device used by the viewer.
        # 
        field :device_manufacturer, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('deviceManufacturer') } }
        # Device Model represents the specific model of the device used by the viewer.
        # 
        field :device_model, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('deviceModel') } }
        # Device Name refers to the name or label assigned to the device used by the viewer.
        # 
        field :device_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('deviceName') } }
        # Device Type denotes the classification of the device used by the viewer
        # 
        field :device_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('deviceType') } }
        # DRM Type indicates the type of Digital Rights Management (DRM) utilized during video playback
        # 
        field :drm_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('drmType') } }
        # Dropped Frame Count represents the number of frames dropped by the video player during playback.
        # 
        field :dropped_frame_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('droppedFrameCount') } }
        # Error Code is an identifier representing a specific type of error that occurred during video playback, potentially leading to playback failure.
        # 
        field :error_code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('errorCode') } }
        # Specifies the component or stage where the playback error originated, such as streaming, cdn, decoder, or player. This context helps diagnose whether the failure was caused by delivery issues, playback logic, or media decoding problems within the FastPix streaming pipeline.
        # 
        field :error_context, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('errorContext') } }
        # The unique identifier which identifies each type of error that occurs.
        # 
        field :error_id, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('errorId') } }
        # Error Message is a descriptive message generated by the video player when an error occurs during playback, associated with an error code.
        # 
        field :error_message, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('errorMessage') } }
        # Experiment Name is used in A/B testing scenarios to categorize video views into different experiments.
        # 
        field :experiment_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('experimentName') } }
        # Specifies the version of the FastPix API used during data collection or playback reporting. This helps ensure compatibility and traceability between client SDK versions and backend processing.
        # 
        field :fp_api_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('fpApiVersion') } }
        # Identifies the type or source of the FastPix player embed used for playback — for example, whether the video was played through a direct player integration, an iframe, or a third-party embedded context. This helps differentiate playback environments and measure performance across embed types.
        # 
        field :fp_embed, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('fpEmbed') } }
        # Specifies the version of the FastPix embed script or SDK used to initialize the player. This helps track playback behavior and debug issues across different embed versions or deployment environments.
        # 
        field :fp_embed_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('fpEmbedVersion') } }
        # FastPix Live Stream ID is the unique identifier associated with a live stream video media within the FastPix Video Platform.
        # 
        field :fp_live_stream_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('fpLiveStreamId') } }
        # FastPix Playback ID refers to the unique identifier associated with the playback instance of a video, particularly used in FastPix Video Platform.
        # 
        field :fp_playback_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('fpPlaybackId') } }
        # FastPix SDK Name identifies the name of the FastPix Player SDK utilized within the player workspace.
        # 
        field :fp_sdk, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('fpSdk') } }
        # FastPix SDK Version specifies the version of the FastPix Player SDK integrated into the player.
        # 
        field :fp_sdk_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('fpSdkVersion') } }
        # Represents a unique, anonymized identifier assigned to each viewer by the FastPix SDK. This ID helps correlate multiple playback sessions or events to the same viewer across sessions or devices without exposing any personal information.
        # 
        field :fp_viewer_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('fpViewerId') } }
        # Jump Latency refers to the delay or latency experienced when there is a jump or seek action performed by the viewer while watching a video.
        # 
        field :jump_latency, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('jumpLatency') } }
        # Latitude refers to the geographical coordinate representing the north-south position of the viewers location, truncated to one decimal place.
        # 
        field :latitude, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('latitude') } }
        # Live Stream Latency measures the average time taken from the point of ingest to the point of display for live stream video views.
        # 
        field :live_stream_latency, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('liveStreamLatency') } }
        # Longitude denotes the geographical coordinate representing the east-west position of the viewers location, truncated to one decimal place.
        # 
        field :longitude, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('longitude') } }
        # Maximum Downscale Percentage represents the highest percentage of downscaling applied to the video during the view.
        # 
        field :max_downscaling, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('maxDownscaling') } }
        # Max Request Latency refers to the maximum rate of data transfer (throughput) during requests made by the playback.
        # 
        field :max_request_latency, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('maxRequestLatency') } }
        # Maximum Upscale Percentage represents the highest percentage of upscaling applied to the video during the view.
        # 
        field :max_upscaling, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('maxUpscaling') } }
        # The media Id value if the video asset is internal to FastPix.
        # 
        field :media_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('mediaId') } }
        # Operating System signifies the name of software platform utilized by the viewer.
        # 
        field :os_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('osName') } }
        # Page Context provides contextual information about the type of page being accessed.
        # 
        field :page_context, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('pageContext') } }
        # Page Load Time measures the time from when the user initiates loading the page to when all resources are loaded on the page.
        # 
        field :page_load_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('pageLoadTime') } }
        # Playback Success Score represents a numerical value indicating the success or quality of the video playback experience.
        # 
        field :playback_score, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playbackScore') } }
        # Player Height refers to the vertical dimension, measured in pixels, of the video player as it appears on the webpage.
        # 
        field :player_height, Crystalline::Nilable.new(Crystalline::Union.new(::String, ::Integer)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerHeight') } }
        # Player Initialization Time measures the duration, in milliseconds, from the initialization of the player within the webpage to its readiness to receive further instructions.
        # 
        field :player_initialization_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerInitializationTime') } }
        # Player Instance ID is a unique identifier that distinguishes each instance of the Player class created when initializing a video.
        # 
        field :player_instance_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerInstanceId') } }
        # Player Language indicates the language used for text elements within the video player interface.
        # 
        field :player_language, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerLanguage') } }
        # Player Name serves to differentiate various configurations or types of players used across the website or application.
        # 
        field :player_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerName') } }
        # Player Poster refers to the image displayed as a preview before the video playback begins.
        # 
        field :player_poster, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerPoster') } }
        # Player Resolution refers to the resolution of the video player window or viewport where the video content is being displayed.
        # 
        field :player_resolution, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerResolution') } }
        # Represents the name of the video player software or framework used for playback (for example, HTML5, HLS.js, Shaka Player).
        # 
        field :player_software_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerSoftwareName') } }
        # Player Software Version indicates the version number of the player software installed.
        # 
        field :player_software_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerSoftwareVersion') } }
        # Specifies the domain or source from which the player was loaded or embedded (for example, stream.fastpix.com or a customer’s custom domain). This helps identify the playback origin and differentiate between various deployment environments.
        # 
        field :player_source_domain, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerSourceDomain') } }
        # Player Source Height denotes the vertical dimension, measured in pixels, of the source video content being transmitted to the player.
        # 
        field :player_source_height, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerSourceHeight') } }
        # Player Source Width represents the width of the source video as perceived by the player, typically measured in pixels.
        # 
        field :player_source_width, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerSourceWidth') } }
        # Player Version indicates the version of the player used to render the video content. It is often utilized for performance comparison between different player versions.
        # 
        field :player_version, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerVersion') } }
        # Represents the total number of times the video player has been initialized or viewed for a specific session or video. This metric helps track playback engagement and identify view patterns across different players or sessions.
        # 
        field :player_view_count, Crystalline::Nilable.new(Crystalline::Union.new(::String, ::Integer)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerViewCount') } }
        # Player Width refers to the width of the player displayed within the webpage, measured in pixels.
        # 
        field :player_width, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('playerWidth') } }
        # Represents the unique identifier assigned to a FastPix property, which is associated with a specific workspace or project. It helps link playback and analytics data to the correct property configuration.
        # 
        field :property_id, Crystalline::Nilable.new(Crystalline::Union.new(::String, ::Integer)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('propertyId') } }
        # Quality Of Experience Score quantifies the overall viewer experience based on various metrics, providing a decimal score to assess the quality of the viewing experience.
        # 
        field :quality_of_experience_score, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('qualityOfExperienceScore') } }
        # Region denotes the geographical region of the viewer accessing the video content.
        # 
        field :region, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('region') } }
        # Render Quality Score is a decimal value representing the score indicating the perceived quality of the video.
        # 
        field :render_quality_score, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('renderQualityScore') } }
        # Session ID refers to the unique identifier tracking a viewers session within the FastPix platform.
        # 
        field :session_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('sessionId') } }
        # Represents a cryptographic signature used to verify the authenticity and integrity of the playback or API request within the FastPix platform. It ensures that the data has not been tampered with and originates from a trusted source.
        # 
        field :sign, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('sign') } }
        # Stability Score quantifies the smoothness of video playback, typically represented as a decimal value.
        # 
        field :stability_score, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('stabilityScore') } }
        # Startup Score evaluates the startup performance of the player, usually represented as a decimal value
        # 
        field :startup_score, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('startupScore') } }
        # Sub Property ID denotes the unique identifier assigned to FastPix properties, previously linked with a specific workspace.
        # 
        field :sub_property_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('subPropertyId') } }
        # Represents the total time (in milliseconds) taken for the video player to start playback from the moment the user initiates the session. This includes loading, buffering, and initialization delays before the first frame is rendered.
        # 
        field :total_startup_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('totalStartupTime') } }
        # Updated Timestamp refers to when the record is updated to a particular Video.
        # 
        field :updated_timestamp, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('updatedTimestamp') } }
        # User Agent represents the user agent string transmitted by the viewers device to identify itself to the server, typically including information about the device and browser.
        # 
        field :user_agent, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('userAgent') } }
        # Video Content Type specifies the classification of the video content.
        # 
        field :video_content_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoContentType') } }
        # Video Duration represents the length of the video, provided in milliseconds, typically supplied to FastPix through custom metadata.
        # 
        field :video_duration, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoDuration') } }
        # Indicates the specific encoding variant or rendition of the video being played, such as resolution, bitrate, or codec type. This helps identify which encoded version of the video was selected for playback.
        # 
        field :video_encoding_variant, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoEncodingVariant') } }
        # Video ID refers to an internal identifier assigned by the user or system to uniquely identify a particular video.
        # 
        field :video_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoId') } }
        # Video Language denotes the primary audio language of the video content, assuming it remains unchanged after playback initiation.
        # 
        field :video_language, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoLanguage') } }
        # Specifies the creator or source responsible for producing the video content.
        # 
        field :video_producer, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoProducer') } }
        # Video Resolution refers to the resolution of the video being played.
        # 
        field :video_resolution, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoResolution') } }
        # Video Series denotes the name of a series to which the video content belongs.
        # 
        field :video_series, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoSeries') } }
        # Video Source Domain identifies the domain from which the video source originates.
        # 
        field :video_source_domain, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoSourceDomain') } }
        # Video Source Duration represents the duration of the video source content, measured in milliseconds.
        # 
        field :video_source_duration, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoSourceDuration') } }
        # Video Source Hostname represents the hostname of the video.
        # 
        field :video_source_hostname, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoSourceHostname') } }
        # Video Source Stream Type denotes the type of stream used by the player, although it is currently unused.
        # 
        field :video_source_stream_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoSourceStreamType') } }
        # Video Source Type denotes the format of the video source as determined by the player.
        # 
        field :video_source_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoSourceType') } }
        # Video Source URL refers to the URL of the video source accessed by the player.
        # 
        field :video_source_url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoSourceUrl') } }
        # Video Startup Time measures the duration, in milliseconds, from the initialization of the player within the webpage to its readiness to receive further instructions.
        # 
        field :video_startup_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoStartupTime') } }
        # Video Title refers to the title of the video content being viewed.
        # 
        field :video_title, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoTitle') } }
        # Represents the unique identifier for the specific video variant or rendition being played. Each variant corresponds to a particular encoding configuration, such as resolution or bitrate, used for adaptive streaming and performance tracking.
        # 
        field :video_variant_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoVariantId') } }
        # Specifies the human-readable name of the video variant or rendition being played (for example, “1080p H.264” or “720p AV1”). This helps identify the playback quality or encoding configuration selected during streaming.
        # 
        field :video_variant_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('videoVariantName') } }
        # View End refers to the date and time, in Coordinated Universal Time (UTC), when the video viewing session concluded.
        # 
        field :view_end, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewEnd') } }
        # View Max Playhead Position represents the furthest point reached by the playhead during the video view, measured in milliseconds.
        # 
        field :view_max_playhead_position, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewMaxPlayheadPosition') } }
        # View Page URL denotes the URL address of the web page where the video content is being accessed.
        # 
        field :view_page_url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewPageUrl') } }
        # Playing Time denotes the total duration of time the video content was actively playing during the view, excluding time spent buffering, seeking, or joining.
        # 
        field :view_playing_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewPlayingTime') } }
        # View Seeked Count signifies the number of times the viewer attempted to seek to a new location within the video.
        # 
        field :view_seeked_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewSeekedCount') } }
        # View Seeked Duration indicates the total duration of time spent waiting for playback to resume after the viewer seeks to a new location. Seek Latency metric in the Dashboard is derived by dividing this value by the view_seek_count.
        # 
        field :view_seeked_duration, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewSeekedDuration') } }
        # Represents the unique identifier assigned to a single playback session within FastPix. This ID is used to correlate all playback events, errors, and metrics that occur during the same viewing session.
        # 
        field :view_session_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewSessionId') } }
        # View Start refers to the date and time, in Coordinated Universal Time (UTC), when the video viewing session commenced.
        # 
        field :view_start, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewStart') } }
        # View Total Content Playback Time represents the cumulative duration of video content watched by the viewer, measured in milliseconds. This metric is internally utilized to calculate upscale and downscale percentages.
        # 
        field :view_total_content_playback_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewTotalContentPlaybackTime') } }
        # Viewer ID refers to a customer-defined identifier representing the viewer who is watching the video stream. It must be anonymized and not contain any personally identifiable information.
        # 
        field :viewer_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('viewerId') } }
        # Total Watch Time denotes the total duration of video content watched by the viewer, encompassing startup time, playing time, and potential rebuffering time, measured in milliseconds.
        # 
        field :watch_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('watchTime') } }

        sig { params(beacon_domain: T.nilable(::String), custom: T.nilable(Models::Components::Custom2), exit_before_video_start: T.nilable(T::Boolean), insert_timestamp: T.nilable(::String), ip_address: T.nilable(::String), os_version: T.nilable(::String), player_autoplay_on: T.nilable(T::Boolean), player_preload_on: T.nilable(T::Boolean), player_remote_played: T.nilable(T::Boolean), used_full_screen: T.nilable(T::Boolean), video_startup_failed: T.nilable(T::Boolean), view_has_ad: T.nilable(T::Boolean), view_has_error: T.nilable(T::Boolean), view_id: T.nilable(::String), workspace_id: T.nilable(::String), events: T.nilable(T::Array[Models::Components::Event]), asn_id: T.nilable(::Integer), asn_name: T.nilable(::String), average_bitrate: T.nilable(::Float), avg_downscaling: T.nilable(::Float), avg_request_latency: T.nilable(::Float), avg_request_throughput: T.nilable(::Float), avg_upscaling: T.nilable(::Float), browser_engine: T.nilable(::String), browser_name: T.nilable(::String), browser_version: T.nilable(::String), buffer_count: T.nilable(::Integer), buffer_fill: T.nilable(::Integer), buffer_frequency: T.nilable(::Float), buffer_ratio: T.nilable(::Float), cdn: T.nilable(::String), city: T.nilable(::String), connection_type: T.nilable(::String), continent: T.nilable(::String), country: T.nilable(::String), country_code: T.nilable(::String), device_manufacturer: T.nilable(::String), device_model: T.nilable(::String), device_name: T.nilable(::String), device_type: T.nilable(::String), drm_type: T.nilable(::String), dropped_frame_count: T.nilable(::Integer), error_code: T.nilable(::String), error_context: T.nilable(::String), error_id: T.nilable(::Integer), error_message: T.nilable(::String), experiment_name: T.nilable(::String), fp_api_version: T.nilable(::String), fp_embed: T.nilable(T::Boolean), fp_embed_version: T.nilable(::String), fp_live_stream_id: T.nilable(::String), fp_playback_id: T.nilable(::String), fp_sdk: T.nilable(::String), fp_sdk_version: T.nilable(::String), fp_viewer_id: T.nilable(::String), jump_latency: T.nilable(::Float), latitude: T.nilable(::String), live_stream_latency: T.nilable(::Integer), longitude: T.nilable(::String), max_downscaling: T.nilable(::Float), max_request_latency: T.nilable(::Float), max_upscaling: T.nilable(::Float), media_id: T.nilable(::String), os_name: T.nilable(::String), page_context: T.nilable(::String), page_load_time: T.nilable(::Integer), playback_score: T.nilable(::Float), player_height: T.nilable(T.any(::String, ::Integer)), player_initialization_time: T.nilable(::Integer), player_instance_id: T.nilable(::String), player_language: T.nilable(::String), player_name: T.nilable(::String), player_poster: T.nilable(::String), player_resolution: T.nilable(::String), player_software_name: T.nilable(::String), player_software_version: T.nilable(::String), player_source_domain: T.nilable(::String), player_source_height: T.nilable(::Integer), player_source_width: T.nilable(::Integer), player_version: T.nilable(::String), player_view_count: T.nilable(T.any(::String, ::Integer)), player_width: T.nilable(::Integer), property_id: T.nilable(T.any(::String, ::Integer)), quality_of_experience_score: T.nilable(::Float), region: T.nilable(::String), render_quality_score: T.nilable(::Float), session_id: T.nilable(::String), sign: T.nilable(::String), stability_score: T.nilable(::Float), startup_score: T.nilable(::Float), sub_property_id: T.nilable(::String), total_startup_time: T.nilable(::Integer), updated_timestamp: T.nilable(::String), user_agent: T.nilable(::String), video_content_type: T.nilable(::String), video_duration: T.nilable(::Integer), video_encoding_variant: T.nilable(::String), video_id: T.nilable(::String), video_language: T.nilable(::String), video_producer: T.nilable(::String), video_resolution: T.nilable(::String), video_series: T.nilable(::String), video_source_domain: T.nilable(::String), video_source_duration: T.nilable(::Integer), video_source_hostname: T.nilable(::String), video_source_stream_type: T.nilable(::String), video_source_type: T.nilable(::String), video_source_url: T.nilable(::String), video_startup_time: T.nilable(::Integer), video_title: T.nilable(::String), video_variant_id: T.nilable(::String), video_variant_name: T.nilable(::String), view_end: T.nilable(::String), view_max_playhead_position: T.nilable(::Integer), view_page_url: T.nilable(::String), view_playing_time: T.nilable(::Integer), view_seeked_count: T.nilable(::Integer), view_seeked_duration: T.nilable(::Integer), view_session_id: T.nilable(::String), view_start: T.nilable(::String), view_total_content_playback_time: T.nilable(::Integer), viewer_id: T.nilable(::String), watch_time: T.nilable(::Integer)).void }
        def initialize(beacon_domain: nil, custom: nil, exit_before_video_start: nil, insert_timestamp: nil, ip_address: nil, os_version: nil, player_autoplay_on: nil, player_preload_on: nil, player_remote_played: nil, used_full_screen: nil, video_startup_failed: nil, view_has_ad: nil, view_has_error: nil, view_id: nil, workspace_id: nil, events: nil, asn_id: nil, asn_name: nil, average_bitrate: nil, avg_downscaling: nil, avg_request_latency: nil, avg_request_throughput: nil, avg_upscaling: nil, browser_engine: nil, browser_name: nil, browser_version: nil, buffer_count: nil, buffer_fill: nil, buffer_frequency: nil, buffer_ratio: nil, cdn: nil, city: nil, connection_type: nil, continent: nil, country: nil, country_code: nil, device_manufacturer: nil, device_model: nil, device_name: nil, device_type: nil, drm_type: nil, dropped_frame_count: nil, error_code: nil, error_context: nil, error_id: nil, error_message: nil, experiment_name: nil, fp_api_version: nil, fp_embed: nil, fp_embed_version: nil, fp_live_stream_id: nil, fp_playback_id: nil, fp_sdk: nil, fp_sdk_version: nil, fp_viewer_id: nil, jump_latency: nil, latitude: nil, live_stream_latency: nil, longitude: nil, max_downscaling: nil, max_request_latency: nil, max_upscaling: nil, media_id: nil, os_name: nil, page_context: nil, page_load_time: nil, playback_score: nil, player_height: nil, player_initialization_time: nil, player_instance_id: nil, player_language: nil, player_name: nil, player_poster: nil, player_resolution: nil, player_software_name: nil, player_software_version: nil, player_source_domain: nil, player_source_height: nil, player_source_width: nil, player_version: nil, player_view_count: nil, player_width: nil, property_id: nil, quality_of_experience_score: nil, region: nil, render_quality_score: nil, session_id: nil, sign: nil, stability_score: nil, startup_score: nil, sub_property_id: nil, total_startup_time: nil, updated_timestamp: nil, user_agent: nil, video_content_type: nil, video_duration: nil, video_encoding_variant: nil, video_id: nil, video_language: nil, video_producer: nil, video_resolution: nil, video_series: nil, video_source_domain: nil, video_source_duration: nil, video_source_hostname: nil, video_source_stream_type: nil, video_source_type: nil, video_source_url: nil, video_startup_time: nil, video_title: nil, video_variant_id: nil, video_variant_name: nil, view_end: nil, view_max_playhead_position: nil, view_page_url: nil, view_playing_time: nil, view_seeked_count: nil, view_seeked_duration: nil, view_session_id: nil, view_start: nil, view_total_content_playback_time: nil, viewer_id: nil, watch_time: nil)
          @beacon_domain = beacon_domain
          @custom = custom
          @exit_before_video_start = exit_before_video_start
          @insert_timestamp = insert_timestamp
          @ip_address = ip_address
          @os_version = os_version
          @player_autoplay_on = player_autoplay_on
          @player_preload_on = player_preload_on
          @player_remote_played = player_remote_played
          @used_full_screen = used_full_screen
          @video_startup_failed = video_startup_failed
          @view_has_ad = view_has_ad
          @view_has_error = view_has_error
          @view_id = view_id
          @workspace_id = workspace_id
          @events = events
          @asn_id = asn_id
          @asn_name = asn_name
          @average_bitrate = average_bitrate
          @avg_downscaling = avg_downscaling
          @avg_request_latency = avg_request_latency
          @avg_request_throughput = avg_request_throughput
          @avg_upscaling = avg_upscaling
          @browser_engine = browser_engine
          @browser_name = browser_name
          @browser_version = browser_version
          @buffer_count = buffer_count
          @buffer_fill = buffer_fill
          @buffer_frequency = buffer_frequency
          @buffer_ratio = buffer_ratio
          @cdn = cdn
          @city = city
          @connection_type = connection_type
          @continent = continent
          @country = country
          @country_code = country_code
          @device_manufacturer = device_manufacturer
          @device_model = device_model
          @device_name = device_name
          @device_type = device_type
          @drm_type = drm_type
          @dropped_frame_count = dropped_frame_count
          @error_code = error_code
          @error_context = error_context
          @error_id = error_id
          @error_message = error_message
          @experiment_name = experiment_name
          @fp_api_version = fp_api_version
          @fp_embed = fp_embed
          @fp_embed_version = fp_embed_version
          @fp_live_stream_id = fp_live_stream_id
          @fp_playback_id = fp_playback_id
          @fp_sdk = fp_sdk
          @fp_sdk_version = fp_sdk_version
          @fp_viewer_id = fp_viewer_id
          @jump_latency = jump_latency
          @latitude = latitude
          @live_stream_latency = live_stream_latency
          @longitude = longitude
          @max_downscaling = max_downscaling
          @max_request_latency = max_request_latency
          @max_upscaling = max_upscaling
          @media_id = media_id
          @os_name = os_name
          @page_context = page_context
          @page_load_time = page_load_time
          @playback_score = playback_score
          @player_height = player_height
          @player_initialization_time = player_initialization_time
          @player_instance_id = player_instance_id
          @player_language = player_language
          @player_name = player_name
          @player_poster = player_poster
          @player_resolution = player_resolution
          @player_software_name = player_software_name
          @player_software_version = player_software_version
          @player_source_domain = player_source_domain
          @player_source_height = player_source_height
          @player_source_width = player_source_width
          @player_version = player_version
          @player_view_count = player_view_count
          @player_width = player_width
          @property_id = property_id
          @quality_of_experience_score = quality_of_experience_score
          @region = region
          @render_quality_score = render_quality_score
          @session_id = session_id
          @sign = sign
          @stability_score = stability_score
          @startup_score = startup_score
          @sub_property_id = sub_property_id
          @total_startup_time = total_startup_time
          @updated_timestamp = updated_timestamp
          @user_agent = user_agent
          @video_content_type = video_content_type
          @video_duration = video_duration
          @video_encoding_variant = video_encoding_variant
          @video_id = video_id
          @video_language = video_language
          @video_producer = video_producer
          @video_resolution = video_resolution
          @video_series = video_series
          @video_source_domain = video_source_domain
          @video_source_duration = video_source_duration
          @video_source_hostname = video_source_hostname
          @video_source_stream_type = video_source_stream_type
          @video_source_type = video_source_type
          @video_source_url = video_source_url
          @video_startup_time = video_startup_time
          @video_title = video_title
          @video_variant_id = video_variant_id
          @video_variant_name = video_variant_name
          @view_end = view_end
          @view_max_playhead_position = view_max_playhead_position
          @view_page_url = view_page_url
          @view_playing_time = view_playing_time
          @view_seeked_count = view_seeked_count
          @view_seeked_duration = view_seeked_duration
          @view_session_id = view_session_id
          @view_start = view_start
          @view_total_content_playback_time = view_total_content_playback_time
          @viewer_id = viewer_id
          @watch_time = watch_time
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class

          [@beacon_domain, @custom, @exit_before_video_start, @insert_timestamp, @ip_address,
           @os_version, @player_autoplay_on, @player_preload_on, @player_remote_played, @used_full_screen,
           @video_startup_failed, @view_has_ad, @view_has_error, @view_id, @workspace_id,
           @events, @asn_id, @asn_name, @average_bitrate, @avg_downscaling,
           @avg_request_latency, @avg_request_throughput, @avg_upscaling, @browser_engine, @browser_name,
           @browser_version, @buffer_count, @buffer_fill, @buffer_frequency, @buffer_ratio,
           @cdn, @city, @connection_type, @continent, @country,
           @country_code, @device_manufacturer, @device_model, @device_name, @device_type,
           @drm_type, @dropped_frame_count, @error_code, @error_context, @error_id,
           @error_message, @experiment_name, @fp_api_version, @fp_embed, @fp_embed_version,
           @fp_live_stream_id, @fp_playback_id, @fp_sdk, @fp_sdk_version, @fp_viewer_id,
           @jump_latency, @latitude, @live_stream_latency, @longitude, @max_downscaling,
           @max_request_latency, @max_upscaling, @media_id, @os_name, @page_context,
           @page_load_time, @playback_score, @player_height, @player_initialization_time, @player_instance_id,
           @player_language, @player_name, @player_poster, @player_resolution, @player_software_name,
           @player_software_version, @player_source_domain, @player_source_height, @player_source_width, @player_version,
           @player_view_count, @player_width, @property_id, @quality_of_experience_score, @region,
           @render_quality_score, @session_id, @sign, @stability_score, @startup_score,
           @sub_property_id, @total_startup_time, @updated_timestamp, @user_agent, @video_content_type,
           @video_duration, @video_encoding_variant, @video_id, @video_language, @video_producer,
           @video_resolution, @video_series, @video_source_domain, @video_source_duration, @video_source_hostname,
           @video_source_stream_type, @video_source_type, @video_source_url, @video_startup_time, @video_title,
           @video_variant_id, @video_variant_name, @view_end, @view_max_playhead_position, @view_page_url,
           @view_playing_time, @view_seeked_count, @view_seeked_duration, @view_session_id, @view_start,
           @view_total_content_playback_time, @viewer_id, @watch_time] ==
            [other.beacon_domain, other.custom, other.exit_before_video_start, other.insert_timestamp, other.ip_address,
             other.os_version, other.player_autoplay_on, other.player_preload_on, other.player_remote_played, other.used_full_screen,
             other.video_startup_failed, other.view_has_ad, other.view_has_error, other.view_id, other.workspace_id,
             other.events, other.asn_id, other.asn_name, other.average_bitrate, other.avg_downscaling,
             other.avg_request_latency, other.avg_request_throughput, other.avg_upscaling, other.browser_engine, other.browser_name,
             other.browser_version, other.buffer_count, other.buffer_fill, other.buffer_frequency, other.buffer_ratio,
             other.cdn, other.city, other.connection_type, other.continent, other.country,
             other.country_code, other.device_manufacturer, other.device_model, other.device_name, other.device_type,
             other.drm_type, other.dropped_frame_count, other.error_code, other.error_context, other.error_id,
             other.error_message, other.experiment_name, other.fp_api_version, other.fp_embed, other.fp_embed_version,
             other.fp_live_stream_id, other.fp_playback_id, other.fp_sdk, other.fp_sdk_version, other.fp_viewer_id,
             other.jump_latency, other.latitude, other.live_stream_latency, other.longitude, other.max_downscaling,
             other.max_request_latency, other.max_upscaling, other.media_id, other.os_name, other.page_context,
             other.page_load_time, other.playback_score, other.player_height, other.player_initialization_time, other.player_instance_id,
             other.player_language, other.player_name, other.player_poster, other.player_resolution, other.player_software_name,
             other.player_software_version, other.player_source_domain, other.player_source_height, other.player_source_width, other.player_version,
             other.player_view_count, other.player_width, other.property_id, other.quality_of_experience_score, other.region,
             other.render_quality_score, other.session_id, other.sign, other.stability_score, other.startup_score,
             other.sub_property_id, other.total_startup_time, other.updated_timestamp, other.user_agent, other.video_content_type,
             other.video_duration, other.video_encoding_variant, other.video_id, other.video_language, other.video_producer,
             other.video_resolution, other.video_series, other.video_source_domain, other.video_source_duration, other.video_source_hostname,
             other.video_source_stream_type, other.video_source_type, other.video_source_url, other.video_startup_time, other.video_title,
             other.video_variant_id, other.video_variant_name, other.view_end, other.view_max_playhead_position, other.view_page_url,
             other.view_playing_time, other.view_seeked_count, other.view_seeked_duration, other.view_session_id, other.view_start,
             other.view_total_content_playback_time, other.viewer_id, other.watch_time]
        end

        def to_dict
          result = {}
          fields.sort_by(&:name).each do |field|
            next if field.name == :events

            format_json_meta = field.metadata[:format_json]
            key = if !format_json_meta.nil? && format_json_meta.include?(:letter_case)
              format_json_meta[:letter_case].call
            else
              field.name.to_s
            end

            f = send(field.name)
            if f.nil?
              result[key] = nil
            elsif f.is_a?(Array)
              result[key] = f.map { |o| marshal_single(o) }
            elsif f.is_a?(Hash)
              result[key] = f.transform_values { |v| marshal_single(v) }
            else
              result[key] = marshal_single(f)
            end
          end
          result['events'] = @events&.map(&:to_dict)
          result
        end
      end
    end
  end
end
