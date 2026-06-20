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

## 🔎 GET Endpoints OpenAPI/SDK Contract Validator

`validate_get_endpoints.rb` is a contract validator (the Ruby counterpart of the
PHP `Tests/validate-get-endpoints.ts`). For **every GET endpoint** in the OpenAPI
spec it:

1. Calls the **live API** directly and captures the raw JSON.
2. Validates that raw response against the **OpenAPI response schema** (using the
   optional [`json_schemer`](https://github.com/davishmcclurg/json_schemer) gem —
   if it isn't installed, this step is skipped and reported as such).
3. Calls the **Ruby SDK** method for the same `operationId` and captures either the
   parsed success object or the raised error (normalized).
4. Compares JSON paths between the raw API JSON and the SDK-parsed JSON, applying
   the same normalization rules used by the SDK (`snake_case` → `camelCase`,
   acronym casing, empty-array == missing, `null` == missing, and the
   `get_video_view_details` event-field remap).
5. Writes per-endpoint artifacts to `tests/artifacts/` and two reports:
   - `tests/GET_ENDPOINTS_OPENAPI_RESPONSE_VALIDATION_REPORT.md`
   - `tests/GET_ENDPOINTS_OPENAPI_RESPONSE_FIX_SUGGESTIONS.md`
   - and refreshes the consolidated table in this README (between the
     `GET_ENDPOINTS_CONSOLIDATED` markers below).

### Fixtures

Endpoints with required path params read real IDs from
`tests/get-endpoints-fixtures.json`. Add a real resource ID per `operationId` to
avoid `404`s (otherwise a placeholder UUID is used and the row is flagged):

```json
{
  "operations": {
    "get-media": { "pathParams": { "mediaId": "<real-media-id>" } },
    "list-media": { "query": { "limit": 5, "offset": 1, "orderBy": "desc" } }
  }
}
```

### Run

```bash
# Optional: enable OpenAPI response-schema validation
gem install json_schemer

# Run against the live API (real credentials required)
FASTPIX_USERNAME=your-access-token \
FASTPIX_PASSWORD=your-secret-key \
ruby tests/validate_get_endpoints.rb

# Optional: override the base URL (defaults to the spec's servers[0].url)
FASTPIX_BASE_URL=https://api.fastpix.com/v1/ \
FASTPIX_USERNAME=... FASTPIX_PASSWORD=... ruby tests/validate_get_endpoints.rb
```

### Latest consolidated results

<!-- BEGIN GET_ENDPOINTS_CONSOLIDATED -->
Last generated: 2026-06-20T06:26:53Z

- **Total GET endpoints**: 30
- **PASS**: 25
- **FAIL**: 5
- **SKIP**: 0

| Endpoint | OperationId | OpenAPI valid | SDK parse | Missing in SDK (present in API) | Missing in API (present in SDK) | Empty arrays omitted by SDK | Status |
|---|---|---:|---:|---|---|---|---|
| `/on-demand` | `list-media` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/on-demand/{livestreamId}/live-clips` | `list-live-clips` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/on-demand/{mediaId}` | `get-media` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/on-demand/{mediaId}/summary` | `get-media-summary` | ✅ | ❌ | None | None | None | ❌ FAIL |
| `/on-demand/{mediaId}/input-info` | `retrieveMediaInputInfo` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/on-demand/{mediaId}/playback-ids` | `list-playback-ids` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/on-demand/uploads` | `list-uploads` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/on-demand/{mediaId}/media-clips` | `get-media-clips` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/on-demand/playlists` | `get-all-playlists` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/on-demand/playlists/{playlistId}` | `get-playlist-by-id` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/on-demand/{mediaId}/playback-ids/{playbackId}` | `get-playback-id` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/on-demand/drm-configurations` | `getDrmConfiguration` | ✅ | ❌ | None | None | None | ❌ FAIL |
| `/on-demand/drm-configurations/{drmConfigurationId}` | `getDrmConfigurationById` | ✅ | ❌ | None | None | None | ❌ FAIL |
| `/live/streams` | `get-all-streams` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/live/streams/{streamId}/viewer-count` | `get-live-stream-viewer-count-by-id` | ✅ | ❌ | None | None | None | ❌ FAIL |
| `/live/streams/{streamId}` | `get-live-stream-by-id` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/live/streams/{streamId}/playback-ids/{playbackId}` | `get-live-stream-playback-id` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/live/streams/{streamId}/simulcast/{simulcastId}` | `get-specific-simulcast-of-stream` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/iam/signing-keys` | `list_signing_keys` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/iam/signing-keys/{signingKeyId}` | `get-signing_key_by_id` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/data/viewlist` | `list_video_views` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/data/viewlist/{viewId}` | `get_video_view_details` | ✅ | ✅ | `data.custom`, `data.custom.Device`, `data.custom.Device[]`, `data.custom.Device[].dimensionName`, `data.custom.Device[].displayName` | None | None | ❌ FAIL |
| `/data/viewlist/top-content` | `list_by_top_content` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/data/dimensions` | `list_dimensions` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/data/dimensions/{dimensionsId}` | `list_filter_values_for_dimension` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/data/metrics/{metricId}/breakdown` | `list_breakdown_values` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/data/metrics/{metricId}/overall` | `list_overall_values` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/data/metrics/{metricId}/timeseries` | `get_timeseries_data` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/data/metrics/comparison` | `list_comparison_values` | ✅ | ✅ | None | None | None | ✅ PASS |
| `/data/errors` | `list_errors` | ✅ | ✅ | None | None | None | ✅ PASS |

#### Missing fields (full lists)

- **list-media** (`/on-demand`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list-live-clips** (`/on-demand/{livestreamId}/live-clips`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-media** (`/on-demand/{mediaId}`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-media-summary** (`/on-demand/{mediaId}/summary`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **retrieveMediaInputInfo** (`/on-demand/{mediaId}/input-info`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list-playback-ids** (`/on-demand/{mediaId}/playback-ids`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list-uploads** (`/on-demand/uploads`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-media-clips** (`/on-demand/{mediaId}/media-clips`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-all-playlists** (`/on-demand/playlists`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-playlist-by-id** (`/on-demand/playlists/{playlistId}`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-playback-id** (`/on-demand/{mediaId}/playback-ids/{playbackId}`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **getDrmConfiguration** (`/on-demand/drm-configurations`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **getDrmConfigurationById** (`/on-demand/drm-configurations/{drmConfigurationId}`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-all-streams** (`/live/streams`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-live-stream-viewer-count-by-id** (`/live/streams/{streamId}/viewer-count`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-live-stream-by-id** (`/live/streams/{streamId}`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-live-stream-playback-id** (`/live/streams/{streamId}/playback-ids/{playbackId}`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-specific-simulcast-of-stream** (`/live/streams/{streamId}/simulcast/{simulcastId}`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list_signing_keys** (`/iam/signing-keys`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get-signing_key_by_id** (`/iam/signing-keys/{signingKeyId}`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list_video_views** (`/data/viewlist`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get_video_view_details** (`/data/viewlist/{viewId}`)
  - **Missing in SDK (present in API)**: `data.custom`, `data.custom.Device`, `data.custom.Device[]`, `data.custom.Device[].dimensionName`, `data.custom.Device[].displayName`
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list_by_top_content** (`/data/viewlist/top-content`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list_dimensions** (`/data/dimensions`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list_filter_values_for_dimension** (`/data/dimensions/{dimensionsId}`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list_breakdown_values** (`/data/metrics/{metricId}/breakdown`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list_overall_values** (`/data/metrics/{metricId}/overall`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **get_timeseries_data** (`/data/metrics/{metricId}/timeseries`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list_comparison_values** (`/data/metrics/comparison`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None
- **list_errors** (`/data/errors`)
  - **Missing in SDK (present in API)**: None
  - **Missing in API (present in SDK)**: None
  - **Empty arrays omitted by SDK**: None
  - **Empty arrays omitted by API**: None

Full details: `tests/GET_ENDPOINTS_OPENAPI_RESPONSE_VALIDATION_REPORT.md`
<!-- END GET_ENDPOINTS_CONSOLIDATED -->

## 🔁 Non-GET Endpoints Lifecycle Validator

`validate_non_get_endpoints.rb` is the mutating counterpart (Ruby port of the PHP
`Tests/validate-non-get-endpoints.ts`), following the same structure. Because
POST/PUT/PATCH/DELETE operations **mutate live data**, it cannot hit the raw API
and the SDK separately. Instead it invokes the Ruby SDK once per operation and,
from that single call, captures both the deserialized SDK value **and** the raw
HTTP status + body for OpenAPI validation.

It runs a self-cleaning **create → update → delete** lifecycle:

1. **CREATE** (POST) — creates real resources (signing key, playlist, stream,
   media, tracks, playback IDs, simulcast, upload) and captures their IDs.
2. **UPDATE** (PUT/PATCH) — exercises updates against the captured IDs.
3. **DELETE** (DELETE) — tears everything down **last**.

Steps whose required IDs were never captured (an upstream create failed) are
reported as **SKIP** instead of being called with `nil`s. It polls for async
provisioning (media → `Ready`, track → present) and retries operations that
return "not ready for updates". No fixtures are required.

```bash
# real credentials required — this creates and deletes real resources
FASTPIX_USERNAME=your-access-token \
FASTPIX_PASSWORD=your-secret-key \
ruby tests/validate_non_get_endpoints.rb
```

Output: per-operation artifacts in `tests/artifacts-non-get/` and a report at
`tests/NON_GET_ENDPOINTS_VALIDATION_REPORT.md` (Summary, Captured resources,
Consolidated table, Per-operation details).

> Note: `complete-live-stream` requires an actively-streaming encoder, so with no
> live ingest it is expected to fail — the one allowed failure in a
> credentials-only run.

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
