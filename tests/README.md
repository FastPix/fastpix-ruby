# FastPix Ruby SDK Tests

Two kinds of checks live in this repository:

| Check | Command | Needs credentials |
|---|---|---|
| Offline RSpec suite (`spec/`) | `bundle exec rake test` | No |
| Live GET validator | `bundle exec ruby tests/validate_get_endpoints.rb` | Yes |
| Live non-GET validator | `bundle exec ruby tests/validate_non_get_endpoints.rb` | Yes |

## Offline suite (`rake test`)

`bundle exec rake test` (also the default `rake` task) runs every RSpec example
under `spec/` with WebMock, so nothing reaches the network. It exits non-zero on
any failing example and when zero examples are found. `bundle exec rubocop` is
the matching lint step; both run in the internal pipeline before SonarCloud.

- `spec/models_spec.rb` — wire contracts of request and response models.
- `spec/live_playback_spec.rb` — stubbed live playback restriction endpoints.
- `spec/return_types_spec.rb` — every resource method's declared return type
  matches the envelope it constructs and the class it unmarshals.

## Live validators

The two validators below exercise the real API with credentials from the
untracked `tests/.env` (copy `tests/.env.example`). They replace the former
Minitest live suite; each endpoint's coverage is in the consolidated tables
they refresh in this file.

### Prerequisites
1. **Ruby 3.2+** (as required by the SDK; `.ruby-version` pins it)
2. `bundle install`
3. `set -a; source tests/.env; set +a`

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
_Populated by a validator run; not committed._
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
