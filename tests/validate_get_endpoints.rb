#!/usr/bin/env ruby
# frozen_string_literal: true

# GET endpoints validator for the FastPix Ruby SDK.
#
# This is the Ruby counterpart of the PHP `Tests/validate-get-endpoints.ts`
# harness. Per GET endpoint in the OpenAPI spec it:
#   - Calls the live API directly to get the raw JSON response
#   - Validates the raw response against the OpenAPI response schema
#     (uses the `json_schemer` gem when available; otherwise this step is
#     skipped gracefully and reported as such)
#   - Calls the Ruby SDK method for the same operationId, capturing either the
#     success object OR the raised error (normalized)
#   - Compares JSON paths between the raw API JSON and the SDK-parsed JSON,
#     applying the same normalization rules (snake_case -> camelCase, acronym
#     casing, empty-array == missing, null == missing, and the
#     get_video_view_details event-field remap)
#   - Persists per-endpoint artifacts to `tests/artifacts/`
#   - Generates two markdown reports in `tests/`:
#       - GET_ENDPOINTS_OPENAPI_RESPONSE_VALIDATION_REPORT.md
#       - GET_ENDPOINTS_OPENAPI_RESPONSE_FIX_SUGGESTIONS.md
#   - Updates `tests/README.md` between the markers:
#       <!-- BEGIN GET_ENDPOINTS_CONSOLIDATED --> / <!-- END ... -->
#
# Requirements:
#   - FASTPIX_USERNAME / FASTPIX_PASSWORD env vars (Basic Auth, real creds)
#   - tests/get-endpoints-fixtures.json for endpoints with required path params
#
# Usage:
#   FASTPIX_USERNAME=... FASTPIX_PASSWORD=... ruby tests/validate_get_endpoints.rb

require 'json'
require 'yaml'
require 'set'
require 'base64'
require 'fileutils'
require 'net/http'
require 'uri'
require 'time'

# Optional OpenAPI response schema validation via json_schemer (skipped when absent).
JSON_SCHEMER_AVAILABLE = Gem::Specification.find_all_by_name('json_schemer').any?
require 'json_schemer' if JSON_SCHEMER_AVAILABLE

# Make sure we can load the SDK from ../lib regardless of cwd.
TESTS_DIR = __dir__
ROOT_DIR = File.expand_path('..', TESTS_DIR)
$LOAD_PATH.unshift(File.join(ROOT_DIR, 'lib'))

require 'fastpixapi'

Models = ::FastpixClient::Models

ARTIFACTS_DIRNAME = 'artifacts'
MAX_PREVIEW_CHARS = 4000
PLACEHOLDER_UUID = '00000000-0000-0000-0000-000000000000'
REPORT_MD = 'GET_ENDPOINTS_OPENAPI_RESPONSE_VALIDATION_REPORT.md'
FIX_SUGGESTIONS_MD = 'GET_ENDPOINTS_OPENAPI_RESPONSE_FIX_SUGGESTIONS.md'
TIMESPAN_24_HOURS = '24:hours'
ONEOF_NO_MATCH_MSG = 'must match exactly one schema in oneOf'
NONE_BULLET = '- None'
TYPE_STRING_YAML = '  type: string'

# ---------------------------------------------------------------------------
# Spec + fixtures loading
# ---------------------------------------------------------------------------

# Raised when no OpenAPI spec file can be located.
class SpecNotFoundError < StandardError; end

def resolve_spec_path
  # Allow an explicit override via FASTPIX_SPEC; otherwise use the bundled spec.
  return ENV.fetch('FASTPIX_SPEC', nil) if ENV.fetch('FASTPIX_SPEC', nil) && File.exist?(ENV.fetch('FASTPIX_SPEC', nil))

  candidates = [
    File.join(ROOT_DIR, 'fastpixapi.yaml'),
    File.join(ROOT_DIR, 'fastpix.yaml'),
    File.join(ROOT_DIR, 'openapi.yaml')
  ]
  found = candidates.find { |p| File.exist?(p) }
  return found unless found.nil?

  raise SpecNotFoundError, "OpenAPI spec not found. Tried: #{candidates.map(&:inspect).join(", ")}"
end

def load_openapi_spec
  path = resolve_spec_path
  warn "Using OpenAPI spec: #{path}"
  # Permit YAML aliases; the spec is trusted local content.
  YAML.safe_load(File.read(path), permitted_classes: [Date, Time], aliases: true)
end

def read_fixtures
  p = File.join(TESTS_DIR, 'get-endpoints-fixtures.json')
  return nil unless File.exist?(p)

  JSON.parse(File.read(p))
end

def extract_get_endpoints(spec)
  out = []
  (spec['paths'] || {}).each do |path, methods|
    next unless methods.is_a?(Hash) && methods['get']

    get = methods['get']
    out << {
      'path' => path,
      'operationId' => get['operationId'],
      'responses' => get['responses'] || {},
      'parameters' => Array(get['parameters']) + Array(methods['parameters'])
    }
  end
  out
end

# ---------------------------------------------------------------------------
# Request building (defaults + fixtures) — mirrors the PHP harness
# ---------------------------------------------------------------------------

def default_sdk_request(operation_id)
  case operation_id
  when 'get-media', 'get-media-summary', 'retrieveMediaInputInfo',
       'list-playback-ids', 'get-media-clips'
    { 'mediaId' => PLACEHOLDER_UUID }
  when 'get-playback-id'
    { 'mediaId' => PLACEHOLDER_UUID, 'playbackId' => PLACEHOLDER_UUID }
  when 'list-live-clips'
    { 'livestreamId' => PLACEHOLDER_UUID }
  when 'get-playlist-by-id'
    { 'playlistId' => PLACEHOLDER_UUID }
  when 'getDrmConfigurationById'
    { 'drmConfigurationId' => PLACEHOLDER_UUID }
  when 'get-live-stream-by-id', 'get-live-stream-viewer-count-by-id'
    { 'streamId' => PLACEHOLDER_UUID }
  when 'get-live-stream-playback-id'
    { 'streamId' => PLACEHOLDER_UUID, 'playbackId' => PLACEHOLDER_UUID }
  when 'get-specific-simulcast-of-stream'
    { 'streamId' => PLACEHOLDER_UUID, 'simulcastId' => PLACEHOLDER_UUID }
  when 'get-signing_key_by_id'
    { 'signingKeyId' => PLACEHOLDER_UUID }
  when 'get_video_view_details'
    { 'viewId' => PLACEHOLDER_UUID }
  when 'list_filter_values_for_dimension'
    { 'dimensionsId' => 'browser_name' }
  when 'list_breakdown_values'
    { 'metricId' => 'quality_of_experience_score', 'timespan' => TIMESPAN_24_HOURS, 'groupBy' => 'browser_name' }
  when 'list_overall_values'
    { 'metricId' => 'quality_of_experience_score', 'timespan' => TIMESPAN_24_HOURS }
  when 'get_timeseries_data'
    { 'metricId' => 'quality_of_experience_score', 'timespan' => TIMESPAN_24_HOURS, 'groupBy' => 'hour' }
  when 'list_comparison_values'
    { 'timespan' => TIMESPAN_24_HOURS, 'dimension' => 'browser_name', 'value' => 'Chrome' }
  when 'list_errors'
    { 'timespan' => TIMESPAN_24_HOURS, 'limit' => 5 }
  when 'list_video_views'
    { 'timespan' => TIMESPAN_24_HOURS, 'limit' => 5, 'offset' => 1 }
  when 'list_by_top_content'
    { 'timespan' => TIMESPAN_24_HOURS, 'limit' => 5 }
  when 'list-media', 'list-uploads', 'get-all-streams'
    { 'limit' => 5, 'offset' => 1, 'orderBy' => 'desc' }
  when 'getDrmConfiguration'
    { 'limit' => 10, 'offset' => 1 }
  when 'get-all-playlists', 'list_signing_keys'
    { 'limit' => 5, 'offset' => 1 }
  else
    nil
  end
end

def fixture_request(endpoint, fixtures)
  op = fixtures&.dig('operations', endpoint['operationId'])
  return nil unless op

  (op['pathParams'] || {}).merge(op['query'] || {})
end

# Used for building the live API URL: merge defaults then fixture overrides
# (mirrors PHP buildUrl's `{ ...defaults, ...fromFixture }`).
def effective_request(endpoint, fixtures)
  (default_sdk_request(endpoint['operationId']) || {}).merge(fixture_request(endpoint, fixtures) || {})
end

# Used for invoking the SDK: fixture as-is if present, else operation defaults,
# else placeholder UUIDs for required path params (mirrors PHP buildSDKRequest).
def build_sdk_request(endpoint, fixtures)
  from_fixture = fixture_request(endpoint, fixtures)
  return from_fixture unless from_fixture.nil?

  default = default_sdk_request(endpoint['operationId'])
  return default unless default.nil?

  req = {}
  required_path_params(endpoint).each { |name| req[name] = PLACEHOLDER_UUID }
  req.empty? ? nil : req
end

def required_path_params(endpoint)
  endpoint['parameters']
    .select { |p| p && p['in'] == 'path' && p['required'] }
    .map { |p| p['name'] }
end

def build_url(base_url, endpoint, fixtures)
  path = endpoint['path'].dup
  req = effective_request(endpoint, fixtures)
  note = nil

  required_path_params(endpoint).each do |name|
    val = req[name]
    if val.nil?
      val = PLACEHOLDER_UUID
      msg = "Placeholder used for #{name}"
      note = note ? "#{note}; #{msg}" : msg
    end
    path = path.gsub("{#{name}}", URI.encode_www_form_component(val.to_s))
  end

  base = base_url.end_with?('/') ? base_url : "#{base_url}/"
  uri = URI.join(base, path.sub(%r{^/}, ''))

  query = []
  endpoint['parameters'].select { |p| p && p['in'] == 'query' }.each do |p|
    name = p['name']
    base_name = name.end_with?('[]') ? name[0..-3] : name
    val = req.key?(name) ? req[name] : req[base_name]
    next if val.nil?

    if val.is_a?(Array)
      val.each { |item| query << [name, item.to_s] }
    else
      query << [name, val.to_s]
    end
  end
  uri.query = URI.encode_www_form(query) unless query.empty?

  { url: uri.to_s, note: note }
end

# ---------------------------------------------------------------------------
# Live API call
# ---------------------------------------------------------------------------

def basic_auth_header(username, password)
  "Basic #{Base64.strict_encode64("#{username}:#{password}")}"
end

def call_api(url, username, password)
  uri = URI(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == 'https')
  http.open_timeout = 30
  http.read_timeout = 30

  req = Net::HTTP::Get.new(uri)
  req['Accept'] = 'application/json'
  req['Authorization'] = basic_auth_header(username, password)

  res = http.request(req)
  body =
    begin
      res.body && !res.body.empty? ? JSON.parse(res.body) : nil
    rescue JSON::ParserError
      res.body
    end
  { status: res.code.to_i, body: body, error: nil }
rescue StandardError => e
  { status: 0, body: nil, error: e.message }
end

# ---------------------------------------------------------------------------
# SDK invocation — the operationId dispatch table
# ---------------------------------------------------------------------------

def build_sdk(base_url, username, password)
  ::FastpixClient::Fastpixapi.new(
    security: Models::Components::Security.new(username: username, password: password),
    server_url: base_url
  )
end

# Deserialize a wire string into the given Sorbet T::Enum class.
def to_enum(klass, value)
  return nil if value.nil?

  klass.deserialize(value.to_s)
end

def sort_order(value)
  to_enum(Models::Components::SortOrder, value)
end

# Invoke the Ruby SDK for an operationId. Returns { ok: true, value: <obj> }
# or { ok: false, error: <normalized hash> }.
def invoke_sdk(operation_id, request, base_url, username, password)
  request ||= {}
  g = ->(k) { request[k] }
  s = build_sdk(base_url, username, password)

  res = invoke_sdk_media_ops(operation_id, g, s)
  res = invoke_sdk_analytics_ops(operation_id, g, s) if res == :unhandled
  if res == :unhandled
    return { ok: false, error: { 'name' => 'SDKMappingError', 'message' => "No Ruby SDK method mapping for operationId '#{operation_id}'" } }
  end

  { ok: true, value: extract_sdk_data(res) }
rescue StandardError => e
  { ok: false, error: normalize_error(e) }
end

# Media / playlist / playback / DRM / live-stream / simulcast / signing-key reads.
# Returns :unhandled when the operationId belongs to another group.
def invoke_sdk_media_ops(operation_id, g, s)
  case operation_id
  when 'list-media'
    s.manage_videos.list_media(limit: g['limit'], offset: g['offset'], order_by: sort_order(g['orderBy']))
  when 'get-media'
    s.manage_videos.get_media(media_id: g['mediaId'])
  when 'get-media-summary'
    s.manage_videos.get_media_summary(media_id: g['mediaId'])
  when 'retrieveMediaInputInfo'
    s.manage_videos.retrieve_media_input_info(media_id: g['mediaId'])
  when 'list-uploads'
    s.manage_videos.list_uploads(limit: g['limit'], offset: g['offset'], order_by: sort_order(g['orderBy']))
  when 'get-media-clips'
    s.manage_videos.get_media_clips(media_id: g['mediaId'], offset: g['offset'], limit: g['limit'], order_by: sort_order(g['orderBy']))
  when 'list-live-clips'
    s.manage_videos.list_live_clips(livestream_id: g['livestreamId'], limit: g['limit'], offset: g['offset'], order_by: sort_order(g['orderBy']))
  when 'get-all-playlists'
    s.playlist.get_all_playlists(limit: g['limit'], offset: g['offset'])
  when 'get-playlist-by-id'
    s.playlist.get_playlist_by_id(playlist_id: g['playlistId'])
  when 'list-playback-ids'
    s.playback.list_playback_ids(media_id: g['mediaId'])
  when 'get-playback-id'
    s.playback.get_playback_id(media_id: g['mediaId'], playback_id: g['playbackId'])
  when 'getDrmConfiguration'
    s.drm_configurations.get_drm_configuration(offset: g['offset'], limit: g['limit'])
  when 'getDrmConfigurationById'
    s.drm_configurations.get_drm_configuration_by_id(drm_configuration_id: g['drmConfigurationId'])
  when 'get-all-streams'
    s.manage_live_stream.get_all_streams(limit: g['limit'], offset: g['offset'], order_by: to_enum(Models::Operations::OrderBy, g['orderBy']))
  when 'get-live-stream-by-id'
    s.manage_live_stream.get_live_stream_by_id(stream_id: g['streamId'])
  when 'get-live-stream-viewer-count-by-id'
    s.manage_live_stream.get_live_stream_viewer_count_by_id(stream_id: g['streamId'])
  when 'get-live-stream-playback-id'
    s.live_playback.get_live_stream_playback_id(stream_id: g['streamId'], playback_id: g['playbackId'])
  when 'get-specific-simulcast-of-stream'
    s.simulcast_stream.get_specific_simulcast_of_stream(stream_id: g['streamId'], simulcast_id: g['simulcastId'])
  when 'list_signing_keys'
    s.signing_keys.list_signing_keys(limit: g['limit'], offset: g['offset'])
  when 'get-signing_key_by_id'
    s.signing_keys.get_signing_key_by_id(signing_key_id: g['signingKeyId'])
  else
    :unhandled
  end
end

# Views / dimensions / metrics / errors (analytics) reads.
# Returns :unhandled when the operationId belongs to another group.
def invoke_sdk_analytics_ops(operation_id, g, s)
  case operation_id
  when 'list_video_views'
    req = Models::Operations::ListVideoViewsRequest.new(
      timespan: to_enum(Models::Operations::ListVideoViewsTimespan, g['timespan']),
      limit: g['limit'],
      offset: g['offset']
    )
    s.views.list_video_views(request: req)
  when 'get_video_view_details'
    s.views.get_video_view_details(view_id: g['viewId'])
  when 'list_by_top_content'
    s.views.list_by_top_content(timespan: to_enum(Models::Operations::ListByTopContentTimespan, g['timespan']), limit: g['limit'])
  when 'list_dimensions'
    s.dimensions.list_dimensions
  when 'list_filter_values_for_dimension'
    s.dimensions.list_filter_values_for_dimension(
      dimensions_id: to_enum(Models::Operations::DimensionsId, g['dimensionsId']),
      timespan: to_enum(Models::Operations::ListFilterValuesForDimensionTimespan, g['timespan'])
    )
  when 'list_breakdown_values'
    req = Models::Operations::ListBreakdownValuesRequest.new(
      metric_id: to_enum(Models::Operations::ListBreakdownValuesMetricId, g['metricId']),
      timespan: to_enum(Models::Operations::ListBreakdownValuesTimespan, g['timespan']),
      group_by: g['groupBy']
    )
    s.metrics.list_breakdown_values(request: req)
  when 'list_overall_values'
    s.metrics.list_overall_values(
      metric_id: to_enum(Models::Operations::ListOverallValuesMetricId, g['metricId']),
      timespan: to_enum(Models::Operations::ListOverallValuesTimespan, g['timespan'])
    )
  when 'get_timeseries_data'
    req = Models::Operations::GetTimeseriesDataRequest.new(
      metric_id: to_enum(Models::Operations::GetTimeseriesDataMetricId, g['metricId']),
      timespan: to_enum(Models::Operations::GetTimeseriesDataTimespan, g['timespan']),
      group_by: to_enum(Models::Operations::GroupBy, g['groupBy'])
    )
    s.metrics.get_timeseries_data(request: req)
  when 'list_comparison_values'
    s.metrics.list_comparison_values(
      timespan: to_enum(Models::Operations::ListComparisonValuesTimespan, g['timespan']),
      dimension: to_enum(Models::Operations::Dimension, g['dimension']),
      value: g['value']
    )
  when 'list_errors'
    s.errors.list_errors(timespan: to_enum(Models::Operations::ListErrorsTimespan, g['timespan']), limit: g['limit'])
  else
    :unhandled
  end
end

# Pull the actual response payload out of the SDK response object, skipping
# transport metadata, then convert it to a plain wire-format hash.
def extract_sdk_data(res)
  metadata = %i[content_type status_code raw_response default_error error]
  data = nil

  if res.respond_to?(:object) && !res.object.nil?
    data = res.object
  elsif res.class.respond_to?(:fields)
    field = res.class.fields.find { |f| !metadata.include?(f.name) && !res.send(f.name).nil? }
    data = res.send(field.name) unless field.nil?
  end

  data = res if data.nil?
  to_jsonable(data)
end

# Convert SDK objects (Crystalline models, enums, DateTime) into JSON-native
# values, honoring each model's wire field names.
def to_jsonable(value)
  if value.respond_to?(:to_dict) && value.class.include?(Crystalline::MetadataFields)
    JSON.parse(JSON.generate(value.to_dict))
  elsif value.is_a?(Array)
    value.map { |v| to_jsonable(v) }
  elsif value.is_a?(Hash)
    value.transform_values { |v| to_jsonable(v) }
  elsif value.is_a?(T::Enum)
    value.serialize
  elsif value.is_a?(DateTime) || value.is_a?(Time)
    value.iso8601
  else
    value
  end
end

def normalize_error(err)
  out = { 'name' => err.class.name, 'message' => err.message, 'stack' => (err.backtrace || []).join("\n") }
  out['statusCode'] = err.status_code if err.respond_to?(:status_code) && err.status_code
  if err.respond_to?(:body) && err.body
    out['body'] = err.body
    if err.body.is_a?(String)
      begin
        out['bodyJson'] = JSON.parse(err.body)
      rescue JSON::ParserError
        # leave as raw string
      end
    end
  end
  out['cause'] = err.cause.message if err.cause
  out
end

# ---------------------------------------------------------------------------
# OpenAPI response validation (optional, via json_schemer)
# ---------------------------------------------------------------------------

# OpenAPI 3.0 uses `nullable: true`; JSON Schema expresses null via the type
# union. Rewrite the schema in place-ish (returns a new structure) so a
# standard validator accepts null where the spec allows it.
def openapi_to_json_schema(node)
  case node
  when Array
    node.map { |n| openapi_to_json_schema(n) }
  when Hash
    nullable = node['nullable'] == true
    out = {}
    node.each do |k, v|
      # `nullable` is handled below; discriminator/example(s) are not validation keywords.
      next if %w[nullable discriminator example examples].include?(k)

      out[k] = openapi_to_json_schema(v)
    end
    nullable ? apply_nullable_schema(out) : out
  else
    node
  end
end

# OpenAPI 3.0 `nullable: true` allows null. Express that in JSON Schema, covering
# plain types as well as oneOf/anyOf/$ref/enum shapes (mirrors how ajv /
# openapi-response-validator admits null in the PHP harness).
def apply_nullable_schema(out)
  if out.key?('type')
    t = out['type']
    out['type'] = t.is_a?(Array) ? (t + ['null']).uniq : [t, 'null']
    # an enum that doesn't list null would still reject null, so admit it.
    out['enum'] = (out['enum'] + [nil]).uniq if out['enum'].is_a?(Array) && !out['enum'].include?(nil)
    out
  elsif out.key?('oneOf')
    out['oneOf'] = out['oneOf'] + [{ 'type' => 'null' }]
    out
  elsif out.key?('anyOf')
    out['anyOf'] = out['anyOf'] + [{ 'type' => 'null' }]
    out
  else
    { 'anyOf' => [out, { 'type' => 'null' }] }
  end
end

# Build a validator callable for a given endpoint+spec, or nil.
def make_response_validator(spec, endpoint, status, raw_body)
  return [true, []] unless JSON_SCHEMER_AVAILABLE

  resp = endpoint['responses'][status.to_s] ||
         endpoint['responses'][status_class(status)] ||
         endpoint['responses']['default']
  schema = resp && resp.dig('content', 'application/json', 'schema')
  return [true, []] unless schema # nothing to validate against

  root = openapi_to_json_schema(schema)
  # Embed components so internal `#/components/schemas/...` $refs resolve.
  root = root.dup
  root['components'] = openapi_to_json_schema(spec['components'] || {})

  # `format: false` mirrors ajv / openapi-response-validator (PHP harness), which
  # treat `format` as an annotation, not an assertion. This avoids false failures
  # on fields like uuid-formatted IDs that carry non-uuid values.
  schemer = JSONSchemer.schema(root, format: false)
  errors = schemer.validate(raw_body).map do |e|
    { 'path' => e['data_pointer'], 'message' => ajv_style_message(e), 'errorCode' => e['type'] }
  end
  [errors.empty?, errors]
rescue StandardError => e
  [false, [{ 'message' => "Validator error: #{e.message}" }]]
end

def status_class(status)
  "#{status.to_i / 100}XX"
end

# Translate json_schemer error types into the ajv-style phrasing the PHP harness
# emitted, so the downstream fix-suggestion heuristics fire identically.
def ajv_style_message(error)
  type = error['type'].to_s
  case type
  when 'oneOf'
    ONEOF_NO_MATCH_MSG
  when 'anyOf'
    'must match a schema in anyOf'
  when 'enum'
    'must be equal to one of the allowed values'
  when 'const'
    'must be equal to constant'
  when 'required'
    missing = error.dig('details', 'missing_keys') || error['missing_keys']
    missing ? "must have required property '#{Array(missing).first}'" : 'must have required property'
  when 'string', 'integer', 'number', 'boolean', 'array', 'object', 'null'
    "must be #{type}"
  when 'minLength', 'maxLength', 'minimum', 'maximum', 'minItems', 'maxItems', 'pattern', 'format'
    "must satisfy #{type}"
  else
    expected = error.dig('schema', 'type')
    expected ? "must be #{Array(expected).join(' or ')}" : type
  end
end

# ---------------------------------------------------------------------------
# JSON path comparison + normalization
# ---------------------------------------------------------------------------

def canonicalize_key(key)
  camel = key.include?('_') ? key.downcase.gsub(/_([a-z0-9])/) { Regexp.last_match(1).upcase } : key
  camel.gsub('SDK', 'Sdk').gsub('API', 'Api')
end

def normalize_json(value)
  case value
  when Array
    value.map { |v| normalize_json(v) }
  when Hash
    value.each_with_object({}) { |(k, v), acc| acc[canonicalize_key(k)] = normalize_json(v) }
  else
    value
  end
end

# get_video_view_details returns abbreviated event keys that the SDK remaps to
# long names; mirror that remap on the raw API body so the comparison reflects
# the SDK contract rather than flagging the deliberate rename.
EVENT_OUTER_REMAP = {
  'pt' => 'player_playhead_time', 'e' => 'event_name', 'd' => 'event_details',
  'vt' => 'viewer_time', 'et' => 'event_time'
}.freeze
EVENT_INNER_REMAP = {
  'br' => 'bitrate', 'h' => 'height', 'w' => 'width', 'cd' => 'codec',
  'host' => 'hostName', 'txt' => 'text', 'c' => 'code', 'err' => 'error',
  't' => 'type', 'u' => 'url'
}.freeze

def remap_api_for_comparison(operation_id, body)
  return body unless operation_id == 'get_video_view_details'

  events = body.is_a?(Hash) ? body.dig('data', 'events') : nil
  return body unless events.is_a?(Array)

  rebuilt = events.map do |event|
    next event unless event.is_a?(Hash)

    event.each_with_object({}) do |(k, v), acc|
      nk = EVENT_OUTER_REMAP[k] || k
      if nk == 'event_details' && v.is_a?(Hash)
        acc[nk] = v.transform_keys { |ik| EVENT_INNER_REMAP[ik] || ik }
      else
        acc[nk] = v
      end
    end
  end

  body.merge('data' => body['data'].merge('events' => rebuilt))
end

def collect_json_paths(value, prefix = '', include_empty_arrays: true)
  out = Set.new
  return out if value.nil?

  unless value.is_a?(Array) || value.is_a?(Hash)
    out << prefix unless prefix.empty?
    return out
  end

  return collect_array_paths(value, prefix, include_empty_arrays, out) if value.is_a?(Array)

  value.each do |k, v|
    next if skip_empty_value?(v, include_empty_arrays)

    p = prefix.empty? ? k : "#{prefix}.#{k}"
    out << p
    collect_json_paths(v, p, include_empty_arrays: include_empty_arrays).each { |c| out << c }
  end
  out
end

# When empty arrays are excluded, skip empty arrays, nils, and empty hashes.
def skip_empty_value?(value, include_empty_arrays)
  return false if include_empty_arrays

  (value.is_a?(Array) && value.empty?) || value.nil? || (value.is_a?(Hash) && value.empty?)
end

# Collects paths for an Array node into `out` (returns `out`).
def collect_array_paths(value, prefix, include_empty_arrays, out)
  return out if !include_empty_arrays && value.empty?

  ap = prefix.empty? ? '[]' : "#{prefix}[]"
  out << ap
  value.each { |item| collect_json_paths(item, ap, include_empty_arrays: include_empty_arrays).each { |p| out << p } }
  out
end

def collect_empty_array_field_paths(value, prefix = '')
  out = Set.new
  return out unless value.is_a?(Array) || value.is_a?(Hash)

  if value.is_a?(Array)
    ap = prefix.empty? ? '[]' : "#{prefix}[]"
    value.each { |item| collect_empty_array_field_paths(item, ap).each { |p| out << p } }
    return out
  end

  value.each do |k, v|
    p = prefix.empty? ? k : "#{prefix}.#{k}"
    out << p if v.is_a?(Array) && v.empty?
    collect_empty_array_field_paths(v, p).each { |c| out << c }
  end
  out
end

def sort_unique(arr)
  arr.uniq.sort
end

# ---------------------------------------------------------------------------
# Artifacts
# ---------------------------------------------------------------------------

def safe_slug(input)
  input.gsub(/[^a-zA-Z0-9._-]+/, '_')
end

def preview(text)
  text.length <= MAX_PREVIEW_CHARS ? text : "#{text[0...MAX_PREVIEW_CHARS]}\n... (truncated)"
end

def write_artifacts(operation_id, raw_body, sdk_body)
  dir = File.join(TESTS_DIR, ARTIFACTS_DIRNAME)
  FileUtils.mkdir_p(dir)
  slug = safe_slug(operation_id)
  api_text = JSON.pretty_generate(raw_body)
  sdk_text = JSON.pretty_generate(sdk_body)
  File.write(File.join(dir, "#{slug}.api.json"), api_text)
  File.write(File.join(dir, "#{slug}.sdk.json"), sdk_text)
  {
    api_path: "tests/#{ARTIFACTS_DIRNAME}/#{slug}.api.json",
    sdk_path: "tests/#{ARTIFACTS_DIRNAME}/#{slug}.sdk.json",
    api_preview: preview(api_text),
    sdk_preview: preview(sdk_text)
  }
end

# ---------------------------------------------------------------------------
# Fix suggestions (heuristics) — ported from the PHP harness
# ---------------------------------------------------------------------------

def openapi_error_paths(r)
  (r[:openapi_errors] || []).map { |e| e['path'] }.compact.reject(&:empty?)
end

def has_openapi_error(r, includes)
  (r[:openapi_errors] || []).any? { |e| (e['message'] || '').include?(includes) }
end

def generate_fix_suggestions(r)
  paths = openapi_error_paths(r)
  schema_fix_suggestions(r, paths) + data_fix_suggestions(r)
end

# Suggestions derived from OpenAPI schema-validation errors (checks 1-5).
def schema_fix_suggestions(r, paths)
  out = []

  # 1) oneOf overlap on tracks
  if has_openapi_error(r, ONEOF_NO_MATCH_MSG) && paths.any? { |p| p.include?('tracks') }
    out << {
      title: 'Fix `tracks[].oneOf` overlap by constraining `type` per track schema',
      why: 'The current track schemas overlap (e.g. `type` is a free string and distinguishing fields are not required), so a single track object can match multiple branches. `oneOf` requires exactly one match.',
      where: 'In OpenAPI spec: `components/schemas/{VideoTrack,VideoTrackForGetAll,AudioTrack,SubtitleTrack}.properties.type`',
      paste_yaml: [
        '# Apply these changes inside each schema\'s `properties:` block:',
        '',
        '# VideoTrack (and VideoTrackForGetAll)',
        'type:',
        TYPE_STRING_YAML,
        '  enum: [video]',
        '  example: video',
        '',
        '# AudioTrack',
        'type:',
        TYPE_STRING_YAML,
        '  enum: [audio]',
        '  example: audio',
        '',
        '# SubtitleTrack',
        'type:',
        TYPE_STRING_YAML,
        '  enum: [subtitle]',
        '  example: subtitle'
      ].join("\n")
    }
  end

  # 2) Enum mismatch: sourceResolution
  if has_openapi_error(r, 'must be equal to one of the allowed values') && paths.any? { |p| p.include?('sourceResolution') }
    out << {
      title: 'Fix `sourceResolution` enum mismatch (API may return values without `p`)',
      why: 'The API can return values like `"1080"` but the spec constrains the enum to `"1080p"`-style values.',
      where: 'In OpenAPI spec: under the relevant media response schema(s) `sourceResolution:` field definition'
    }
  end

  # 3) Redundant oneOf for /data/dimensions
  if has_openapi_error(r, ONEOF_NO_MATCH_MSG) && (r[:endpoint] == '/data/dimensions' || paths.any? { |p| p.include?('dimensions') })
    out << {
      title: 'Remove redundant `oneOf` on `/data/dimensions` response schema',
      why: '`data` is defined as `oneOf: [array<string>, $ref: Dimensions]` and `Dimensions` itself is also `array<string>`, so valid responses can match multiple branches.',
      where: 'In OpenAPI spec: `paths./data/dimensions.get.responses.200.content.application/json.schema.properties.data.oneOf`'
    }
  end

  # 4) Overlapping numeric oneOf: integer vs number
  if has_openapi_error(r, ONEOF_NO_MATCH_MSG) && paths.any? { |p| p.include?('value') }
    out << {
      title: 'Avoid `oneOf: [integer, number]` overlaps (integers are also numbers)',
      why: 'In JSON Schema, `integer` is a subset of `number`. A value like `0` matches both, causing oneOf validation errors.',
      where: 'In OpenAPI spec: metrics schemas that use `oneOf: [integer, number]`'
    }
  end

  # 5) Nullable mismatch: fpApiVersion
  if has_openapi_error(r, 'must be string') && paths.any? { |p| p.include?('fpApiVersion') }
    out << {
      title: 'Make `fpApiVersion` nullable in the spec',
      why: 'The API can return `null` for fpApiVersion but the schema declares `string` only.',
      where: 'In OpenAPI spec: `components/schemas/Views.properties.fpApiVersion`'
    }
  end

  out
end

# Suggestions derived from request/response diff data (checks 6-8).
def data_fix_suggestions(r)
  out = []

  # 6) Placeholder fixture guidance (common 404)
  if (r[:note] || '').include?('Placeholder used') && r[:sdk_parse_ok] == false && (r[:sdk_parse_error] || '') =~ /404|not found/i
    out << {
      title: 'Provide real fixture IDs for this operationId',
      why: 'A placeholder UUID was used for required path params; the API likely returned 404 because the resource doesn\'t exist. Add a real ID under `tests/get-endpoints-fixtures.json` for this operationId.'
    }
  end

  # 7) Playlist playOrder default / missing
  if r[:missing_in_api].any? { |p| p.include?('playOrder') } || r[:missing_in_sdk].any? { |p| p.include?('playOrder') }
    out << {
      title: 'Ensure `playOrder` is correctly modeled for smart playlists only',
      why: 'If `playOrder` is present/required only for `type: smart`, the response schemas should reflect that (e.g. discriminator split).',
      where: 'In OpenAPI spec: playlist response schemas for create/update/get-by-id'
    }
  end

  # 8) simulcastResponses missing
  if r[:missing_in_sdk].any? { |p| p.include?('simulcastResponses') }
    out << {
      title: 'Add `simulcastResponses` to the live stream response schema',
      why: 'The API response includes simulcastResponses but the OpenAPI schema (and generated SDK inbound schema) does not, causing the SDK to drop the field.',
      where: 'In OpenAPI spec: live stream response schema(s) for get/list streams'
    }
  end

  out
end

# ---------------------------------------------------------------------------
# Reporting
# ---------------------------------------------------------------------------

def consolidated_table(results)
  lines = []
  lines << '| Endpoint | OperationId | OpenAPI valid | SDK parse | Missing in SDK (present in API) | Missing in API (present in SDK) | Empty arrays omitted by SDK | Status |'
  lines << '|---|---|---:|---:|---|---|---|---|'
  results.each do |r|
    miss_sdk = r[:missing_in_sdk].any? ? r[:missing_in_sdk].map { |p| "`#{p}`" }.join(', ') : 'None'
    miss_api = r[:missing_in_api].any? ? r[:missing_in_api].map { |p| "`#{p}`" }.join(', ') : 'None'
    empty_omit = r[:empty_arrays_omitted_in_sdk].any? ? r[:empty_arrays_omitted_in_sdk].map { |p| "`#{p}`" }.join(', ') : 'None'
    lines << "| `#{r[:endpoint]}` | `#{r[:operation_id]}` | #{r[:openapi_valid] ? '✅' : '❌'} | #{r[:sdk_parse_ok] ? '✅' : '❌'} | #{miss_sdk} | #{miss_api} | #{empty_omit} | #{r[:status] == 'PASS' ? '✅ PASS' : '❌ FAIL'} |"
  end
  lines
end

def write_report(results)
  total = results.size
  passed = results.count { |r| r[:status] == 'PASS' }
  failed = results.count { |r| r[:status] == 'FAIL' }
  generated_at = Time.now.utc.iso8601

  lines = []
  lines << '# GET Endpoints — OpenAPI Response Validation Report'
  lines << ''
  lines << "Generated: #{generated_at}"
  lines << ''
  lines << "OpenAPI schema validation: #{JSON_SCHEMER_AVAILABLE ? 'enabled (json_schemer)' : 'SKIPPED (install the `json_schemer` gem to enable)'}"
  lines << ''
  lines << '## Summary'
  lines << ''
  lines << "- **Total GET endpoints**: #{total}"
  lines << "- **PASS**: #{passed}"
  lines << "- **FAIL**: #{failed}"
  lines << '- **SKIP**: 0'
  lines << ''
  lines << '## Consolidated report'
  lines << ''
  lines.concat(consolidated_table(results))
  lines << ''
  lines << '## Per-endpoint details (full missing parameter lists)'
  lines << ''

  results.each { |r| append_endpoint_detail(lines, r) }

  File.write(File.join(TESTS_DIR, REPORT_MD), "#{lines.join("\n")}\n")
  write_fix_suggestions(results)
  update_readme(results, generated_at)

  warn "Report generated: #{File.join(TESTS_DIR, REPORT_MD)}"
  warn "Fix suggestions: #{File.join(TESTS_DIR, FIX_SUGGESTIONS_MD)}"
  warn "Summary: total=#{total} pass=#{passed} fail=#{failed}"
end

# Appends the full per-endpoint detail block for one result to `lines`.
def append_endpoint_detail(lines, r)
  lines << "### #{r[:operation_id]} (`#{r[:endpoint]}`)"
  lines << ''
  lines << "- **Status**: #{r[:status]}"
  lines << "- **Note**: #{r[:note]}" if r[:note]
  lines << "- **OpenAPI valid**: #{r[:openapi_valid] ? 'yes' : 'no'}"
  append_openapi_errors(lines, r)
  lines << "- **SDK parse**: #{r[:sdk_parse_ok] ? 'ok' : 'failed'}"
  lines << "- **SDK parse error**: #{r[:sdk_parse_error]}" if !r[:sdk_parse_ok] && r[:sdk_parse_error]
  lines << "- **API response file**: `#{r[:api_response_file]}`" if r[:api_response_file]
  lines << "- **SDK response file**: `#{r[:sdk_response_file]}`" if r[:sdk_response_file]
  lines << ''
  append_response_previews(lines, r)
  append_missing_sections(lines, r)
end

def append_openapi_errors(lines, r)
  return unless !r[:openapi_valid] && r[:openapi_errors].any?

  lines << '- **OpenAPI errors**:'
  r[:openapi_errors].each do |e|
    loc = e['path'] && !e['path'].empty? ? "`#{e['path']}`" : ''
    lines << "  - #{loc} #{e['message']}".strip
  end
end

def append_response_previews(lines, r)
  if r[:api_response_preview]
    lines << '**API response (preview)**'
    lines << ''
    lines << '```json'
    lines << r[:api_response_preview]
    lines << '```'
    lines << ''
  end

  return unless r[:sdk_response_preview]

  lines << '**SDK response (preview)**'
  lines << ''
  lines << '```json'
  lines << r[:sdk_response_preview]
  lines << '```'
  lines << ''
end

def append_missing_sections(lines, r)
  lines << "**Missing in SDK (present in API) — #{r[:missing_in_sdk].size}**"
  lines << ''
  lines << (r[:missing_in_sdk].empty? ? NONE_BULLET : r[:missing_in_sdk].map { |p| "- `#{p}`" }.join("\n"))
  lines << ''
  lines << "**Missing in API (present in SDK) — #{r[:missing_in_api].size}**"
  lines << ''
  lines << (r[:missing_in_api].empty? ? NONE_BULLET : r[:missing_in_api].map { |p| "- `#{p}`" }.join("\n"))
  lines << ''
  lines << "**Empty arrays omitted by SDK — #{r[:empty_arrays_omitted_in_sdk].size}**"
  lines << ''
  lines << (r[:empty_arrays_omitted_in_sdk].empty? ? NONE_BULLET : r[:empty_arrays_omitted_in_sdk].map { |p| "- `#{p}`" }.join("\n"))
  lines << ''
  lines << "**Empty arrays omitted by API — #{r[:empty_arrays_omitted_in_api].size}**"
  lines << ''
  lines << (r[:empty_arrays_omitted_in_api].empty? ? NONE_BULLET : r[:empty_arrays_omitted_in_api].map { |p| "- `#{p}`" }.join("\n"))
  lines << ''
end

def write_fix_suggestions(results)
  failing = results.select { |r| r[:status] == 'FAIL' }
  lines = []
  lines << '# GET Endpoints — OpenAPI Response Fix Suggestions'
  lines << ''
  lines << "Generated: #{Time.now.utc.iso8601}"
  lines << ''
  lines << "Total failing endpoints: #{failing.size}"
  lines << ''
  failing.each { |r| append_fix_suggestion_detail(lines, r) }
  File.write(File.join(TESTS_DIR, FIX_SUGGESTIONS_MD), "#{lines.join("\n")}\n")
end

# Appends one failing endpoint's fix-suggestion section to `lines`.
def append_fix_suggestion_detail(lines, r)
  lines << "## #{r[:operation_id]} (`#{r[:endpoint]}`)"
  lines << ''
  lines << "- **Status**: #{r[:status]}"
  lines << "- **OpenAPI valid**: #{r[:openapi_valid] ? 'yes' : 'no'}"
  lines << "- **SDK parse**: #{r[:sdk_parse_ok] ? 'ok' : 'failed'}"
  lines << "- **API artifact**: `#{r[:api_response_file]}`" if r[:api_response_file]
  lines << "- **SDK artifact**: `#{r[:sdk_response_file]}`" if r[:sdk_response_file]
  lines << ''
  append_observed_openapi_errors(lines, r)

  suggestions = r[:fix_suggestions] || []
  lines << '### Suggested fixes'
  lines << ''
  if suggestions.empty?
    lines << '- No heuristic suggestions available for this failure yet.'
    lines << ''
    return
  end
  suggestions.each { |sug| append_suggestion(lines, sug) }
end

def append_observed_openapi_errors(lines, r)
  return unless !r[:openapi_valid] && (r[:openapi_errors] || []).any?

  lines << '### Observed OpenAPI errors'
  lines << ''
  r[:openapi_errors].each do |e|
    loc = e['path'] && !e['path'].empty? ? "`#{e['path']}`" : ''
    lines << "- #{loc} #{e['message']}".strip
  end
  lines << ''
end

def append_suggestion(lines, sug)
  lines << "- **#{sug[:title]}**"
  lines << "  - **why**: #{sug[:why]}"
  lines << "  - **where**: #{sug[:where]}" if sug[:where]
  if sug[:paste_yaml]
    lines << '  - **paste**:'
    lines << ''
    lines << '```yaml'
    lines << sug[:paste_yaml]
    lines << '```'
  end
  lines << ''
end

def update_readme(results, generated_at)
  readme = File.join(TESTS_DIR, 'README.md')
  return unless File.exist?(readme)

  content = File.read(readme)
  begin_marker = '<!-- BEGIN GET_ENDPOINTS_CONSOLIDATED -->'
  end_marker = '<!-- END GET_ENDPOINTS_CONSOLIDATED -->'
  return unless content.include?(begin_marker) && content.include?(end_marker)

  total = results.size
  passed = results.count { |r| r[:status] == 'PASS' }
  failed = results.count { |r| r[:status] == 'FAIL' }

  block = []
  block << begin_marker
  block << "Last generated: #{generated_at}"
  block << ''
  block << "- **Total GET endpoints**: #{total}"
  block << "- **PASS**: #{passed}"
  block << "- **FAIL**: #{failed}"
  block << '- **SKIP**: 0'
  block << ''
  block.concat(consolidated_table(results))
  block << ''
  block << '#### Missing fields (full lists)'
  block << ''
  results.each do |r|
    block << "- **#{r[:operation_id]}** (`#{r[:endpoint]}`)"
    block << "  - **Missing in SDK (present in API)**: #{r[:missing_in_sdk].any? ? r[:missing_in_sdk].map { |p| "`#{p}`" }.join(', ') : 'None'}"
    block << "  - **Missing in API (present in SDK)**: #{r[:missing_in_api].any? ? r[:missing_in_api].map { |p| "`#{p}`" }.join(', ') : 'None'}"
    block << "  - **Empty arrays omitted by SDK**: #{r[:empty_arrays_omitted_in_sdk].any? ? r[:empty_arrays_omitted_in_sdk].map { |p| "`#{p}`" }.join(', ') : 'None'}"
    block << "  - **Empty arrays omitted by API**: #{r[:empty_arrays_omitted_in_api].any? ? r[:empty_arrays_omitted_in_api].map { |p| "`#{p}`" }.join(', ') : 'None'}"
  end
  block << ''
  block << "Full details: `tests/#{REPORT_MD}`"
  block << end_marker

  updated = content.gsub(/#{Regexp.escape(begin_marker)}.*?#{Regexp.escape(end_marker)}/m, block.join("\n"))
  File.write(readme, updated)
end

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main
  spec = load_openapi_spec
  endpoints = extract_get_endpoints(spec)
  fixtures = read_fixtures

  base_url = ENV.fetch('FASTPIX_BASE_URL', nil) || spec.dig('servers', 0, 'url') || 'https://api.fastpix.com/v1/'
  username = ENV.fetch('FASTPIX_USERNAME', nil)
  password = ENV.fetch('FASTPIX_PASSWORD', nil)

  if username.to_s.empty? || password.to_s.empty? || username == 'your-access-token' || password == 'your-secret-key'
    abort 'Set FASTPIX_USERNAME and FASTPIX_PASSWORD env vars (real credentials) for live API validation.'
  end

  conn = { base_url: base_url, username: username, password: password }
  results = endpoints.each_with_index.map do |ep, i|
    process_endpoint(spec, ep, i, endpoints.size, conn, fixtures)
  end

  results.each { |r| r[:fix_suggestions] = generate_fix_suggestions(r) if r[:status] == 'FAIL' }
  write_report(results)
end

# Invokes the SDK for an endpoint; returns [parse_ok, parse_error, value, printed].
def run_sdk_call(ep, base_url, username, password, fixtures)
  sdk = invoke_sdk(ep['operationId'], build_sdk_request(ep, fixtures), base_url, username, password)
  return [true, nil, sdk[:value], sdk[:value]] if sdk[:ok]

  warn "  ⚠️  SDK call failed: #{sdk[:error]['message']}"
  [false, sdk[:error]['message'], nil, sdk[:error]]
end

# Computes [missing_in_sdk, missing_in_api, empty_omitted_sdk, empty_omitted_api].
def compute_path_diffs(api_norm, sdk_norm)
  api_paths = collect_json_paths(api_norm, '', include_empty_arrays: false)
  sdk_paths = sdk_norm ? collect_json_paths(sdk_norm, '', include_empty_arrays: false) : Set.new

  missing_in_sdk = sdk_paths.empty? ? [] : sort_unique(api_paths.reject { |p| sdk_paths.include?(p) }.to_a)
  missing_in_api = sdk_paths.empty? ? [] : sort_unique(sdk_paths.reject { |p| api_paths.include?(p) }.to_a)

  api_strict = collect_json_paths(api_norm, '', include_empty_arrays: true)
  sdk_strict = sdk_norm ? collect_json_paths(sdk_norm, '', include_empty_arrays: true) : Set.new
  api_empty = collect_empty_array_field_paths(api_norm)
  sdk_empty = sdk_norm ? collect_empty_array_field_paths(sdk_norm) : Set.new
  empty_omitted_sdk = sort_unique(api_empty.reject { |p| sdk_strict.include?(p) }.to_a)
  empty_omitted_api = sort_unique(sdk_empty.reject { |p| api_strict.include?(p) }.to_a)

  [missing_in_sdk, missing_in_api, empty_omitted_sdk, empty_omitted_api]
end

# Runs one endpoint through API + SDK validation and returns its result hash.
def process_endpoint(spec, ep, i, total, conn, fixtures)
  warn "[#{i + 1}/#{total}] #{ep['operationId']} (#{ep['path']})"

  base_url = conn[:base_url]
  username = conn[:username]
  password = conn[:password]

  built = build_url(base_url, ep, fixtures)
  api = call_api(built[:url], username, password)

  if api[:error]
    openapi_valid = false
    openapi_errors = [{ 'message' => "Request failed: #{api[:error]}" }]
  else
    openapi_valid, openapi_errors = make_response_validator(spec, ep, api[:status], api[:body])
  end

  sdk_parse_ok, sdk_parse_error, sdk_value, sdk_printed = run_sdk_call(ep, base_url, username, password, fixtures)

  api_norm = normalize_json(remap_api_for_comparison(ep['operationId'], api[:body]))
  sdk_norm = sdk_value.is_a?(Hash) || sdk_value.is_a?(Array) ? normalize_json(sdk_value) : nil
  missing_in_sdk, missing_in_api, empty_omitted_sdk, empty_omitted_api = compute_path_diffs(api_norm, sdk_norm)

  pass = openapi_valid && sdk_parse_ok && missing_in_sdk.empty? && missing_in_api.empty?
  artifacts = write_artifacts(ep['operationId'], api[:body], sdk_printed)

  {
    endpoint: ep['path'],
    operation_id: ep['operationId'],
    openapi_valid: openapi_valid,
    openapi_errors: openapi_errors,
    sdk_parse_ok: sdk_parse_ok,
    sdk_parse_error: sdk_parse_error,
    missing_in_sdk: missing_in_sdk,
    missing_in_api: missing_in_api,
    empty_arrays_omitted_in_sdk: empty_omitted_sdk,
    empty_arrays_omitted_in_api: empty_omitted_api,
    api_response_file: artifacts[:api_path],
    sdk_response_file: artifacts[:sdk_path],
    api_response_preview: artifacts[:api_preview],
    sdk_response_preview: artifacts[:sdk_preview],
    status: pass ? 'PASS' : 'FAIL',
    note: built[:note]
  }
rescue StandardError => e
  warn "  ✗ Unexpected error: #{e.message}"
  {
    endpoint: ep['path'], operation_id: ep['operationId'],
    openapi_valid: false, openapi_errors: [{ 'message' => "Unexpected error: #{e.message}" }],
    sdk_parse_ok: false, sdk_parse_error: e.message,
    missing_in_sdk: [], missing_in_api: [],
    empty_arrays_omitted_in_sdk: [], empty_arrays_omitted_in_api: [],
    status: 'FAIL', note: 'Unexpected error during processing'
  }
end

main if $PROGRAM_NAME == __FILE__
