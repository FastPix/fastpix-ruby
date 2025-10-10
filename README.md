# Ruby SDK

A robust, type-safe Ruby SDK designed for seamless integration with the FastPix API platform.



<!-- Start Summary [summary] -->
## Introduction

The FastPix Ruby SDK simplifies integration with the FastPix platform. It provides a clean, Ruby interface for secure and efficient communication with the FastPix API, enabling easy management of media uploads, live streaming, on‑demand content, playlists, video analytics, and signing keys for secure access and token management. It is intended for use with Ruby 3.2 and above.

## Prerequisites

### Environment and Version Support

<table>
<tr>
<th>Requirement</th>
<th>Version</th>
<th>Description</th>
</tr>
<tr>
<td><strong>Ruby</strong></td>
<td><code>3.2+</code></td>
<td>Core runtime environment</td>
</tr>
<tr>
<td><strong>Bundler</strong></td>
<td><code>2.4+</code></td>
<td>Dependency management for Ruby gems</td>
</tr>
<tr>
<td><strong>Internet</strong></td>
<td><code>Required</code></td>
<td>API communication and authentication</td>
</tr>
</table>

> **Pro Tip:** We recommend using Ruby 3.3+ for optimal performance and the latest language features.

### Getting Started with FastPix

To get started with the **FastPix Ruby SDK**, ensure you have the following:

- The FastPix APIs are authenticated using a **Username** and a **Password**. You must generate these credentials to use the SDK.

- Follow the steps in the [Authentication with Basic Auth](https://docs.fastpix.io/docs/basic-authentication) guide to obtain your credentials.

### Environment Variables (Optional)

Configure your FastPix credentials using environment variables for enhanced security and convenience:

```bash
# Set your FastPix credentials
export FASTPIX_USERNAME="your_username_here"
export FASTPIX_PASSWORD="your_password_here"

# Or add to your .env file
echo "FASTPIX_USERNAME=your_username_here" >> .env
echo "FASTPIX_PASSWORD=your_password_here" >> .env
```

> **Security Note:** Never commit your credentials to version control. Use environment variables or secure credential management systems.

<!-- Start Table of Contents [toc] -->
## Table of Contents
<!-- $toc-max-depth=2 -->
* [Fastpix_Ruby](#fastpixruby)
  * [Setup](#setup)
  * [Example Usage](#example-usage)
  * [Available Resources and Operations](#available-resources-and-operations)
  * [Retries](#retries)
  * [Error Handling](#error-handling)
  * [Server Selection](#server-selection)
  * [Development](#development)


<!-- End Table of Contents [toc] -->

<!-- Start Setup [setup] -->
## Setup

### Installation

Install the FastPix Ruby SDK using RubyGems:

```bash
gem install fastpixapi
```

Or if you're using a bundler:

```bash
# Add to your Gemfile
gem 'fastpixapi', '~> 1.0.0'

# Install dependencies
bundle install
```

### Imports

Import the necessary modules for your FastPix integration:

```ruby
# Basic imports
require 'fastpixapi'

# Access to models and components
Models = ::FastpixApiSDK::Models
```

### Initialization

Initialize the FastPix SDK with your credentials:

```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
  security: Models::Components::Security.new(
    username: "your-access-token",
    password: "your-secret-key",
  ),
)
```


Or using environment variables:

```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
  security: Models::Components::Security.new(
    username: ENV["FASTPIX_ACCESS_TOKEN"],
    password: ENV["FASTPIX_SECRET_KEY"],
  ),
)
```

<!-- End Setup [setup] -->

<!-- Start Example Usage [example-usage] -->
## Example Usage

### Example

```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

req = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::VideoInput.new(
      type: 'video',
      url: 'https://static.fastpix.io/sample.mp4',
    ),
  ],
  metadata: {
    "key1": 'value1',
  },
  access_policy: Models::Components::CreateMediaRequestAccessPolicy::PUBLIC,
)

res = s.input_video.create_media(request: req)

unless res.create_media_success_response.nil?
  # handle response
end

```
<!-- End Example Usage [example-usage] -->


<!-- Start Available Resources and Operations [operations] -->
## Available Resources and Operations

Comprehensive Ruby SDK for FastPix platform integration with full API coverage.

### Media API

Upload, manage, and transform video content with comprehensive media management capabilities.

For detailed documentation, see [FastPix Video on Demand Overview](https://docs.fastpix.io/docs/video-on-demand-overview).

#### Input Video
- [Create from URL](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/inputvideo/README.md#create_media) - Upload video content from external URL
- [Upload from Device](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/inputvideo/README.md#direct_upload_video_media) - Upload video files directly from device

#### Manage Videos
- [List All Media](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#list_media) - Retrieve complete list of all media files
- [Get Media by ID](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#get_media) - Get detailed information for specific media
- [Update Media](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#updated_media) - Modify media metadata and settings
- [Delete Media](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#delete_media) - Remove media files from library
- [Add Track](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#add_media_track) - Add audio or subtitle tracks to media
- [Cancel Upload](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#cancel_upload) - Stop ongoing media upload process
- [Update Track](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#update_media_track) - Modify existing audio or subtitle tracks
- [Delete Track](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#delete_media_track) - Remove audio or subtitle tracks
- [Generate Subtitles](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#generate_subtitle_track) - Create automatic subtitles for media
- [Update Source Access](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#updated_source_access) - Control access permissions for media source
- [Update MP4 Support](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#updated_mp4_support) - Configure MP4 download capabilities
- [Get Input Info](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#retrieve_media_input_info) - Retrieve detailed input information
- [List Uploads](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#list_uploads) - Get all available upload URLs
- [Get Media Clips](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#get_media_clips) - Retrieve all video clips for media

#### Playback
- [Create Playback ID](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/playback/README.md#create_media_playback_id) - Generate secure playback identifier
- [Delete Playback ID](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/playback/README.md#delete_media_playback_id) - Remove playback access
- [Get Playback ID](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/playback/README.md#get_playback_id) - Retrieve playback configuration details

#### Playlist
- [Create Playlist](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/playlist/README.md#create_a_playlist) - Create new video playlist
- [List Playlists](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/playlist/README.md#get_all_playlists) - Get all available playlists
- [Get Playlist](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/playlist/README.md#get_playlist_by_id) - Retrieve specific playlist details
- [Update Playlist](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/playlist/README.md#update_a_playlist) - Modify playlist settings and metadata
- [Delete Playlist](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/playlist/README.md#delete_a_playlist) - Remove playlist from library
- [Add Media](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/playlist/README.md#add_media_to_playlist) - Add media items to playlist
- [Reorder Media](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/playlist/README.md#change_media_order_in_playlist) - Change order of media in playlist
- [Remove Media](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/playlist/README.md#delete_media_from_playlist) - Remove media from playlist

#### Signing Keys
- [Create Key](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/signingkeys/README.md#create_signing_key) - Generate new signing key pair
- [List Keys](https://github.com/FastPix/fastpix-ruby/blob/main/https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/signingkeys/README.md#list_signing_keys) - Get all available signing keys
- [Delete Key](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/signingkeys/README.md#delete_signing_key) - Remove signing key from system
- [Get Key](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/signingkeys/README.md#get_signing_key_by_id) - Retrieve specific signing key details

#### DRM Configurations
- [List DRM Configs](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/drmconfigurations/README.md#get_drm_configuration) - Get all DRM configuration options
- [Get DRM Config](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/drmconfigurations/README.md#get_drm_configuration_by_id) - Retrieve specific DRM configuration

### Live API 

Stream, manage, and transform live video content with real-time broadcasting capabilities.

For detailed documentation, see [FastPix Live Stream Overview](https://docs.fastpix.io/docs/live-stream-overview).

#### Start Live Stream
- [Create Stream](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/startlivestream/README.md#create_new_stream) - Initialize new live streaming session

#### Manage Live Stream
- [List Streams](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#get_all_streams) - Retrieve all active live streams
- [Get Viewer Count](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#get_live_stream_viewer_count_by_id) - Get real-time viewer statistics
- [Get Stream](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#get_live_stream_by_id) - Retrieve detailed stream information
- [Delete Stream](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#delete_live_stream) - Terminate and remove live stream
- [Update Stream](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#update_live_stream) - Modify stream settings and configuration
- [Enable Stream](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#enable_live_stream) - Activate live streaming
- [Disable Stream](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#disable_live_stream) - Pause live streaming
- [Complete Stream](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/managevideos/README.md#complete_live_stream) - Finalize and archive stream

#### Live Playback
- [Create Playback ID](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/liveplayback/README.md#create_playback_id_of_stream) - Generate secure live playback access
- [Delete Playback ID](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/liveplayback/README.md#delete_playback_id_of_stream) - Revoke live playback access
- [Get Playback ID](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/liveplayback/README.md#get_live_stream_playback_id) - Retrieve live playback configuration

#### Simulcast Stream
- [Create Simulcast](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/simulcaststream#create_simulcast_of_stream) - Set up multi-platform streaming
- [Delete Simulcast](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/simulcaststream#delete_simulcast_of_stream) - Remove simulcast configuration
- [Get Simulcast](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/simulcaststream#get_specific_simulcast_of_stream) - Retrieve simulcast settings
- [Update Simulcast](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/simulcaststream#update_specific_simulcast_of_stream) - Modify simulcast parameters

### Video Data API 

Monitor video performance and quality with comprehensive analytics and real-time metrics.

For detailed documentation, see [FastPix Video Data Overview](https://docs.fastpix.io/docs/video-data-overview).

#### Metrics
- [List Breakdown Values](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/metrics/README.md#list_breakdown_values) - Get detailed breakdown of metrics by dimension
- [List Overall Values](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/metrics/README.md#list_overall_values) - Get aggregated metric values across all content
- [Get Timeseries Data](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/metrics/README.md#get_timeseries_data) - Retrieve time-based metric trends and patterns
- [List Comparison Values](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/metrics/README.md#list_comparison_values) - Compare metrics across different time periods

#### Views
- [List Video Views](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/views/README.md#list_video_views#list_video_views) - Get comprehensive list of video viewing sessions
- [Get View Details](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/views/README.md#list_video_views#get_video_view_details) - Retrieve detailed information about specific video views
- [List Top Content](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/views/README.md#list_video_views#list_by_top_content) - Find your most popular and engaging content
- [Get Concurrent Viewers](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/views/README.md#list_video_views#get_data_viewlist_current_views_get_timeseries_views) - Monitor real-time viewer counts over time
- [Get Viewer Breakdown](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/views/README.md#list_video_views#get_data_viewlist_current_views_filter) - Analyze viewers by device, location, and other dimensions

#### Dimensions
- [List Dimensions](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/dimensions/README.md#list_dimensions) - Get available data dimensions for filtering and analysis
- [List Filter Values](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/dimensions/README.md#list_filter_values_for_dimension) - Get specific values for a particular dimension

### In-Video AI Features

Enhance video content with AI-powered features including moderation, summarization, and intelligent categorization.

For detailed documentation, see [Video Moderation Guide](https://docs.fastpix.io/docs/using-nsfw-and-profanity-filter-for-video-moderation).

- [Generate Summary](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/dimensions/README.md#update_media_summary) - Create AI-generated video summaries
- [Create Chapters](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/dimensions/README.md#update_media_chapters) - Automatically generate video chapter markers
- [Extract Entities](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/dimensions/README.md#update_media_named_entities) - Identify and extract named entities from content
- [Enable Moderation](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/dimensions/README.md#update_media_moderation) - Activate content moderation and safety checks

### Error Handling

Handle and manage errors with comprehensive error handling capabilities and detailed error information for all API operations.

- [List Errors](https://github.com/FastPix/fastpix-ruby/blob/main/docs/sdks/dimensions/README.md#list_errors) - Retrieve comprehensive error logs and diagnostics

<!-- End Available Resources and Operations [operations] -->

<!-- Start Retries [retries] -->
## Retries

Some of the endpoints in this SDK support retries. If you use the SDK without any configuration, it will fall back to the default retry strategy provided by the API. However, the default retry strategy can be overridden on a per-operation basis, or across the entire SDK.

To change the default retry strategy for a single API call, simply provide a `RetryConfig` object to the call:
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

req = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::VideoInput.new(
      type: 'video',
      url: 'https://static.fastpix.io/sample.mp4',
    ),
  ],
  metadata: {
    "key1": 'value1',
  },
  access_policy: Models::Components::CreateMediaRequestAccessPolicy::PUBLIC,
)

res = s.input_video.create_media(request: req)

unless res.create_media_success_response.nil?
  # handle response
end

```

If you'd like to override the default retry strategy for all operations that support retries, you can use the `retry_config` optional parameter when initializing the SDK:
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      retry_config: Utils::RetryConfig.new(
        backoff: Utils::BackoffStrategy.new(
          exponent: 1.1,
          initial_interval: 1,
          max_elapsed_time: 100,
          max_interval: 50
        ),
        retry_connection_errors: false,
        strategy: 'backoff'
      ),
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

req = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::VideoInput.new(
      type: 'video',
      url: 'https://static.fastpix.io/sample.mp4',
    ),
  ],
  metadata: {
    "key1": 'value1',
  },
  access_policy: Models::Components::CreateMediaRequestAccessPolicy::PUBLIC,
)

res = s.input_video.create_media(request: req)

unless res.create_media_success_response.nil?
  # handle response
end

```
<!-- End Retries [retries] -->

<!-- Start Error Handling [errors] -->
## Error Handling

Handling errors in this SDK should largely match your expectations. All operations return a response object or raise an error.

By default an API error will raise a `Errors::APIError`, which has the following properties:

| Property       | Type                                    | Description           |
|----------------|-----------------------------------------|-----------------------|
| `message`     | *string*                                 | The error message     |
| `status_code`  | *int*                                   | The HTTP status code  |
| `raw_response` | *Faraday::Response*                     | The raw HTTP response |
| `body`        | *string*                                 | The response content  |

When custom error responses are specified for an operation, the SDK may also throw their associated exception. You can refer to respective *Errors* tables in SDK docs for more details on possible exception types for each operation. For example, the `create_media` method throws the following exceptions:

| Error Type                              | Status Code | Content Type     |
| --------------------------------------- | ----------- | ---------------- |
| Models::Errors::BadRequestError         | 400         | application/json |
| Models::Errors::InvalidPermissionError  | 401         | application/json |
| Models::Errors::ForbiddenError          | 403         | application/json |
| Models::Errors::ValidationErrorResponse | 422         | application/json |
| Errors::APIError                        | 4XX, 5XX    | \*/\*            |

### Example

```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

begin
    req = Models::Components::CreateMediaRequest.new(
      inputs: [
        Models::Components::VideoInput.new(
          type: 'video',
          url: 'https://static.fastpix.io/sample.mp4',
        ),
      ],
      metadata: {
        "key1": 'value1',
      },
      access_policy: Models::Components::CreateMediaRequestAccessPolicy::PUBLIC,
    )

    res = s.input_video.create_media(request: req)

    unless res.create_media_success_response.nil?
      # handle response
    end
rescue Models::Errors::BadRequestError => e
  # handle e.container data
  raise e
rescue Models::Errors::InvalidPermissionError => e
  # handle e.container data
  raise e
rescue Models::Errors::ForbiddenError => e
  # handle e.container data
  raise e
rescue Models::Errors::ValidationErrorResponse => e
  # handle e.container data
  raise e
rescue Errors::APIError => e
  # handle default exception
  raise e
end

```
<!-- End Error Handling [errors] -->

<!-- Start Server Selection [server] -->
## Server Selection

### Override Server URL Per-Client

The default server can be overridden globally by passing a URL to the `server_url (String)` optional parameter when initializing the SDK client instance. For example:
```ruby
require 'fastpixapi'

Models = ::FastpixApiSDK::Models
s = ::FastpixApiSDK::Fastpix.new(
      server_url: 'https://api.fastpix.io/v1/',
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

req = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::VideoInput.new(
      type: 'video',
      url: 'https://static.fastpix.io/sample.mp4',
    ),
  ],
  metadata: {
    "key1": 'value1',
  },
  access_policy: Models::Components::CreateMediaRequestAccessPolicy::PUBLIC,
)

res = s.input_video.create_media(request: req)

unless res.create_media_success_response.nil?
  # handle response
end

```
<!-- End Server Selection [server] -->

<!-- Placeholder for Future fastpix SDK Sections -->

# Development

This Ruby SDK is programmatically generated from our API specifications. Any manual modifications to internal files will be overwritten during subsequent generation cycles. 

We value community contributions and feedback. Feel free to submit pull requests or open issues with your suggestions, and we'll do our best to include them in future releases.

## Detailed Usage

For comprehensive understanding of each API's functionality, including detailed request and response specifications, parameter descriptions, and additional examples, please refer to the [FastPix API Reference](https://docs.fastpix.io/reference/signingkeys-overview).

The API reference offers complete documentation for all available endpoints and features, enabling developers to integrate and leverage FastPix APIs effectively.



<style>
  :root {
    --badge-gray-bg: #f3f4f6;
    --badge-gray-border: #d1d5db;
    --badge-gray-text: #374151;
    --badge-blue-bg: #eff6ff;
    --badge-blue-border: #3b82f6;
    --badge-blue-text: #3b82f6;
  }

  @media (prefers-color-scheme: dark) {
    :root {
      --badge-gray-bg: #374151;
      --badge-gray-border: #4b5563;
      --badge-gray-text: #f3f4f6;
      --badge-blue-bg: #1e3a8a;
      --badge-blue-border: #3b82f6;
      --badge-blue-text: #93c5fd;
    }
  }
  
  h1 {
    border-bottom: none !important;
    margin-bottom: 4px;
    margin-top: 0;
    letter-spacing: 0.5px;
    font-weight: 600;
  }
  
  .badge-text {
    letter-spacing: 1px;
    font-weight: 300;
  }
  
  .badge-container {
    display: inline-flex;
    align-items: center;
    background: var(--badge-gray-bg);
    border: 1px solid var(--badge-gray-border);
    border-radius: 6px;
    overflow: hidden;
    font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;
    font-size: 11px;
    text-decoration: none;
    vertical-align: middle;
  }

  .badge-container.blue {
    background: var(--badge-blue-bg);
    border-color: var(--badge-blue-border);
  }

  .badge-icon-section {
    padding: 4px 8px;
    border-right: 1px solid var(--badge-gray-border);
    display: flex;
    align-items: center;
  }

  .badge-text-section {
    padding: 4px 10px;
    color: var(--badge-gray-text);
    font-weight: 400;
  }

  .badge-container.blue .badge-text-section {
    color: var(--badge-blue-text);
  }
  
  .badge-link {
    text-decoration: none;
    margin-left: 8px;
    display: inline-flex;
    vertical-align: middle;
  }

  .badge-link:hover {
    text-decoration: none;
  }
  
  .badge-link:first-child {
    margin-left: 0;
  }
  
  .badge-icon-section svg {
    color: var(--badge-gray-text);
  }

  .badge-container.blue .badge-icon-section svg {
    color: var(--badge-blue-text);
  }
</style> 