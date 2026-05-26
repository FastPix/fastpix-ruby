# Changelog

All notable changes to this project will be documented in this file.

## [1.1.2]

### ⚠️ Important — FastPix is migrating from `.io` to `.com`

All FastPix hosts and documentation links are moving to the `.com` TLD:

| Old (`.io`) | New (`.com`) |
|---|---|
| `api.fastpix.io` | `api.fastpix.com` |
| `stream.fastpix.io` | `stream.fastpix.com` |
| `images.fastpix.io` | `images.fastpix.com` |
| `dashboard.fastpix.io` | `dashboard.fastpix.com` |
| `www.fastpix.io` | `www.fastpix.com` |
| `docs.fastpix.io/...` | `fastpix.com/docs/...` |

The `.io` hosts continue to serve traffic during the transition, but **they are slated for deprecation soon** — please update any hard-coded references in your application as part of your next deploy. **We strongly recommend upgrading to this SDK release (or later) across every language you use** — every official FastPix SDK is being rolled out with the same migration.

What this means for users of the `fastpixapi` gem:

- **If you rely on SDK defaults**, no code change is required. The default server URL is `https://api.fastpix.com/v1/`, so bumping to `1.1.2` and running `bundle update fastpixapi` (or `gem update fastpixapi`) is enough.
- **If you have an explicit server-URL override** (e.g. `::FastpixClient::Fastpixapi.new(server_url: 'https://api.fastpix.io/v1/')`), change it to `https://api.fastpix.com/v1/`.
- **If you reference FastPix asset URLs directly** in your app (HLS playback URLs, image CDN, dashboard deep links), update those to the `.com` equivalents before `.io` is decommissioned.

All README and per-service doc links in this package have been updated to point at the new `https://fastpix.com/docs/...` URLs.

### Fixed (SDK ↔ API parity)

- `dimensions.list_filter_values_for_dimension`, `metrics.list_breakdown_values` / `list_overall_values`, `metrics.get_timeseries_data`: fixed enum **path** parameters (e.g. `dimensionsId`, `metricId`) being serialized as their Ruby object inspect string instead of the wire value in `Utils.generate_url`, which produced invalid URLs (`.../#<...::BROWSER_NAME>`) and caused these calls to fail.
- `signing_keys.delete_signing_key` (`/iam/signing-keys/{signingKeyId}`): response shape now includes the optional `data.message` confirmation string the API returns (added to both the OpenAPI spec and the SDK model).

### Docs

- All README and per-service documentation pages updated from `docs.fastpix.io/...` and `docs.fastpix.com/...` to the new `https://fastpix.com/docs/...` URL structure.

## [1.1.1]

### Fixed
- Fixed `Event` model JSON key mappings (`pt`, `e`, `vt`, `d`) that were incorrectly mapped, causing all event fields to deserialize as `nil`
- Fixed `eventDetails` sub-keys for `requestFailed` events (`txt`, `c`, `err`, `t`, `u`) and `variantChanged` events (`br`, `h`, `w`, `cd`) not being expanded to meaningful names

### Improved
- `get_video_view_details` response now serializes with full, human-readable field names instead of abbreviated wire-format keys
- `events` array is now positioned at the end of the `data` object for better readability
- `success` field is now the first key in the response envelope
- All `null` fields are now included in the serialized output for completeness

## [1.1.0]

### Fixed
- Fixed missing parameters in multiple API methods.

### Improved
- Improved overall developer experience through more accurate typings.

## [1.0.0]

### Added
- Complete API coverage for Media, Live Streaming, Video Data, and Signing Keys
- Ruby 3.2+ support with comprehensive type checking via Sorbet
- Media upload, management, and processing capabilities
- Live streaming with simulcasting support
- Video analytics and performance tracking
- Cryptographic signing keys for secure authentication
- In-video AI processing features
- DRM configuration and management
- Playlist creation and management
- Comprehensive error handling with specific exception types
- Built-in retry mechanisms and timeout handling
- Comprehensive test suite with 80.7% test coverage
- Full API specification compliance

### Changed
- Reorganized package structure for better maintainability
- Updated dependencies to modern Ruby packages (Faraday, Sorbet, Minitest)
- Improved API design with better error handling
- Enhanced documentation and examples
- Updated SDK version to 1.0.0
- Updated minimum Ruby version requirement to 3.2+ for better compatibility and performance

### Fixed
- Direct upload metadata handling
- Response object access patterns
- Type mismatches in method parameters
- Error handling for validation responses
- Test data structure alignment with API expectations
- Improved error handling with specific exception types
- Fixed type annotation issues for better IDE support
- Ensured consistent API patterns across modules

---

## [0.0.1]

### Added
- Initial release of FastPix Ruby SDK
- Sync client support with Faraday HTTP client
- Media API integration with upload, management, and processing
- Playback ID management for media files
- Media operations (list, get, update, delete)
- Direct upload support for video files
- Live stream API integration
- Live stream management (create, update, delete)
- Playback ID management for live streams
- Simulcast configuration for live streams
- HTTP Basic authentication support
- Server URL override support
- Comprehensive error handling and custom error classes
- Example usage and quick start documentation
- CI workflow for RubyGems release
- Sorbet type checking integration
- Minitest test framework integration

--- 