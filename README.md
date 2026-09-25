# FastPix Ruby SDK

[![Gem version](https://img.shields.io/gem/v/fastpixapi)](https://rubygems.org/gems/fastpixapi)
[![Gem downloads](https://img.shields.io/gem/dt/fastpixapi)](https://rubygems.org/gems/fastpixapi)
[![license](https://img.shields.io/github/license/FastPix/fastpix-ruby)](https://github.com/FastPix/fastpix-ruby/blob/main/LICENSE)
[![Ruby 3.2+](https://img.shields.io/badge/Ruby-3.2%2B-CC342D?logo=ruby&logoColor=white)](https://www.ruby-lang.org/)

A robust, type-safe Ruby SDK for integrating Ruby applications with the FastPix video API.

The FastPix Ruby SDK lets you upload and manage on-demand video, create and manage live streams, create playback IDs, manage playlists and signing keys, retrieve video analytics, and use in-video AI capabilities.

**Works with:** Ruby 3.2+ · Bundler · RubyGems · FastPix API

📖 **Docs:** https://fastpix.com/docs/language-sdks/ruby-sdk
🚀 **Free account:** https://dashboard.fastpix.com

## Jump to

Skip straight to a section without scrolling:

| Get started | API reference | Help & more |
|---|---|---|
| [Start here](#start-here) | [Available resources & operations](#available-resources-and-operations) | [FAQ](#faq) |
| [Before you begin](#before-you-begin) | [Media workflow](#understand-the-media-workflow) | [Which SDK?](#which-fastpix-sdk-should-i-use) |
| [Install the SDK](#install-the-sdk) | [Error handling](#error-handling) | [Development](#development) |
| [Create your first media](#create-your-first-media) | [Server selection](#server-selection) | [Maturity](#maturity) |
| [Verify your integration](#verify-your-integration) | [Examples](https://github.com/FastPix/fastpix-ruby/tree/main/examples) | [Detailed usage](#detailed-usage) |

## Start here

If you are using the FastPix Ruby SDK for the first time, follow these steps in order:

1. [Check your Ruby version](#check-your-ruby-version)
2. [Install the SDK](#install-the-sdk)
3. [Configure authentication](#configure-authentication)
4. [Initialize the FastPix client](#initialize-the-fastpix-client)
5. [Create your first media](#create-your-first-media)
6. [Verify your integration](#verify-your-integration)
7. [Understand the media workflow](#understand-the-media-workflow)
8. [Explore the available APIs](#available-resources-and-operations)

Do not skip the verification steps. If a Ruby, dependency, or authentication problem occurs, fix it before continuing to the next API operation.

---

## Before you begin

To use the FastPix Ruby SDK, make sure you have:

- Ruby 3.2 or later.
- Bundler.
- Internet access.
- A FastPix account.
- A FastPix Access Token.
- A FastPix Secret Key.

### Environment and version support

| Requirement | Version | Description |
| --- | --- | --- |
| Ruby | `3.2+` | Core runtime environment |
| Bundler | Latest | Dependency management |
| Internet | Required | API communication and authentication |
| FastPix account | Required | Required for API credentials |

The SDK is intended for Ruby 3.2 and later.

### Authentication

FastPix uses HTTP Basic Authentication.

| SDK value | FastPix credential |
| --- | --- |
| `username` | Access Token |
| `password` | Secret Key |

Follow the [Authentication with Basic Auth](https://fastpix.com/docs/getting-started/activate-your-account) guide to obtain your credentials.

For local development, set your credentials as environment variables:

```bash
export FASTPIX_USERNAME="your-access-token"
export FASTPIX_PASSWORD="your-secret-key"
```

Never commit credentials to source control. Use environment variables or a secure credential-management system.

---

## Check your Ruby version

Before installing the SDK, verify that your Ruby version meets the minimum requirement:

```bash
ruby -v
```

You can also run this check programmatically:

```bash
ruby -e 'v = RUBY_VERSION.split(".").map(&:to_i); abort("Ruby 3.2+ is required. Found #{RUBY_VERSION}") if v < [3,2,0]; puts "Ruby #{RUBY_VERSION} OK"'
```

If the command prints:

```text
Ruby 3.2+ is required...
```

install a supported Ruby version before continuing.

### macOS with Homebrew

If you use Homebrew on Apple Silicon:

```bash
brew install ruby
```

Add the Homebrew Ruby installation to your `PATH`:

```bash
echo 'export PATH="/opt/homebrew/opt/ruby/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```

Verify that your shell is using the Homebrew Ruby:

```bash
which ruby
ruby -v
```

The `which ruby` command should return a path under:

```text
/opt/homebrew/opt/ruby/bin/ruby
```

> **Note:** macOS may include an older system Ruby. Installing a newer Ruby does not automatically make it the default `ruby` command.

### Check Bundler

Verify that Bundler is available:

```bash
bundle -v
```

If Bundler is not installed:

```bash
gem install bundler
```

Verify the installation:

```bash
bundle -v
```

---

## Install the SDK

The FastPix Ruby SDK is distributed as the `fastpixapi` RubyGem.

### Install with Bundler

For an existing Ruby project, add the SDK to your project:

```bash
bundle add fastpixapi
```

Then verify that Ruby can load the SDK:

```bash
bundle exec ruby -e 'require "fastpixapi"; puts "FastPix Ruby SDK loaded successfully"'
```

### Install with RubyGems

If you are not using Bundler:

```bash
gem install fastpixapi
```

Verify the installation:

```bash
ruby -e 'require "fastpixapi"; puts "FastPix Ruby SDK loaded successfully"'
```

You can also check the installed gem:

```bash
gem list '^fastpixapi$'
```

---

## Configure authentication

FastPix uses Basic Authentication. Set your Access Token and Secret Key as environment variables so they stay out of your source code:

```bash
export FASTPIX_USERNAME="your-access-token"
export FASTPIX_PASSWORD="your-secret-key"
```

Confirm that both variables are set without displaying their values:

```bash
[ -n "$FASTPIX_USERNAME" ] && echo "Access Token: set" || echo "Access Token: missing"
[ -n "$FASTPIX_PASSWORD" ] && echo "Secret Key: set" || echo "Secret Key: missing"
```

You can also validate both variables with Ruby:

```bash
ruby -e 'abort("FASTPIX_USERNAME is not set") if ENV["FASTPIX_USERNAME"].to_s.empty?; abort("FASTPIX_PASSWORD is not set") if ENV["FASTPIX_PASSWORD"].to_s.empty?; puts "FastPix credentials are configured"'
```

> **Security:** Never print, commit, or hard-code your Access Token or Secret Key.

---

## Initialize the FastPix client

Create a project directory, then initialize the client and create your first media:

```bash
mkdir fastpix-ruby-demo
cd fastpix-ruby-demo
```

---

## Create your first media

The easiest way to verify your integration is to create media from a publicly accessible video URL.

FastPix provides a sample video:

```text
https://static.fastpix.com/fp-sample-video.mp4
```

Create an `example.rb` file:

```bash
cat > example.rb <<'RUBY'
require "json"
require "fastpixapi"

Models = ::FastpixClient::Models

client = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: ENV.fetch("FASTPIX_USERNAME"),
    password: ENV.fetch("FASTPIX_PASSWORD")
  )
)

request = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::PullVideoInput.new(
      type: "video",
      url: "https://static.fastpix.com/fp-sample-video.mp4"
    )
  ],
  metadata: {
    "source" => "fastpix-ruby-readme"
  }
)

begin
  response = client.input_video.create_media(request: request)

  puts JSON.pretty_generate(
    JSON.parse(response.raw_response.body)
  )
rescue FastpixClient::Models::Errors::APIError => e
  warn "FastPix API request failed"
  warn "Status: #{e.status_code}"
  warn "Message: #{e.message}"
  warn "Body: #{e.body}"
  exit 1
end
RUBY
```

Run the example:

```bash
bundle exec ruby example.rb
```

If you installed the SDK with `gem install`, run:

```bash
ruby example.rb
```

> **More examples:** For additional runnable examples, see the [`examples/`](https://github.com/FastPix/fastpix-ruby/tree/main/examples) directory in this repository.

---

## Verify your integration

A successful request returns a response containing the newly created media resource.

A successful response contains:

```json
{
  "success": true,
  "data": {
    "id": "..."
  }
}
```

The `data.id` value is the unique media ID assigned to the media.

For an automated verification, use this version of the example:

```bash
cat > verify.rb <<'RUBY'
require "json"
require "fastpixapi"

Models = ::FastpixClient::Models

abort("FASTPIX_USERNAME is not set") if ENV["FASTPIX_USERNAME"].to_s.empty?
abort("FASTPIX_PASSWORD is not set") if ENV["FASTPIX_PASSWORD"].to_s.empty?

client = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: ENV.fetch("FASTPIX_USERNAME"),
    password: ENV.fetch("FASTPIX_PASSWORD")
  )
)

request = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::PullVideoInput.new(
      type: "video",
      url: "https://static.fastpix.com/fp-sample-video.mp4"
    )
  ],
  metadata: {
    "source" => "fastpix-ruby-readme"
  }
)

begin
  response = client.input_video.create_media(request: request)
  body = JSON.parse(response.raw_response.body)

  abort("FastPix API returned success=false") unless body["success"]

  media_id = body.dig("data", "id")
  abort("FastPix API response did not contain data.id") unless media_id

  puts "Media created successfully"
  puts "Media ID: #{media_id}"
rescue FastpixClient::Models::Errors::APIError => e
  warn "FastPix API request failed"
  warn "Status: #{e.status_code}"
  warn "Message: #{e.message}"
  warn "Body: #{e.body}"
  exit 1
end
RUBY
```

Run it:

```bash
bundle exec ruby verify.rb
```

Expected output:

```text
Media created successfully
Media ID: <media-id>
```

If you see this output, your Ruby environment, SDK installation, credentials, and connection to the FastPix API are working.

## Understand the media workflow

Creating media is usually the first step in a FastPix on-demand video workflow. You create the media, poll it until processing finishes, then create a playback ID to play it.

![FastPix media workflow: create media returns a media ID, you retrieve and poll the media until it is ready, then create a playback ID and play the video.](https://static.fastpix.com/ruby-media-workflow.png)

The **media ID** identifies the media resource in subsequent API calls.

A **playback ID** provides access to the media for playback.

For more information about the video-on-demand workflow, see the [FastPix Video on Demand documentation](https://fastpix.com/docs).

## Available Resources and Operations

Comprehensive Ruby SDK for FastPix platform integration with full API coverage.

### Media API

Upload, manage, and transform video content with comprehensive media management capabilities.

For detailed documentation, see [FastPix Video on Demand Overview](https://fastpix.com/docs/video-on-demand-api/overview).

#### Input Video
- [Create from URL](docs/sdks/inputvideo/README.md#create_media) - Upload video content from external URL
- [Upload from Device](docs/sdks/inputvideo/README.md#direct_upload_video_media) - Upload video files directly from device

#### Manage Videos
- [List All Media](docs/sdks/managevideos/README.md#list_media) - Retrieve complete list of all media files
- [Get Media by ID](docs/sdks/managevideos/README.md#get_media) - Get detailed information for specific media
- [Update Media](docs/sdks/managevideos/README.md#updated_media) - Modify media metadata and settings
- [Delete Media](docs/sdks/managevideos/README.md#delete_media) - Remove media files from library
- [Cancel Upload](docs/sdks/managevideos/README.md#cancel_upload) - Stop ongoing media upload process
- [Get Input Info](docs/sdks/managevideos/README.md#retrieve_media_input_info) - Retrieve detailed input information
- [List Uploads](docs/sdks/managevideos/README.md#list_uploads) - Get all available upload URLs
- [Get Media Clips](docs/sdks/managevideos/README.md#get_media_clips) - Get all clips of a media
- [Get Media Summary](docs/sdks/managevideos/README.md#get_media_summary) - Get the summary of a video
- [Update Source Access](docs/sdks/managevideos/README.md#updated_source_access) - Update the source access of a media by ID
- [Update MP4 Support](docs/sdks/managevideos/README.md#updated_mp4_support) - Update the mp4Support of a media by ID
- [Add Media Track](docs/sdks/managevideos/README.md#add_media_track) - Add audio or subtitle track
- [Update Media Track](docs/sdks/managevideos/README.md#update_media_track) - Update audio or subtitle track
- [Delete Media Track](docs/sdks/managevideos/README.md#delete_media_track) - Delete audio or subtitle track
- [Generate Subtitle Track](docs/sdks/managevideos/README.md#generate_subtitle_track) - Generate track subtitle
- [List Live Clips](docs/sdks/managevideos/README.md#list_live_clips) - Get all clips of a live stream

#### Playback
- [Create Playback ID](docs/sdks/playback/README.md#create_media_playback_id) - Generate secure playback identifier
- [List Playback IDs](docs/sdks/playback/README.md#list_playback_ids) - Get all playback IDs details for a media
- [Delete Playback ID](docs/sdks/playback/README.md#delete_media_playback_id) - Remove playback access
- [Get Playback ID](docs/sdks/playback/README.md#get_playback_id) - Retrieve playback configuration details
- [Update Domain Restrictions](docs/sdks/playback/README.md#update_domain_restrictions) - Update domain restrictions for a playback ID
- [Update User-Agent Restrictions](docs/sdks/playback/README.md#update_user_agent_restrictions) - Update user-agent restrictions for a playback ID

#### Playlist
- [Create Playlist](docs/sdks/playlist/README.md#create_a_playlist) - Create new video playlist
- [List Playlists](docs/sdks/playlist/README.md#get_all_playlists) - Get all available playlists
- [Get Playlist](docs/sdks/playlist/README.md#get_playlist_by_id) - Retrieve specific playlist details
- [Update Playlist](docs/sdks/playlist/README.md#update_a_playlist) - Modify playlist settings and metadata
- [Delete Playlist](docs/sdks/playlist/README.md#delete_a_playlist) - Remove playlist from library
- [Add Media](docs/sdks/playlist/README.md#add_media_to_playlist) - Add media items to playlist
- [Change Media Order](docs/sdks/playlist/README.md#change_media_order_in_playlist) - Change order of media in playlist
- [Delete Media from Playlist](docs/sdks/playlist/README.md#delete_media_from_playlist) - Remove media from playlist

#### Signing Keys
- [Create Key](docs/sdks/signingkeys/README.md#create_signing_key) - Generate new signing key pair
- [List Keys](docs/sdks/signingkeys/README.md#list_signing_keys) - Get all available signing keys
- [Delete Key](docs/sdks/signingkeys/README.md#delete_signing_key) - Remove signing key from system
- [Get Key by ID](docs/sdks/signingkeys/README.md#get_signing_key_by_id) - Retrieve specific signing key details

#### DRM Configurations
- [List DRM Configs](docs/sdks/drmconfigurations/README.md#get_drm_configuration) - Get all DRM configuration options
- [Get DRM Config](docs/sdks/drmconfigurations/README.md#get_drm_configuration_by_id) - Retrieve specific DRM configuration

### Live API

Stream, manage, and transform live video content with real-time broadcasting capabilities.

For detailed documentation, see [FastPix Live Stream Overview](https://fastpix.com/docs/live-stream-api/overview).

#### Start Live Stream
- [Create Stream](docs/sdks/startlivestream/README.md#create_new_stream) - Initialize new live streaming session

#### Manage Live Stream
- [List Streams](docs/sdks/managelivestream/README.md#get_all_streams) - Retrieve all active live streams
- [Get Viewer Count](docs/sdks/managelivestream/README.md#get_live_stream_viewer_count_by_id) - Get real-time viewer statistics
- [Get Stream](docs/sdks/managelivestream/README.md#get_live_stream_by_id) - Retrieve detailed stream information
- [Delete Stream](docs/sdks/managelivestream/README.md#delete_live_stream) - Terminate and remove live stream
- [Update Stream](docs/sdks/managelivestream/README.md#update_live_stream) - Modify stream settings and configuration
- [Enable Stream](docs/sdks/managelivestream/README.md#enable_live_stream) - Activate live streaming
- [Disable Stream](docs/sdks/managelivestream/README.md#disable_live_stream) - Pause live streaming
- [Complete Stream](docs/sdks/managelivestream/README.md#complete_live_stream) - Finalize and archive stream

#### Live Playback
- [Create Playback ID](docs/sdks/liveplayback/README.md#create_playback_id_of_stream) - Generate secure live playback access
- [Delete Playback ID](docs/sdks/liveplayback/README.md#delete_playback_id_of_stream) - Revoke live playback access
- [Get Playback ID](docs/sdks/liveplayback/README.md#get_live_stream_playback_id) - Retrieve live playback configuration
- [Update Domain Restrictions](docs/sdks/liveplayback/README.md#update_live_stream_domain_restrictions) - Restrict live playback by domain
- [Update User-Agent Restrictions](docs/sdks/liveplayback/README.md#update_live_stream_user_agent_restrictions) - Restrict live playback by user agent

#### Simulcast Stream
- [Create Simulcast](docs/sdks/simulcaststream/README.md#create_simulcast_of_stream) - Set up multi-platform streaming
- [Delete Simulcast](docs/sdks/simulcaststream/README.md#delete_simulcast_of_stream) - Remove simulcast configuration
- [Get Simulcast](docs/sdks/simulcaststream/README.md#get_specific_simulcast_of_stream) - Retrieve simulcast settings
- [Update Simulcast](docs/sdks/simulcaststream/README.md#update_specific_simulcast_of_stream) - Modify simulcast parameters

### Video Data API

Monitor video performance and quality with comprehensive analytics and real-time metrics.

For detailed documentation, see [FastPix Video Data Overview](
https://fastpix.com/docs/video-data-api/overview).

#### Metrics
- [List Breakdown Values](docs/sdks/metrics/README.md#list_breakdown_values) - Get detailed breakdown of metrics by dimension
- [List Overall Values](docs/sdks/metrics/README.md#list_overall_values) - Get aggregated metric values across all content
- [Get Timeseries Data](docs/sdks/metrics/README.md#get_timeseries_data) - Retrieve time-based metric trends and patterns
- [List Comparison Values](docs/sdks/metrics/README.md#list_comparison_values) - List comparison values

#### Views
- [List Video Views](docs/sdks/views/README.md#list_video_views) - Get comprehensive list of video viewing sessions
- [Get View Details](docs/sdks/views/README.md#get_video_view_details) - Retrieve detailed information about specific video views
- [List Top Content](docs/sdks/views/README.md#list_by_top_content) - Find your most popular and engaging content

#### Dimensions
- [List Dimensions](docs/sdks/dimensions/README.md#list_dimensions) - Get available data dimensions for filtering and analysis
- [List Filter Values](docs/sdks/dimensions/README.md#list_filter_values_for_dimension) - Get specific values for a particular dimension

#### Errors
- [List Errors](docs/sdks/errors/README.md#list_errors) - List errors

### Transformations

Transform and enhance your video content with AI and editing capabilities.

#### In-Video AI Features
- [Update Summary](docs/sdks/invideoaifeatures/README.md#update_media_summary) - Create AI-generated video summaries
- [Generate Chapters](docs/sdks/invideoaifeatures/README.md#update_media_chapters) - Automatically generate video chapter markers
- [Extract Entities](docs/sdks/invideoaifeatures/README.md#update_media_named_entities) - Identify and extract named entities from content
- [Enable Moderation](docs/sdks/invideoaifeatures/README.md#update_media_moderation) - Activate content moderation and safety checks

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
        url: 'https://static.fastpix.com/fp-sample-video.mp4',
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
  server_url: 'https://api.fastpix.com/v1/',
  security: Models::Components::Security.new(
    username: 'your-access-token',
    password: 'your-secret-key'
  )
)

req = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::PullVideoInput.new(
      type: 'video',
      url: 'https://static.fastpix.com/fp-sample-video.mp4',
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

## FAQ

**How do I install the FastPix Ruby SDK?**
Add `gem 'fastpixapi'` to your Gemfile and run `bundle install`, or run `gem install fastpixapi`. See [Install the SDK](#install-the-sdk).

**How do I authenticate the SDK?**
FastPix uses Basic Auth: pass your access token as `username` and your secret key as `password` in `Models::Components::Security` when constructing the client. See [Initialize the FastPix client](#initialize-the-fastpix-client).

**How do I upload a video in Ruby?**
Create media from a URL or a direct upload through `s.input_video`, for example `s.input_video.create_media(request: req)`. See [Create your first media](#create-your-first-media) and [Available Resources and Operations](#available-resources-and-operations).

**How do I start a live stream?**
Use the Live API resources to create and manage streams, simulcasts, and live playback IDs. See [Available Resources and Operations](#available-resources-and-operations).

**How do I get video analytics and metrics in Ruby?**
The Video Data API exposes metrics, views, dimensions, and errors for quality-of-experience monitoring. See [Available Resources and Operations](#available-resources-and-operations).

**How do I handle API errors?**
Rescue `FastpixClient::Models::Errors::APIError`, which exposes the message, status code, body, and raw response. See [Error Handling](#error-handling).

**How do I change the API base URL?**
Pass a `server_url` when constructing the client. See [Server Selection](#server-selection).

**Which Ruby versions are supported?**
Ruby 3.2 and above. See [Before you begin](#before-you-begin).

**Is the SDK production-ready?**
The SDK is currently in beta; pin your gem to a specific version to avoid breaking changes between releases. See [Maturity](#maturity).

**Is the SDK typed?**
Yes - it is a type-safe client generated from the FastPix API specification. See [Development](#development).

## Which FastPix SDK should I use?

FastPix publishes a server SDK for every major backend language, each generated from the same API specification:

| Language | Repo | Install |
|---|---|---|
| **Ruby** (this repo) | [fastpix-ruby](https://github.com/FastPix/fastpix-ruby) | `gem install fastpixapi` |
| Node.js / TypeScript | [node-sdk](https://github.com/FastPix/node-sdk) | `npm install @fastpix/fastpix-node` |
| Python | [fastpix-python](https://github.com/FastPix/fastpix-python) | `pip install fastpix-python` |
| PHP | [fastpix-php](https://github.com/FastPix/fastpix-php) | `composer require fastpix/sdk` |
| Go | [fastpix-go](https://github.com/FastPix/fastpix-go) | `go get github.com/FastPix/fastpix-go` |
| Java | [fastpix-java](https://github.com/FastPix/fastpix-java) | `io.fastpix:sdk` (Maven/Gradle) |
| C# / .NET | [fastpix-sdk-csharp](https://github.com/FastPix/fastpix-sdk-csharp) | `dotnet add package Fastpix` |

To upload and play the media these SDKs create, use the FastPix browser libraries: [web-uploads-sdk](https://github.com/FastPix/web-uploads-sdk), [react-web-uploader](https://github.com/FastPix/react-web-uploader), and [web-player-component](https://github.com/FastPix/web-player-component). Browse everything in the [FastPix organization](https://github.com/orgs/FastPix/repositories).

## Development

This Ruby SDK is programmatically generated from our API specifications. Any manual modifications to internal files may be overwritten during subsequent generation cycles.

We value community contributions and feedback. Feel free to submit pull requests or open issues with your suggestions, and we'll do our best to include them in future releases.

## Maturity

This SDK is in beta, and there may be breaking changes between versions without a major version update. Therefore, we recommend pinning usage to a specific package version so you can install the same version each time without breaking changes unless you are intentionally looking for the latest version.

## Detailed Usage

For comprehensive understanding of each API's functionality, including detailed request and response specifications, parameter descriptions, and additional examples, please refer to the [FastPix API Reference](https://fastpix.com/docs/product-os-api/overview).

The API reference offers complete documentation for all available endpoints and features, enabling developers to integrate and leverage FastPix APIs effectively.
