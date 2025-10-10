# FastPix Ruby SDK Samples

This directory contains comprehensive examples demonstrating how to use the FastPix Ruby SDK for various API operations.

## Prerequisites

Before running these samples, ensure you have:

- Ruby 3.2+ installed
- FastPix API credentials (username and password)
- Internet connection

## Setup

1. Install the FastPix Ruby SDK:
   ```bash
   gem install fastpixapi
   ```

2. Set your credentials as environment variables:
   ```bash
   export FASTPIX_USERNAME="your_username_here"
   export FASTPIX_PASSWORD="your_password_here"
   ```

3. Run any sample:
   ```bash
   ruby samples/basic_usage.rb
   ```

## Sample Files

### Core Examples
- **`basic_usage.rb`** - Basic SDK setup and authentication
- **`error_handling.rb`** - Comprehensive error handling examples
- **`configuration.rb`** - SDK configuration options

### Media Management
- **`media_upload.rb`** - Upload media from URL and direct upload
- **`media_management.rb`** - List, get, update, and delete media
- **`media_tracks.rb`** - Add and manage media tracks (audio/subtitles)

### Live Streaming
- **`live_streaming.rb`** - Create and manage live streams
- **`live_playback.rb`** - Manage live stream playback IDs
- **`simulcast.rb`** - Simulcast streams to external platforms

### Playback Management
- **`playback_ids.rb`** - Create and manage playback IDs for media
- **`playlist_management.rb`** - Create and manage playlists

### Analytics & Data
- **`analytics.rb`** - Video analytics and performance tracking
- **`metrics.rb`** - Metrics and data insights

### Security & Authentication
- **`signing_keys.rb`** - Manage cryptographic signing keys
- **`drm_configuration.rb`** - DRM configuration management

### AI Features
- **`ai_features.rb`** - In-video AI processing features

## Running Samples

Each sample is self-contained and can be run independently:

```bash
# Run a specific sample
ruby samples/media_upload.rb

# Run all samples (if you have a runner script)
ruby samples/run_all_samples.rb
```

## Important Notes

- Replace placeholder credentials with your actual FastPix credentials
- Some operations may require specific data to be available in your FastPix account
- Error handling is included in all samples to demonstrate proper SDK usage
- Samples include both success and error scenarios

## Troubleshooting

If you encounter issues:

1. Verify your credentials are correct
2. Check your internet connection
3. Ensure you're using Ruby 3.2+
4. Check the FastPix API documentation for any service-specific requirements

## Support

For additional help:
- Check the main SDK documentation
- Visit the FastPix API documentation
- Review the error messages for specific guidance
