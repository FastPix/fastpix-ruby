# FastPix Ruby SDK

A robust, type-safe Ruby SDK designed for seamless integration with the FastPix API platform.



## Introduction

The FastPix Ruby SDK simplifies integration with the FastPix platform. It provides a clean, typed interface for secure and efficient communication with the FastPix API, enabling easy management of media uploads, live streaming, on‑demand content, playlists, video analytics, and signing keys for secure access and token management. It is intended for use with Ruby 3.2 and above.

## Prerequisites

### Environment and Version Support

| Requirement | Version | Description |
|---|---:|---|
| Ruby | `3.2+` | Core runtime environment |
| Bundler | `Latest` | Dependency management |
| Internet | `Required` | API communication and authentication |

> Pro Tip: We recommend using Ruby 3.2+ for optimal performance and the latest language features.

### Getting Started with FastPix

To get started with the FastPix Ruby SDK, ensure you have the following:

- The FastPix APIs are authenticated using a **Username** and a **Password**. You must generate these credentials to use the SDK.
- Follow the steps in the [Authentication with Basic Auth](https://docs.fastpix.io/docs/basic-authentication) guide to obtain your credentials.

### Environment Variables (Optional)

Configure your FastPix credentials using environment variables for enhanced security and convenience:

```bash
# Set your FastPix credentials
export FASTPIX_USERNAME="your-access-token"
export FASTPIX_PASSWORD="your-secret-key"
```

> Security Note: Never commit your credentials to version control. Use environment variables or secure credential management systems.

## Table of Contents

* [FastPix Ruby SDK](#fastpix-ruby-sdk)
  * [Setup](#setup)
  * [Example Usage](#example-usage)
  * [Available Resources and Operations](#available-resources-and-operations)
  * [Error Handling](#error-handling)
  * [Server Selection](#server-selection)
  * [Development](#development)

## Setup

### Installation

Install the FastPix Ruby SDK using Bundler. Add to your `Gemfile`:

```ruby
gem 'fastpixapi'
```

Then run:

```bash
bundle install
```

Or install the gem directly:

```bash
gem install fastpixapi
```

### Imports

Require the SDK and use the client namespace:

```ruby
require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
```

### Initialization

Initialize the FastPix SDK with your credentials:

```ruby
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: 'your-access-token',
    password: 'your-secret-key'
  )
)
```

Or using environment variables:

```ruby
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: ENV['FASTPIX_USERNAME'],  # Your Access Token
    password: ENV['FASTPIX_PASSWORD']  # Your Secret Key
  )
)
```

## Example Usage

```ruby
require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: 'your-access-token',
    password: 'your-secret-key'
  )
)

req = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::PullVideoInput.new(
      type: 'video',
      url: 'https://static.fastpix.io/fp-sample-video.mp4',
    ),
  ],
  metadata: { 'key1' => 'value1' },
)

begin
  res = s.input_video.create_media(request: req)
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s if defined?(res) && res&.raw_response
end
```

## Available Resources and Operations

Comprehensive Ruby SDK for FastPix platform integration with full API coverage.

### Media API

Upload, manage, and transform video content with comprehensive media management capabilities.

For detailed documentation, see [FastPix Video on Demand Overview](https://docs.fastpix.io/docs/video-on-demand-overview).

#### Input Video
- [Create from URL](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/inputvideo/README.md#create_media) - Upload video content from external URL
- [Upload from Device](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/inputvideo/README.md#direct_upload_video_media) - Upload video files directly from device

#### Manage Videos
- [List All Media](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#list_media) - Retrieve complete list of all media files
- [Get Media by ID](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#get_media) - Get detailed information for specific media
- [Update Media](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#updated_media) - Modify media metadata and settings
- [Delete Media](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#delete_media) - Remove media files from library
- [Cancel Upload](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#cancel_upload) - Stop ongoing media upload process
- [Get Input Info](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#retrieve_media_input_info) - Retrieve detailed input information
- [List Uploads](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#list_uploads) - Get all available upload URLs
- [Get Media Clips](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#get_media_clips) - Get all clips of a media
- [Get Media Summary](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#get_media_summary) - Get the summary of a video
- [Update Source Access](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#updated_source_access) - Update the source access of a media by ID
- [Update MP4 Support](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#updated_mp4_support) - Update the mp4Support of a media by ID
- [Add Media Track](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#add_media_track) - Add audio or subtitle track
- [Update Media Track](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#update_media_track) - Update audio or subtitle track
- [Delete Media Track](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#delete_media_track) - Delete audio or subtitle track
- [Generate Subtitle Track](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#generate_subtitle_track) - Generate track subtitle
- [List Live Clips](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managevideos/README.md#list_live_clips) - Get all clips of a live stream

#### Playback
- [Create Playback ID](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playback/README.md#create_media_playback_id) - Generate secure playback identifier
- [List Playback IDs](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playback/README.md#list_playback_ids) - Get all playback IDs details for a media
- [Delete Playback ID](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playback/README.md#delete_media_playback_id) - Remove playback access
- [Get Playback ID](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playback/README.md#get_playback_id) - Retrieve playback configuration details
- [Update Domain Restrictions](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playback/README.md#update_domain_restrictions) - Update domain restrictions for a playback ID
- [Update User-Agent Restrictions](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playback/README.md#update_user_agent_restrictions) - Update user-agent restrictions for a playback ID

#### Playlist
- [Create Playlist](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playlist/README.md#create_a_playlist) - Create new video playlist
- [List Playlists](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playlist/README.md#get_all_playlists) - Get all available playlists
- [Get Playlist](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playlist/README.md#get_playlist_by_id) - Retrieve specific playlist details
- [Update Playlist](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playlist/README.md#update_a_playlist) - Modify playlist settings and metadata
- [Delete Playlist](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playlist/README.md#delete_a_playlist) - Remove playlist from library
- [Add Media](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playlist/README.md#add_media_to_playlist) - Add media items to playlist
- [Change Media Order](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playlist/README.md#change_media_order_in_playlist) - Change order of media in playlist
- [Delete Media from Playlist](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/playlist/README.md#delete_media_from_playlist) - Remove media from playlist

#### Signing Keys
- [Create Key](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/signingkeys/README.md#create_signing_key) - Generate new signing key pair
- [List Keys](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/signingkeys/README.md#list_signing_keys) - Get all available signing keys
- [Delete Key](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/signingkeys/README.md#delete_signing_key) - Remove signing key from system
- [Get Key by ID](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/signingkeys/README.md#get_signing_key_by_id) - Retrieve specific signing key details

#### DRM Configurations
- [List DRM Configs](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/drmconfigurations/README.md#get_drm_configuration) - Get all DRM configuration options
- [Get DRM Config](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/drmconfigurations/README.md#get_drm_configuration_by_id) - Retrieve specific DRM configuration

### Live API

Stream, manage, and transform live video content with real-time broadcasting capabilities.

For detailed documentation, see [FastPix Live Stream Overview](https://docs.fastpix.io/docs/live-stream-overview).

#### Start Live Stream
- [Create Stream](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/startlivestream/README.md#create_new_stream) - Initialize new live streaming session

#### Manage Live Stream
- [List Streams](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managelivestream/README.md#get_all_streams) - Retrieve all active live streams
- [Get Viewer Count](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managelivestream/README.md#get_live_stream_viewer_count_by_id) - Get real-time viewer statistics
- [Get Stream](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managelivestream/README.md#get_live_stream_by_id) - Retrieve detailed stream information
- [Delete Stream](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managelivestream/README.md#delete_live_stream) - Terminate and remove live stream
- [Update Stream](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managelivestream/README.md#update_live_stream) - Modify stream settings and configuration
- [Enable Stream](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managelivestream/README.md#enable_live_stream) - Activate live streaming
- [Disable Stream](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managelivestream/README.md#disable_live_stream) - Pause live streaming
- [Complete Stream](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/managelivestream/README.md#complete_live_stream) - Finalize and archive stream

#### Live Playback
- [Create Playback ID](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/liveplayback/README.md#create_playback_id_of_stream) - Generate secure live playback access
- [Delete Playback ID](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/liveplayback/README.md#delete_playback_id_of_stream) - Revoke live playback access
- [Get Playback ID](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/liveplayback/README.md#get_live_stream_playback_id) - Retrieve live playback configuration

#### Simulcast Stream
- [Create Simulcast](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/simulcaststream/README.md#create_simulcast_of_stream) - Set up multi-platform streaming
- [Delete Simulcast](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/simulcaststream/README.md#delete_simulcast_of_stream) - Remove simulcast configuration
- [Get Simulcast](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/simulcaststream/README.md#get_specific_simulcast_of_stream) - Retrieve simulcast settings
- [Update Simulcast](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/simulcaststream/README.md#update_specific_simulcast_of_stream) - Modify simulcast parameters

### Video Data API

Monitor video performance and quality with comprehensive analytics and real-time metrics.

For detailed documentation, see [FastPix Video Data Overview](https://docs.fastpix.io/docs/video-data-overview).

#### Metrics
- [List Breakdown Values](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/metrics/README.md#list_breakdown_values) - Get detailed breakdown of metrics by dimension
- [List Overall Values](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/metrics/README.md#list_overall_values) - Get aggregated metric values across all content
- [Get Timeseries Data](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/metrics/README.md#get_timeseries_data) - Retrieve time-based metric trends and patterns
- [List Comparison Values](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/metrics/README.md#list_comparison_values) - List comparison values

#### Views
- [List Video Views](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/views/README.md#list_video_views) - Get comprehensive list of video viewing sessions
- [Get View Details](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/views/README.md#get_video_view_details) - Retrieve detailed information about specific video views
- [List Top Content](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/views/README.md#list_by_top_content) - Find your most popular and engaging content

#### Dimensions
- [List Dimensions](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/dimensions/README.md#list_dimensions) - Get available data dimensions for filtering and analysis
- [List Filter Values](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/dimensions/README.md#list_filter_values_for_dimension) - Get specific values for a particular dimension

#### Errors
- [List Errors](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/errors/README.md#list_errors) - List errors

### Transformations

Transform and enhance your video content with AI and editing capabilities.

#### In-Video AI Features
- [Update Summary](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/invideoaifeatures/README.md#update_media_summary) - Create AI-generated video summaries
- [Generate Chapters](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/invideoaifeatures/README.md#update_media_chapters) - Automatically generate video chapter markers
- [Extract Entities](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/invideoaifeatures/README.md#update_media_named_entities) - Identify and extract named entities from content
- [Enable Moderation](https://github.com/FastPix/fastpix-ruby/blob/feature/fixed-missing-parameters/docs/sdks/invideoaifeatures/README.md#update_media_moderation) - Activate content moderation and safety checks

## Error Handling

`FastpixClient::Models::Errors::APIError` is the primary error class for HTTP error responses. It has the following properties:

| Property       | Type                | Description           |
|----------------|---------------------|-----------------------|
| `message`      | `String`            | Error message         |
| `status_code`  | `Integer`           | HTTP response status code (e.g. 404) |
| `raw_response` | `Faraday::Response` | Raw HTTP response     |
| `body`         | `String`            | HTTP body. Can be empty if no body is returned. |

### Example

```ruby
require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: 'your-access-token',
    password: 'your-secret-key'
  )
)

begin
  req = Models::Components::CreateMediaRequest.new(
    inputs: [
      Models::Components::PullVideoInput.new(
        type: 'video',
        url: 'https://static.fastpix.io/fp-sample-video.mp4',
      ),
    ],
    metadata: { 'key1' => 'value1' },
  )
  res = s.input_video.create_media(request: req)
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts e.message
  puts e.status_code
  puts e.body
rescue StandardError
  puts res.raw_response.body.to_s if defined?(res) && res&.raw_response
end
```

## Server Selection

### Override Server URL Per-Client

The default server can be overridden globally by passing a URL to the `server_url` optional parameter when initializing the SDK client instance:

```ruby
require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
  server_url: 'https://api.fastpix.io/v1/',
  security: Models::Components::Security.new(
    username: 'your-access-token',
    password: 'your-secret-key'
  )
)

req = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::PullVideoInput.new(
      type: 'video',
      url: 'https://static.fastpix.io/fp-sample-video.mp4',
    ),
  ],
  metadata: { 'key1' => 'value1' },
)

begin
  res = s.input_video.create_media(request: req)
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s if defined?(res) && res&.raw_response
end
```

# Development

This Ruby SDK is programmatically generated from our API specifications. Any manual modifications to internal files may be overwritten during subsequent generation cycles.

We value community contributions and feedback. Feel free to submit pull requests or open issues with your suggestions, and we'll do our best to include them in future releases.

## Maturity

This SDK is in beta, and there may be breaking changes between versions without a major version update. Therefore, we recommend pinning usage to a specific package version so you can install the same version each time without breaking changes unless you are intentionally looking for the latest version.

## Detailed Usage

For comprehensive understanding of each API's functionality, including detailed request and response specifications, parameter descriptions, and additional examples, please refer to the [FastPix API Reference](https://docs.fastpix.io/reference/signingkeys-overview).

The API reference offers complete documentation for all available endpoints and features, enabling developers to integrate and leverage FastPix APIs effectively.
