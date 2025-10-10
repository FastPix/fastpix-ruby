# FastPix Ruby SDK Test Suite

This comprehensive test suite covers all major FastPix API endpoints with detailed pass/fail reporting.

## 🧪 Test Classes

### 1. **Input Video APIs** (`test_input_video.rb`)
- ✅ Create media from URL
- ✅ Direct upload video media
- ✅ Direct upload with metadata
- ✅ Validation error handling

### 2. **Media Management APIs** (`test_manage_videos.rb`)
- ✅ List media with pagination
- ✅ Get media by ID
- ✅ Get media not found error
- ✅ List uploads
- ✅ Cancel upload
- ✅ Add media track
- ✅ Get media clips

### 3. **Playback Management APIs** (`test_playback.rb`)
- ✅ Create media playback ID
- ✅ Get playback ID
- ✅ Get playback ID not found error
- ✅ Delete media playback ID
- ✅ Create private playback ID
- ✅ Playback ID validation error

### 4. **Live Stream APIs** (`test_live_stream.rb`)
- ✅ Create new stream
- ✅ Get all streams
- ✅ Get live stream by ID
- ✅ Get live stream viewer count
- ✅ Update live stream
- ✅ Create playback ID of stream
- ✅ Create simulcast of stream
- ✅ Disable live stream
- ✅ Complete live stream
- ✅ Delete live stream

### 5. **Playlist Management APIs** (`test_playlist.rb`)
- ✅ Create a playlist
- ✅ Get all playlists
- ✅ Get playlist by ID
- ✅ Update a playlist
- ✅ Add media to playlist
- ✅ Change media order in playlist
- ✅ Delete media from playlist
- ✅ Delete a playlist
- ✅ Playlist not found error

### 6. **DRM Configuration APIs** (`test_drm.rb`)
- ✅ Get DRM configuration
- ✅ Get DRM configuration by ID
- ✅ Get DRM configuration not found error
- ✅ DRM configuration pagination
- ✅ DRM configuration with filters

### 7. **Analytics & Data APIs** (`test_analytics.rb`)
- ✅ List video views
- ✅ Get video view details
- ✅ List by top content
- ✅ Get timeseries views
- ✅ Filter views
- ✅ List dimensions
- ✅ Get filter values for dimension
- ✅ List overall values
- ✅ Get timeseries data
- ✅ List breakdown values
- ✅ List comparison values
- ✅ List signing keys
- ✅ Create signing key
- ✅ Get signing key by ID
- ✅ Delete signing key

## 🚀 Quick Start

### Prerequisites
1. **Ruby 3.2+** (as required by the SDK)
2. **Install dependencies**:
   ```bash
   bundle install
   # or
   gem install sorbet-runtime faraday faraday-multipart faraday-retry
   ```

### Run All Tests
```bash
# Run all test classes with your credentials
ruby tests/run_all_tests.rb your-access-token your-secret-key

# Example:
ruby tests/run_all_tests.rb abc123def456 xyz789secret
```

### Run Individual Test Classes
```bash
# Run specific test class
ruby -e "
require_relative 'tests/test_helper'
require_relative 'tests/test_input_video'
test = TestInputVideo.new('your-username', 'your-password')
test.test_create_media_from_url
"
```

## 📊 Test Output

The test suite provides detailed output showing:
- ✅ **PASSED** - Test completed successfully
- ❌ **FAILED** - Test failed with error details
- 📊 **Summary** - Total tests, passed, failed, success rate

### Example Output
```
🚀 FastPix Ruby SDK Test Suite
============================================================
📝 Testing with credentials: your-access-token / ************
============================================================

🧪 TESTING INPUT VIDEO APIS
============================================================
✅ Create Media from URL - PASSED
✅ Direct Upload Video Media - PASSED
✅ Direct Upload with Metadata - PASSED
✅ Create Media Validation Error Handling - PASSED

🧪 TESTING MEDIA MANAGEMENT APIS
============================================================
✅ List Media - PASSED
✅ List Media with Pagination - PASSED
✅ Get Media by ID - PASSED
✅ Get Media Not Found Error - PASSED
✅ List Uploads - PASSED
✅ Cancel Upload - PASSED
✅ Add Media Track - PASSED
✅ Get Media Clips - PASSED

... (continues for all test classes)

============================================================
📊 TEST SUMMARY
============================================================
Total Tests: 67
Passed: 65 ✅
Failed: 2 ❌
Success Rate: 97.0%
============================================================

❌ Some tests failed. Please check the output above.
```

## 🔧 Features

- **Comprehensive Coverage** - Tests all major API endpoints
- **Real API Calls** - Tests actual FastPix API endpoints
- **Error Handling** - Tests both success and error scenarios
- **Resource Cleanup** - Automatic cleanup of created resources
- **Detailed Reporting** - Clear pass/fail status with error details
- **Graceful Skipping** - Skips tests when resources aren't available
- **Command Line Interface** - Easy username/password passing
- **Modular Design** - Individual test classes for each API category

## 🐛 Troubleshooting

### Common Issues

1. **Missing Dependencies**
   ```
   cannot load such file -- sorbet-runtime
   ```
   **Solution**: Run `bundle install` or install gems manually

2. **Ruby Version Error**
   ```
   Ruby version 2.6.10 is not supported
   ```
   **Solution**: Use Ruby 3.2 or higher

3. **Authentication Errors**
   ```
   Unauthorized (401)
   ```
   **Solution**: Check your credentials are correct

4. **Network Errors**
   ```
   Connection refused
   ```
   **Solution**: Check your internet connection and API endpoint

### Getting Help
- Check the FastPix API documentation
- Verify your credentials are correct
- Ensure you have the required permissions
- Check the test output for specific error details
