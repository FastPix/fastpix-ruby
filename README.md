# FastPix Ruby SDK

Developer-friendly & type-safe Ruby SDK for integrating with the FastPix Live Streaming API.

[![License: Apache-2.0](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
---

## Introduction

The FastPix Ruby SDK simplifies integration with the FastPix platform. This SDK is designed for secure and efficient communication with the FastPix API, enabling easy management of media uploads, live streaming, and simulcasting.

## Key Features

- **Media API**
  - Upload media files seamlessly from URLs or devices
  - Manage media: list, fetch, update, and delete media assets
  - Generate and manage playback IDs for media access
- **Live API**
  - Create, list, update, and delete live streams
  - Generate playback IDs for live streams to control and manage access
  - Simulcast to multiple platforms simultaneously

## Prerequisites

- Ruby 2.7 or later
- FastPix API credentials (Access Token and Secret Key)

## Getting Started with FastPix

To get started with the **FastPix Ruby SDK**, ensure you have the following:

- The FastPix APIs are authenticated using an **Access Token** and a **Secret Key**. You must generate these credentials to use the SDK.
- Follow the steps in the Authentication with Access Tokens guide to obtain your credentials.

---

## Table of Contents

- [Installation](#installation)
- [Quick Start](#quick-start)
- [Authentication](#authentication)
- [Available Resources & Operations](#available-resources--operations)
- [Error Handling](#error-handling)
- [Server Selection](#server-selection)
- [Development](#development)
- [Contributing](#contributing)

---

## Installation

You can install the SDK using one of the following methods:

### 1. From GitHub (recommended for unpublished gems)

```bash
gem install specific_install
gem specific_install https://github.com/FastPix/fastpix-ruby.git
```

### 2. Using Bundler in your Gemfile

```ruby
gem 'fastpixapi', git: 'https://github.com/FastPix/fastpix-ruby.git'
```

### 3. Local development (if you have the code locally)

```bash
gem build fastpixapi.gemspec
gem install ./fastpixapi-0.0.1.gem
```

### 4. (Optional) If published to RubyGems.org

Once published, you can simply run:

```bash
gem install fastpixapi
```

---

## Quick Start

Here's how to get started with the FastPix Ruby SDK:

```ruby
require 'fastpixapi'

# Initialize the SDK with authentication
sdk = ::FastpixApiSDK::SDK.new(
  security: Models::Components::Security.new(
    username: 'your-username',
    password: 'your-password'
  )
)

# Create a new live stream
request = Models::Components::CreateLiveStreamRequest.new(
  playback_settings: Models::Components::PlaybackSettings.new(),
  input_media_settings: Models::Components::InputMediaSettings.new(
    metadata: Models::Components::CreateLiveStreamRequestMetadata.new()
  )
)

response = sdk.start_live_stream.create_new_stream(request)

if !response.live_stream_response_dto.nil?
  puts "Stream created! ID: #{response.live_stream_response_dto.stream_id}"
end
```

---

## Authentication

The SDK uses HTTP Basic authentication. Set your credentials when initializing the SDK:

```ruby
sdk = ::FastpixApiSDK::SDK.new(
  security: Models::Components::Security.new(
    username: 'your-username',
    password: 'your-password'
  )
)
```

---

## Available Resources & Operations

### [inputVideo()](docs/sdks/inputvideo/README.md)
* [createMedia](docs/sdks/inputvideo/README.md#createmedia) - Create media from URL
* [directUploadVideoMedia](docs/sdks/inputvideo/README.md#directuploadvideomedia) - Upload media from device

### [manageLiveStream()](docs/sdks/managelivestream/README.md)
* [getAllStreams](docs/sdks/managelivestream/README.md#getallstreams) - Get all live streams
* [getLiveStreamById](docs/sdks/managelivestream/README.md#getlivestreambyid) - Get stream by ID
* [deleteLiveStream](docs/sdks/managelivestream/README.md#deletelivestream) - Delete a stream
* [updateLiveStream](docs/sdks/managelivestream/README.md#updatelivestream) - Update a stream

### [manageVideos()](docs/sdks/managevideos/README.md)
* [listMedia](docs/sdks/managevideos/README.md#listmedia) - Get list of all media
* [getMedia](docs/sdks/managevideos/README.md#getmedia) - Get a media by ID
* [updatedMedia](docs/sdks/managevideos/README.md#updatedmedia) - Update a media by ID
* [deleteMedia](docs/sdks/managevideos/README.md#deletemedia) - Delete a media by ID
* [retrieveMediaInputInfo](docs/sdks/managevideos/README.md#retrievemediainputinfo) - Get info of media inputs

### [playback()](docs/sdks/playback/README.md)
* [createPlaybackIdOfStream](docs/sdks/playback/README.md#createplaybackidofstream) - Create a playbackId
* [deletePlaybackIdOfStream](docs/sdks/playback/README.md#deleteplaybackidofstream) - Delete a playbackId
* [getLiveStreamPlaybackId](docs/sdks/playback/README.md#getlivestreamplaybackid) - Get stream's playbackId
* [createMediaPlaybackId](docs/sdks/playback/README.md#createmediaplaybackid) - Create a playback ID
* [deleteMediaPlaybackId](docs/sdks/playback/README.md#deletemediaplaybackid) - Delete a playback ID

### [simulcastStream()](docs/sdks/simulcaststream/README.md)
* [createSimulcastOfStream](docs/sdks/simulcaststream/README.md#createsimulcastofstream) - Create a simulcast
* [deleteSimulcastOfStream](docs/sdks/simulcaststream/README.md#deletesimulcastofstream) - Delete a simulcast
* [getSpecificSimulcastOfStream](docs/sdks/simulcaststream/README.md#getspecificsimulcastofstream) - Get a specific simulcast of a stream
* [updateSpecificSimulcastOfStream](docs/sdks/simulcaststream/README.md#updatespecificsimulcastofstream) - Update a specific simulcast of a stream

### [startLiveStream()](docs/sdks/startlivestream/README.md)
* [createNewStream](docs/sdks/startlivestream/README.md#createnewstream) - Create a new stream

#### Example: List All Live Streams

```ruby
streams = sdk.manage_live_stream.get_all_streams
streams.each do |stream|
  puts "Stream ID: #{stream.id}, Status: #{stream.status}"
end
```

---

## Error Handling

All operations return a response object or raise an error. For example:

```ruby
begin
  response = sdk.start_live_stream.create_new_stream(request)
rescue Models::Errors::UnauthorizedError => e
  puts "Unauthorized: #{e.message}"
rescue Models::Errors::InvalidPermissionError => e
  puts "Permission error: #{e.message}"
rescue Models::Errors::ValidationErrorResponse => e
  puts "Validation error: #{e.message}"
rescue Errors::APIError => e
  puts "API error: #{e.message}"
end
```

---

## Server Selection

You can override the default server URL when initializing the SDK:

```ruby
sdk = ::FastpixApiSDK::SDK.new(
  server_url: 'https://api.fastpix.io/v1/live',
  security: Models::Components::Security.new(
    username: 'your-username',
    password: 'your-password'
  )
)
```

---

## Development

### Maturity

This SDK is currently in beta, and breaking changes may occur between versions even without a major version update. To avoid unexpected issues, we recommend pinning your dependency to a specific version. This ensures consistent behavior unless you intentionally update to a newer release.

## Documentation

For a complete understanding of each API's functionality, including request and response details, parameter descriptions, and additional examples, please refer to the [FastPix API Reference](https://docs.fastpix.io/reference/signingkeys-overview).

The API reference provides comprehensive documentation for all available endpoints and features, ensuring developers can integrate and utilize FastPix APIs efficiently.

---

## Contributing

We welcome contributions from the community! If you're interested in contributing to the FastPix Ruby SDK, please follow these steps:

1. Fork the repository
2. Create a new branch for your feature or bug fix
3. Make your changes and commit them
4. Push your changes to your fork
5. Create a pull request



