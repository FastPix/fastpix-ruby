# Changelog

All notable changes to this project will be documented in this file.

## [1.1.3]

A maintenance release focused on internal code quality (SonarCloud), security
hardening, and CI. It is an internal refactor with **no intended changes to the
public API, method signatures, request/response models, or wire behavior** and
is backward compatible with `1.1.2`.

### Changed

- **SDK version bump: `1.1.2` → `1.1.3`.** Updated internal identifiers:
  - `@sdk_version` constant — now reports `1.1.3`.
  - `User-Agent` header — outbound requests now identify as
    `fastpixapi-ruby 1.1.3`.

- **Code-quality refactor across the SDK (SonarCloud), behavior-preserving.**
  Spanning ~40 files in `lib/fastpix_client/*` (resource clients such as
  `views`, `playback`, `playlist`, `signing_keys`, `simulcast_stream`, and the
  `utils/*` helpers `url`, `forms`, `query_params`, `security`, `headers`):
  - Reduced method cognitive complexity by extracting private helper methods
    (e.g. response/hook handling), with no change to control flow or outputs.
  - Replaced duplicated inline string literals with named constants
    (e.g. `CONTENT_TYPE_JSON`, `API_ERROR_OCCURRED`).
  - Made raised exceptions specific instead of generic `StandardError`:
    argument/validation guards now raise `ArgumentError`, and the empty-response
    guard raises a new `FastpixClient::Models::Errors::EmptyResponseError`. Both
    are `StandardError` subclasses, so existing `rescue`/`rescue StandardError`
    handling is unaffected.
  - Standardized `require` ordering and removed redundant exception-class
    arguments.

### Security

- Hardened the GitHub Actions release workflow (`.github/workflows/releases.yml`):
  pinned `actions/checkout` and `ruby/setup-ruby` to full commit SHAs instead of
  mutable version tags, preventing supply-chain tampering during gem publication.
- Added SonarCloud static analysis to CI via Azure Pipelines
  (`azure-pipeline-files.yml`).

### Fixed

- `lib/openssl_patch.rb`: made the optional OpenSSL/cert patch idempotent and
  compatible with newer Ruby — it no longer raises `FrozenError` when
  `OpenSSL::X509::DEFAULT_CERT_FILE` is frozen, and no longer warns on repeat
  loads. (This file is a development helper and is not loaded by the gem at
  runtime.)

### Internal

- Development-only test harness (not shipped in the gem): standardized `require`
  ordering, introduced a dedicated `SpecNotFoundError` exception in place of
  raising string/generic errors, and reduced method parameter counts in
  `tests/validate_get_endpoints.rb` and `tests/validate_non_get_endpoints.rb`.

### Compatibility

- No changes to public types, method signatures, request/response models,
  default server URLs, security/auth, hooks, or retry logic.
- No action required for existing integrations — update the dependency
  (`bundle update fastpixapi` or `gem update fastpixapi`) and continue.

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