#!/usr/bin/env ruby
# frozen_string_literal: true

# Non-GET endpoints validator (POST / PUT / PATCH / DELETE).
#
# Ruby counterpart of the PHP `Tests/validate-non-get-endpoints.ts`, following
# the same structure. Unlike the GET validator, these operations MUTATE live
# data, so we cannot hit the raw API and the SDK separately (that would
# create/delete twice). Instead this driver invokes the Ruby SDK once per
# operation and:
#   - captures the SDK's deserialized return value (for the diff + artifact)
#   - captures the raw HTTP status + raw JSON body from the SDK's underlying
#     response (for OpenAPI response-schema validation)
#
# No fixtures are required. The driver runs a create -> use -> delete lifecycle:
#   1. CREATE phase  (POST)       - creates real resources, captures their IDs
#   2. UPDATE phase  (PUT/PATCH)  - exercises updates against the created IDs
#   3. DELETE phase  (DELETE)     - tears the resources down LAST
#
# A step whose required IDs were never captured (because an upstream create
# failed) is reported as SKIP rather than called with nils.
#
# Output:
#   - per-operation artifacts in `tests/artifacts-non-get/`
#   - `tests/NON_GET_ENDPOINTS_VALIDATION_REPORT.md`
#
# Requirements:
#   - FASTPIX_USERNAME / FASTPIX_PASSWORD env vars (Basic Auth)
#   - optional FASTPIX_BASE_URL / FASTPIX_SERVER_URL (defaults to spec server)
#   - optional FASTPIX_SPEC to point at a specific OpenAPI yaml
#
# Usage:
#   FASTPIX_USERNAME=... FASTPIX_PASSWORD=... ruby tests/validate_non_get_endpoints.rb

require 'json'
require 'yaml'
require 'set'
require 'base64'
require 'fileutils'
require 'net/http'
require 'uri'
require 'time'

TESTS_DIR = __dir__
ROOT_DIR = File.expand_path('..', TESTS_DIR)
$LOAD_PATH.unshift(File.join(ROOT_DIR, 'lib'))

require 'fastpixapi'

Models = ::FastpixClient::Models

JSON_SCHEMER_AVAILABLE =
  begin
    require 'json_schemer'
    true
  rescue LoadError
    false
  end

ARTIFACTS_DIRNAME = 'artifacts-non-get'
REPORT_MD = 'NON_GET_ENDPOINTS_VALIDATION_REPORT.md'
MAX_PREVIEW_CHARS = 4000
PHASE_ORDER = %w[CREATE UPDATE DELETE].freeze
OP_CREATE_MEDIA = 'create-media'
OP_CREATE_MEDIA_PLAYBACK_ID = 'create-media-playback-id'
OP_CREATE_PLAYLIST = 'create-a-playlist'
OP_CREATE_STREAM = 'create-new-stream'
OP_ADD_MEDIA_TRACK = 'Add-media-track'
OP_GENERATE_SUBTITLE = 'Generate-subtitle-track'
OP_CREATE_STREAM_PLAYBACK = 'create-playbackId-of-stream'
OP_CREATE_SIMULCAST = 'create-simulcast-of-stream'
OP_DIRECT_UPLOAD = 'direct-upload-video-media'
SDK_VALIDATE_TAG = 'sdk-validate'

# ---------------------------------------------------------------------------
# Spec loading + endpoint extraction
# ---------------------------------------------------------------------------

def resolve_spec_path
  return ENV.fetch('FASTPIX_SPEC', nil) if ENV.fetch('FASTPIX_SPEC', nil) && File.exist?(ENV.fetch('FASTPIX_SPEC', nil))

  candidates = [
    File.join(ROOT_DIR, 'fastpixapi.yaml'),
    File.join(ROOT_DIR, 'fastpix.yaml'),
    File.join(ROOT_DIR, 'openapi.yaml')
  ]
  found = candidates.find { |p| File.exist?(p) }
  return found unless found.nil?

  raise StandardError, "OpenAPI spec not found. Tried: #{candidates.map(&:inspect).join(", ")}"
end

def load_openapi_spec
  path = resolve_spec_path
  warn "Using OpenAPI spec: #{path}"
  YAML.safe_load(File.read(path), permitted_classes: [Date, Time], aliases: true)
end

# operationId -> { path, method, responses }
def extract_non_get_endpoints(spec)
  out = {}
  (spec['paths'] || {}).each do |path, methods|
    next unless methods.is_a?(Hash)

    %w[post put patch delete].each do |method|
      op = methods[method]
      next unless op

      out[op['operationId']] = { 'path' => path, 'method' => method.upcase, 'responses' => op['responses'] || {} }
    end
  end
  out
end

# ---------------------------------------------------------------------------
# OpenAPI response validation (optional, via json_schemer) — same as GET driver
# ---------------------------------------------------------------------------

def openapi_to_json_schema(node)
  case node
  when Array
    node.map { |n| openapi_to_json_schema(n) }
  when Hash
    out = {}
    nullable = node['nullable'] == true
    node.each do |k, v|
      next if %w[nullable discriminator example examples].include?(k)

      out[k] = openapi_to_json_schema(v)
    end
    if nullable
      if out.key?('type')
        t = out['type']
        out['type'] = t.is_a?(Array) ? (t + ['null']).uniq : [t, 'null']
        # an enum that doesn't list null would still reject null, so admit it.
        out['enum'] = (out['enum'] + [nil]).uniq if out['enum'].is_a?(Array) && !out['enum'].include?(nil)
      elsif out.key?('oneOf')
        out['oneOf'] += [{ 'type' => 'null' }]
      elsif out.key?('anyOf')
        out['anyOf'] += [{ 'type' => 'null' }]
      else
        out = { 'anyOf' => [out, { 'type' => 'null' }] }
      end
    end
    out
  else
    node
  end
end

def ajv_style_message(error)
  type = error['type'].to_s
  case type
  when 'oneOf' then 'must match exactly one schema in oneOf'
  when 'anyOf' then 'must match a schema in anyOf'
  when 'enum' then 'must be equal to one of the allowed values'
  when 'const' then 'must be equal to constant'
  when 'required'
    missing = error.dig('details', 'missing_keys') || error['missing_keys']
    missing ? "must have required property '#{Array(missing).first}'" : 'must have required property'
  when 'string', 'integer', 'number', 'boolean', 'array', 'object', 'null'
    "must be #{type}"
  else
    expected = error.dig('schema', 'type')
    expected ? "must be #{Array(expected).join(' or ')}" : type
  end
end

def status_class(status)
  "#{status.to_i / 100}XX"
end

# Returns [valid (true/false/nil), errors]; nil = no schema to validate against.
def validate_openapi_response(spec, endpoint, status, raw_body)
  return [nil, []] unless JSON_SCHEMER_AVAILABLE && status

  resp = endpoint['responses'][status.to_s] ||
         endpoint['responses'][status_class(status)] ||
         endpoint['responses']['default']
  schema = resp && resp.dig('content', 'application/json', 'schema')
  return [nil, []] unless schema

  root = openapi_to_json_schema(schema).dup
  root['components'] = openapi_to_json_schema(spec['components'] || {})
  schemer = JSONSchemer.schema(root, format: false)
  errors = schemer.validate(raw_body).map do |e|
    { 'path' => e['data_pointer'], 'message' => ajv_style_message(e), 'errorCode' => e['type'] }
  end
  [errors.empty?, errors]
rescue StandardError => e
  [false, [{ 'message' => "Validator error: #{e.message}" }]]
end

# ---------------------------------------------------------------------------
# JSON diff helpers — same rules as the GET driver
# ---------------------------------------------------------------------------

def canonicalize_key(key)
  camel = key.include?('_') ? key.downcase.gsub(/_([a-z0-9])/) { Regexp.last_match(1).upcase } : key
  camel.gsub('SDK', 'Sdk').gsub('API', 'Api')
end

def normalize_json(value)
  case value
  when Array then value.map { |v| normalize_json(v) }
  when Hash then value.each_with_object({}) { |(k, v), acc| acc[canonicalize_key(k)] = normalize_json(v) }
  else value
  end
end

def collect_json_paths(value, prefix = '', include_empty_arrays: true)
  out = Set.new
  return out if value.nil?

  unless value.is_a?(Array) || value.is_a?(Hash)
    out << prefix unless prefix.empty?
    return out
  end

  if value.is_a?(Array)
    return out if !include_empty_arrays && value.empty?

    ap = prefix.empty? ? '[]' : "#{prefix}[]"
    out << ap
    value.each { |item| collect_json_paths(item, ap, include_empty_arrays: include_empty_arrays).each { |p| out << p } }
    return out
  end

  value.each do |k, v|
    next if !include_empty_arrays && v.is_a?(Array) && v.empty?
    next if !include_empty_arrays && v.nil?
    next if !include_empty_arrays && v.is_a?(Hash) && v.empty?

    p = prefix.empty? ? k : "#{prefix}.#{k}"
    out << p
    collect_json_paths(v, p, include_empty_arrays: include_empty_arrays).each { |c| out << c }
  end
  out
end

def sort_unique(arr)
  arr.uniq.sort
end

# ---------------------------------------------------------------------------
# SDK value serialization + error normalization
# ---------------------------------------------------------------------------

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

def extract_sdk_data(res)
  metadata = %i[content_type status_code raw_response default_error error]
  data = nil
  if res.respond_to?(:object) && !res.object.nil?
    data = res.object
  elsif res.class.respond_to?(:fields)
    field = res.class.fields.find { |f| !metadata.include?(f.name) && !res.send(f.name).nil? }
    data = res.send(field.name) unless field.nil?
  end
  return nil if data.nil?

  to_jsonable(data)
end

def raw_body_from(res)
  return nil unless res.respond_to?(:raw_response) && res.raw_response

  body =
    begin
      res.raw_response.env.response_body
    rescue StandardError
      res.raw_response.body
    end
  return nil if body.nil? || (body.respond_to?(:empty?) && body.empty?)

  begin
    JSON.parse(body)
  rescue JSON::ParserError
    body
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
        # raw string
      end
    end
  end
  out['cause'] = err.cause.message if err.cause
  out
end

# ---------------------------------------------------------------------------
# SDK invocation dispatch (mirrors the PHP switch)
# ---------------------------------------------------------------------------

def build_sdk(base_url, username, password)
  ::FastpixClient::Fastpixapi.new(
    security: Models::Components::Security.new(username: username, password: password),
    server_url: base_url
  )
end

C = Models::Components
O = Models::Operations

# Returns { ok: true, value:, status_code:, raw_body: } or { ok: false, error: }
def invoke_sdk(operation_id, request, base_url, username, password)
  request ||= {}
  g = ->(k) { request[k] }
  s = build_sdk(base_url, username, password)

  res =
    case operation_id
    # ---------------- POST (create) ----------------
    when OP_CREATE_MEDIA
      s.input_video.create_media(request: C::CreateMediaRequest.new(inputs: [C::PullVideoInput.new], metadata: { 'source' => SDK_VALIDATE_TAG }))
    when 'create_signing_key'
      s.signing_keys.create_signing_key
    when OP_CREATE_PLAYLIST
      s.playlist.create_a_playlist(request: C::CreatePlaylistRequestManual.new(
        name: 'sdk-validate-playlist',
        reference_id: "sdkvalidate#{Time.now.to_i}",
        type: C::CreatePlaylistRequestManualType::MANUAL
      ))
    when OP_CREATE_STREAM
      s.start_live_stream.create_new_stream(request: C::CreateLiveStreamRequest.new(
        playback_settings: C::PlaybackSettings.new,
        input_media_settings: C::InputMediaSettings.new(metadata: { 'name' => SDK_VALIDATE_TAG })
      ))
    when OP_CREATE_MEDIA_PLAYBACK_ID
      s.playback.create_media_playback_id(body: O::CreateMediaPlaybackIdRequestBody.new(access_policy: C::AccessPolicy::PUBLIC), media_id: g['mediaId'])
    when OP_ADD_MEDIA_TRACK
      s.manage_videos.add_media_track(body: O::AddMediaTrackRequestBody.new(tracks: C::AddTrackRequest.new), media_id: g['mediaId'])
    when OP_GENERATE_SUBTITLE
      s.manage_videos.generate_subtitle_track(body: C::TrackSubtitlesGenerateRequest.new, media_id: g['mediaId'], track_id: g['trackId'])
    when OP_CREATE_STREAM_PLAYBACK
      s.live_playback.create_playback_id_of_stream(body: C::PlaybackIdRequest.new, stream_id: g['streamId'])
    when OP_CREATE_SIMULCAST
      s.simulcast_stream.create_simulcast_of_stream(body: C::SimulcastRequest.new(url: 'rtmp://example.com/live', stream_key: "sk-#{Time.now.to_i}"), stream_id: g['streamId'])
    when OP_DIRECT_UPLOAD
      s.input_video.direct_upload_video_media(request: O::DirectUploadVideoMediaRequest.new(push_media_settings: O::PushMediaSettings.new(metadata: { 'source' => SDK_VALIDATE_TAG })))

    # ---------------- PUT / PATCH (update) ----------------
    when 'updated-media'
      s.manage_videos.updated_media(body: O::UpdatedMediaRequestBody.new(metadata: { 'updated' => 'true' }, title: 'SDK Validate Title'), media_id: g['mediaId'])
    when 'updated-source-access'
      s.manage_videos.updated_source_access(body: O::UpdatedSourceAccessRequestBody.new(source_access: true), media_id: g['mediaId'])
    when 'updated-mp4Support'
      s.manage_videos.updated_mp4_support(body: O::UpdatedMp4SupportRequestBody.new, media_id: g['mediaId'])
    when 'update-media-summary'
      s.in_video_ai_features.update_media_summary(body: O::UpdateMediaSummaryRequestBody.new(generate: true), media_id: g['mediaId'])
    when 'update-media-chapters'
      s.in_video_ai_features.update_media_chapters(body: O::UpdateMediaChaptersRequestBody.new(chapters: true), media_id: g['mediaId'])
    when 'update-media-named-entities'
      s.in_video_ai_features.update_media_named_entities(body: O::UpdateMediaNamedEntitiesRequestBody.new(named_entities: true), media_id: g['mediaId'])
    when 'update-media-moderation'
      s.in_video_ai_features.update_media_moderation(body: O::UpdateMediaModerationRequestBody.new(moderation: O::UpdateMediaModerationModeration.new), media_id: g['mediaId'])
    when 'update-media-track'
      s.manage_videos.update_media_track(body: C::UpdateTrackRequest.new, track_id: g['trackId'], media_id: g['mediaId'])
    when 'update-domain-restrictions'
      s.playback.update_domain_restrictions(body: O::UpdateDomainRestrictionsRequestBody.new(allow: ['example.com']), media_id: g['mediaId'], playback_id: g['playbackId'])
    when 'update-user-agent-restrictions'
      s.playback.update_user_agent_restrictions(body: O::UpdateUserAgentRestrictionsRequestBody.new(allow: ['Mozilla']), media_id: g['mediaId'], playback_id: g['playbackId'])
    when 'update-a-playlist'
      s.playlist.update_a_playlist(body: C::UpdatePlaylistRequest.new(name: 'SDK Validate Updated', description: 'updated by validator'), playlist_id: g['playlistId'])
    when 'add-media-to-playlist'
      s.playlist.add_media_to_playlist(body: C::MediaIdsRequest.new(media_ids: [g['mediaId']]), playlist_id: g['playlistId'])
    when 'change-media-order-in-playlist'
      s.playlist.change_media_order_in_playlist(body: C::MediaIdsRequest.new(media_ids: [g['mediaId']]), playlist_id: g['playlistId'])
    when 'update-live-stream'
      s.manage_live_stream.update_live_stream(body: C::PatchLiveStreamRequest.new(metadata: { 'updated' => 'true' }, reconnect_window: 120), stream_id: g['streamId'])
    when 'update-specific-simulcast-of-stream'
      s.simulcast_stream.update_specific_simulcast_of_stream(body: C::SimulcastUpdateRequest.new(is_enabled: false), stream_id: g['streamId'], simulcast_id: g['simulcastId'])
    when 'enable-live-stream'
      s.manage_live_stream.enable_live_stream(stream_id: g['streamId'])
    when 'disable-live-stream'
      s.manage_live_stream.disable_live_stream(stream_id: g['streamId'])
    when 'complete-live-stream'
      s.manage_live_stream.complete_live_stream(stream_id: g['streamId'])
    when 'cancel-upload'
      s.manage_videos.cancel_upload(upload_id: g['uploadId'])

    # ---------------- DELETE ----------------
    when 'delete-media-from-playlist'
      s.playlist.delete_media_from_playlist(body: C::MediaIdsRequest.new(media_ids: [g['mediaId']]), playlist_id: g['playlistId'])
    when 'delete-a-playlist'
      s.playlist.delete_a_playlist(playlist_id: g['playlistId'])
    when 'delete-media-track'
      s.manage_videos.delete_media_track(media_id: g['mediaId'], track_id: g['trackId'])
    when 'delete-media-playback-id'
      s.playback.delete_media_playback_id(media_id: g['mediaId'], playback_id: g['playbackId'])
    when 'delete-simulcast-of-stream'
      s.simulcast_stream.delete_simulcast_of_stream(stream_id: g['streamId'], simulcast_id: g['simulcastId'])
    when 'delete-playbackId-of-stream'
      s.live_playback.delete_playback_id_of_stream(stream_id: g['streamId'], playback_id: g['playbackId'])
    when 'delete-live-stream'
      s.manage_live_stream.delete_live_stream(stream_id: g['streamId'])
    when 'delete-media'
      s.manage_videos.delete_media(media_id: g['mediaId'])
    when 'delete_signing_key'
      s.signing_keys.delete_signing_key(signing_key_id: g['signingKeyId'])
    else
      return { ok: false, error: { 'name' => 'SDKMappingError', 'message' => "No Ruby SDK mapping for #{operation_id}" } }
    end

  {
    ok: true,
    value: extract_sdk_data(res),
    status_code: (res.respond_to?(:status_code) ? res.status_code : nil),
    raw_body: raw_body_from(res)
  }
rescue StandardError => e
  { ok: false, error: normalize_error(e) }
end

# ---------------------------------------------------------------------------
# Polling helpers (a freshly-created resource provisions asynchronously)
# ---------------------------------------------------------------------------

def basic_auth_header(username, password)
  "Basic #{Base64.strict_encode64("#{username}:#{password}")}"
end

def http_get_json(url, username, password)
  uri = URI(url)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = (uri.scheme == 'https')
  http.open_timeout = 20
  http.read_timeout = 20
  req = Net::HTTP::Get.new(uri)
  req['Accept'] = 'application/json'
  req['Authorization'] = basic_auth_header(username, password)
  res = http.request(req)
  JSON.parse(res.body)
rescue StandardError
  nil
end

# A freshly-created media is "Preparing"; adding playback-ids / tracks returns
# 400 until it reaches "Ready". Poll GET media so dependent steps have a usable
# resource.
def wait_for_media_ready(base_url, username, password, media_id, timeout_ms: 180_000, interval_ms: 5_000)
  url = "#{base_url.sub(%r{/$}, '')}/on-demand/#{media_id}"
  deadline = Time.now + (timeout_ms / 1000.0)
  last = 'unknown'
  while Time.now < deadline
    body = http_get_json(url, username, password)
    last = body&.dig('data', 'status') || last
    return 'Ready' if last == 'Ready'
    return last if %w[Errored Failed].include?(last)

    sleep(interval_ms / 1000.0)
  end
  last
end

# A freshly-added track is processed asynchronously; generating subtitles before
# it exists returns 404. Poll the media's track list until the track is present.
def wait_for_track_ready(base_url, username, password, media_id, track_id, timeout_ms: 180_000, interval_ms: 5_000)
  url = "#{base_url.sub(%r{/$}, '')}/on-demand/#{media_id}"
  deadline = Time.now + (timeout_ms / 1000.0)
  last = 'absent'
  while Time.now < deadline
    body = http_get_json(url, username, password)
    track = Array(body&.dig('data', 'tracks')).find { |t| t.is_a?(Hash) && t['id'] == track_id }
    if track
      last = track['status'] || 'present'
      return last if %w[Ready present].include?(last)
    end
    sleep(interval_ms / 1000.0)
  end
  last
end

# ---------------------------------------------------------------------------
# Lifecycle definition (ordered so all DELETEs run after every POST/PUT/PATCH)
# ---------------------------------------------------------------------------

STEPS = [
  # ---- CREATE ----
  { op: 'create_signing_key', phase: 'CREATE', request: ->(_c) { {} }, capture: ->(v, c) { c[:signingKeyId] = v&.dig('data', 'id') } },
  { op: OP_CREATE_PLAYLIST, phase: 'CREATE', request: ->(_c) { {} }, capture: ->(v, c) { c[:playlistId] = v&.dig('data', 'id') } },
  { op: OP_CREATE_STREAM, phase: 'CREATE', request: ->(_c) { {} }, capture: ->(v, c) { c[:streamId] = v&.dig('data', 'streamId') || v&.dig('data', 'id') } },
  { op: OP_CREATE_MEDIA, phase: 'CREATE', request: ->(_c) { {} }, capture: ->(v, c) { c[:mediaId] = v&.dig('data', 'id'); c[:mediaPlaybackId] = v&.dig('data', 'playbackIds', 0, 'id') } },
  { op: OP_CREATE_MEDIA_PLAYBACK_ID, phase: 'CREATE', needs: %i[mediaId], request: ->(c) { { 'mediaId' => c[:mediaId] } }, capture: ->(v, c) { c[:createdPlaybackId] = v&.dig('data', 'playbackIds', 0, 'id') || v&.dig('data', 'id') } },
  { op: OP_ADD_MEDIA_TRACK, phase: 'CREATE', needs: %i[mediaId], request: ->(c) { { 'mediaId' => c[:mediaId] } }, capture: ->(v, c) { c[:trackId] = v&.dig('data', 'id') } },
  { op: OP_CREATE_STREAM_PLAYBACK, phase: 'CREATE', needs: %i[streamId], request: ->(c) { { 'streamId' => c[:streamId] } }, capture: ->(v, c) { c[:streamPlaybackId] = v&.dig('data', 'playbackIds', 0, 'id') || v&.dig('data', 'id') } },
  { op: OP_CREATE_SIMULCAST, phase: 'CREATE', needs: %i[streamId], request: ->(c) { { 'streamId' => c[:streamId] } }, capture: ->(v, c) { c[:simulcastId] = v&.dig('data', 'simulcastId') || v&.dig('data', 'id') } },
  { op: OP_DIRECT_UPLOAD, phase: 'CREATE', request: ->(_c) { {} }, capture: ->(v, c) { c[:uploadId] = v&.dig('data', 'uploadId') || v&.dig('data', 'id') } },
  { op: OP_GENERATE_SUBTITLE, phase: 'CREATE', needs: %i[mediaId trackId], request: ->(c) { { 'mediaId' => c[:mediaId], 'trackId' => c[:trackId] } } },

  # ---- UPDATE (PUT/PATCH) ----
  { op: 'updated-media', phase: 'UPDATE', needs: %i[mediaId], request: ->(c) { { 'mediaId' => c[:mediaId] } } },
  { op: 'updated-source-access', phase: 'UPDATE', needs: %i[mediaId], request: ->(c) { { 'mediaId' => c[:mediaId] } } },
  { op: 'updated-mp4Support', phase: 'UPDATE', needs: %i[mediaId], request: ->(c) { { 'mediaId' => c[:mediaId] } } },
  { op: 'update-media-summary', phase: 'UPDATE', needs: %i[mediaId], request: ->(c) { { 'mediaId' => c[:mediaId] } } },
  { op: 'update-media-chapters', phase: 'UPDATE', needs: %i[mediaId], request: ->(c) { { 'mediaId' => c[:mediaId] } } },
  { op: 'update-media-named-entities', phase: 'UPDATE', needs: %i[mediaId], request: ->(c) { { 'mediaId' => c[:mediaId] } } },
  { op: 'update-media-moderation', phase: 'UPDATE', needs: %i[mediaId], request: ->(c) { { 'mediaId' => c[:mediaId] } } },
  { op: 'update-media-track', phase: 'UPDATE', needs: %i[mediaId trackId], request: ->(c) { { 'mediaId' => c[:mediaId], 'trackId' => c[:trackId] } } },
  { op: 'update-domain-restrictions', phase: 'UPDATE', needs: %i[mediaId mediaPlaybackId], retry_on: 'not ready for updates', request: ->(c) { { 'mediaId' => c[:mediaId], 'playbackId' => c[:mediaPlaybackId] } } },
  { op: 'update-user-agent-restrictions', phase: 'UPDATE', needs: %i[mediaId mediaPlaybackId], retry_on: 'not ready for updates', request: ->(c) { { 'mediaId' => c[:mediaId], 'playbackId' => c[:mediaPlaybackId] } } },
  { op: 'update-a-playlist', phase: 'UPDATE', needs: %i[playlistId], request: ->(c) { { 'playlistId' => c[:playlistId] } } },
  { op: 'add-media-to-playlist', phase: 'UPDATE', needs: %i[playlistId mediaId], request: ->(c) { { 'playlistId' => c[:playlistId], 'mediaId' => c[:mediaId] } } },
  { op: 'change-media-order-in-playlist', phase: 'UPDATE', needs: %i[playlistId mediaId], request: ->(c) { { 'playlistId' => c[:playlistId], 'mediaId' => c[:mediaId] } } },
  { op: 'update-live-stream', phase: 'UPDATE', needs: %i[streamId], request: ->(c) { { 'streamId' => c[:streamId] } } },
  { op: 'update-specific-simulcast-of-stream', phase: 'UPDATE', needs: %i[streamId simulcastId], request: ->(c) { { 'streamId' => c[:streamId], 'simulcastId' => c[:simulcastId] } } },
  # a freshly-created stream is already enabled, so disable first, then enable.
  { op: 'disable-live-stream', phase: 'UPDATE', needs: %i[streamId], request: ->(c) { { 'streamId' => c[:streamId] } } },
  { op: 'enable-live-stream', phase: 'UPDATE', needs: %i[streamId], request: ->(c) { { 'streamId' => c[:streamId] } } },
  # complete requires an actively-streaming encoder; with no ingest it is
  # expected to fail. `expect_fail` reports it as XFAIL (not counted as a failure).
  { op: 'complete-live-stream', phase: 'UPDATE', needs: %i[streamId], expect_fail: true, request: ->(c) { { 'streamId' => c[:streamId] } } },
  { op: 'cancel-upload', phase: 'UPDATE', needs: %i[uploadId], request: ->(c) { { 'uploadId' => c[:uploadId] } } },

  # ---- DELETE (last) ----
  { op: 'delete-media-from-playlist', phase: 'DELETE', needs: %i[playlistId mediaId], request: ->(c) { { 'playlistId' => c[:playlistId], 'mediaId' => c[:mediaId] } } },
  { op: 'delete-a-playlist', phase: 'DELETE', needs: %i[playlistId], request: ->(c) { { 'playlistId' => c[:playlistId] } } },
  { op: 'delete-media-track', phase: 'DELETE', needs: %i[mediaId trackId], request: ->(c) { { 'mediaId' => c[:mediaId], 'trackId' => c[:trackId] } } },
  { op: 'delete-media-playback-id', phase: 'DELETE', needs: %i[mediaId createdPlaybackId], request: ->(c) { { 'mediaId' => c[:mediaId], 'playbackId' => c[:createdPlaybackId] } } },
  { op: 'delete-simulcast-of-stream', phase: 'DELETE', needs: %i[streamId simulcastId], request: ->(c) { { 'streamId' => c[:streamId], 'simulcastId' => c[:simulcastId] } } },
  { op: 'delete-playbackId-of-stream', phase: 'DELETE', needs: %i[streamId streamPlaybackId], request: ->(c) { { 'streamId' => c[:streamId], 'playbackId' => c[:streamPlaybackId] } } },
  { op: 'delete-live-stream', phase: 'DELETE', needs: %i[streamId], request: ->(c) { { 'streamId' => c[:streamId] } } },
  { op: 'delete-media', phase: 'DELETE', needs: %i[mediaId], request: ->(c) { { 'mediaId' => c[:mediaId] } } },
  { op: 'delete_signing_key', phase: 'DELETE', needs: %i[signingKeyId], request: ->(c) { { 'signingKeyId' => c[:signingKeyId] } } }
].freeze

# Maps a capture key to the operationId that produces it, for the report.
CAPTURE_SOURCE = {
  signingKeyId: 'create_signing_key', playlistId: OP_CREATE_PLAYLIST, streamId: OP_CREATE_STREAM,
  mediaId: OP_CREATE_MEDIA, createdPlaybackId: OP_CREATE_MEDIA_PLAYBACK_ID, trackId: OP_ADD_MEDIA_TRACK,
  streamPlaybackId: OP_CREATE_STREAM_PLAYBACK, simulcastId: OP_CREATE_SIMULCAST, uploadId: OP_DIRECT_UPLOAD
}.freeze

# ---------------------------------------------------------------------------
# Artifacts + report
# ---------------------------------------------------------------------------

def safe_slug(input)
  input.gsub(/[^a-zA-Z0-9._-]+/, '_')
end

def preview(text)
  text.length > MAX_PREVIEW_CHARS ? "#{text[0...MAX_PREVIEW_CHARS]}\n... [truncated]" : text
end

def write_artifacts(operation_id, raw_body, sdk_value)
  dir = File.join(TESTS_DIR, ARTIFACTS_DIRNAME)
  FileUtils.mkdir_p(dir)
  slug = safe_slug(operation_id)
  File.write(File.join(dir, "#{slug}.raw.json"), JSON.pretty_generate(raw_body))
  File.write(File.join(dir, "#{slug}.sdk.json"), JSON.pretty_generate(sdk_value))
end

def write_report(results, ctx)
  total = results.size
  pass = results.count { |r| r[:status] == 'PASS' }
  fail = results.count { |r| r[:status] == 'FAIL' }
  skip = results.count { |r| r[:status] == 'SKIP' }
  xfail = results.count { |r| r[:status] == 'XFAIL' }

  lines = []
  lines << '# Non-GET endpoints validation report'
  lines << ''
  lines << "Generated: #{Time.now.utc.iso8601}"
  lines << ''
  lines << "OpenAPI schema validation: #{JSON_SCHEMER_AVAILABLE ? 'enabled (json_schemer)' : 'SKIPPED (install the `json_schemer` gem to enable)'}"
  lines << ''
  lines << '## Summary'
  lines << ''
  lines << "- **Total**: #{total}"
  lines << "- **PASS**: #{pass}"
  lines << "- **FAIL**: #{fail}"
  lines << "- **SKIP**: #{skip}"
  lines << "- **XFAIL (expected)**: #{xfail}"
  lines << ''
  lines << '## Captured resources'
  lines << ''
  ctx.each { |k, v| lines << "- `#{k}`: #{v || '(not created)'}" }
  lines << ''
  lines << '## Consolidated report'
  lines << ''
  lines << '| Phase | Method | OperationId | HTTP | OpenAPI valid | SDK | Missing in SDK | Missing in API | Status |'
  lines << '|---|---|---|---:|:--:|:--:|---|---|:--:|'
  PHASE_ORDER.each do |phase|
    results.select { |r| r[:phase] == phase }.each do |r|
      ov = r[:openapi_valid].nil? ? '—' : (r[:openapi_valid] ? '✅' : '❌')
      sdk = r[:status] == 'SKIP' ? '—' : (r[:sdk_ok] ? '✅' : '❌')
      mis = ->(a) { a.any? ? a.join(', ') : 'None' }
      st = case r[:status]
           when 'PASS' then '✅ PASS'
           when 'SKIP' then '⤳ SKIP'
           when 'XFAIL' then '⚠️ XFAIL'
           else '❌ FAIL'
           end
      lines << "| #{r[:phase]} | #{r[:method]} | `#{r[:operation_id]}` | #{r[:http_status] || '—'} | #{ov} | #{sdk} | #{mis.call(r[:missing_in_sdk])} | #{mis.call(r[:missing_in_api])} | #{st} |"
    end
  end
  lines << ''
  lines << '## Per-operation details'
  lines << ''
  results.each do |r|
    lines << "### #{r[:operation_id]} (`#{r[:method]} #{r[:path]}`)"
    lines << "- **Phase**: #{r[:phase]}"
    lines << "- **Status**: #{r[:status]}"
    lines << "- **HTTP status**: #{r[:http_status]}" unless r[:http_status].nil?
    lines << "- **Captured id**: `#{r[:captured_id]}`" if r[:captured_id]
    lines << "- **Note**: #{r[:note]}" if r[:note]
    lines << "- **SDK error**: #{preview(r[:sdk_error])}" if r[:sdk_error]
    if r[:openapi_errors].any?
      lines << '- **OpenAPI errors**:'
      r[:openapi_errors].first(20).each { |e| lines << "  - `#{e['path']}` #{e['message']}" }
    end
    if r[:missing_in_sdk].any?
      lines << '- **Missing in SDK (present in API)**:'
      r[:missing_in_sdk].each { |p| lines << "  - `#{p}`" }
    end
    if r[:missing_in_api].any?
      lines << '- **Missing in API (present in SDK)**:'
      r[:missing_in_api].each { |p| lines << "  - `#{p}`" }
    end
    lines << ''
  end

  File.write(File.join(TESTS_DIR, REPORT_MD), "#{lines.join("\n")}\n")
  warn "Report generated: #{File.join(TESTS_DIR, REPORT_MD)}"
end

# ---------------------------------------------------------------------------
# Main
# ---------------------------------------------------------------------------

def main
  spec = load_openapi_spec
  endpoints = extract_non_get_endpoints(spec)

  base_url = ENV.fetch('FASTPIX_BASE_URL', nil) || ENV.fetch('FASTPIX_SERVER_URL', nil) || spec.dig('servers', 0, 'url') || 'https://api.fastpix.com/v1/'
  username = ENV.fetch('FASTPIX_USERNAME', nil)
  password = ENV.fetch('FASTPIX_PASSWORD', nil)
  if username.to_s.empty? || password.to_s.empty?
    abort 'Set FASTPIX_USERNAME and FASTPIX_PASSWORD env vars (real credentials) for live API validation.'
  end

  ctx = {}
  results = []

  STEPS.each_with_index do |step, i|
    ep = endpoints[step[:op]]
    base = { operation_id: step[:op], method: ep&.fetch('method', '?'), path: ep&.fetch('path', '?'),
             phase: step[:phase], openapi_errors: [], missing_in_sdk: [], missing_in_api: [] }
    warn "[#{i + 1}/#{STEPS.size}] (#{step[:phase]}) #{step[:op]}"

    unless ep
      results << base.merge(status: 'SKIP', http_status: nil, openapi_valid: nil, sdk_ok: false, note: 'operationId not found in spec')
      next
    end

    missing = (step[:needs] || []).reject { |k| ctx[k] }
    if missing.any?
      warn "  ⤳ SKIP (missing: #{missing.join(', ')})"
      results << base.merge(status: 'SKIP', http_status: nil, openapi_valid: nil, sdk_ok: false, note: "missing dependency: #{missing.join(', ')}")
      next
    end

    # generating subtitles needs the just-added track to be fetched/ready first
    if step[:op] == OP_GENERATE_SUBTITLE && ctx[:mediaId] && ctx[:trackId]
      warn "  ⏳ waiting for track #{ctx[:trackId]} to be ready..."
      warn "  track status: #{wait_for_track_ready(base_url, username, password, ctx[:mediaId], ctx[:trackId])}"
    end

    request = step[:request].call(ctx)
    php = invoke_sdk(step[:op], request, base_url, username, password)

    # wait for an async-provisioning resource by retrying while the error matches.
    if step[:retry_on]
      attempt = 0
      max_attempts = 24 # ~2 min at 5s
      while !php[:ok] && attempt < max_attempts && JSON.generate(php[:error] || {}).include?(step[:retry_on])
        attempt += 1
        warn '  ⏳ resource not ready, retrying...' if attempt == 1
        sleep(5)
        php = invoke_sdk(step[:op], request, base_url, username, password)
      end
    end

    unless php[:ok]
      msg = "#{php[:error]['name'] || 'Error'}: #{php[:error]['message'] || 'SDK call failed'}"
      xfail = step[:expect_fail]
      warn "  #{xfail ? '⚠️  XFAIL (expected)' : '❌ FAIL'} — #{msg.lines.first.to_s.strip[0, 120]}"
      write_artifacts(step[:op], php[:error]['bodyJson'], php[:error])
      results << base.merge(
        status: xfail ? 'XFAIL' : 'FAIL',
        http_status: php[:error]['statusCode'],
        openapi_valid: nil,
        sdk_ok: false,
        sdk_error: msg,
        note: xfail ? 'expected failure: requires an actively-streaming encoder ingest' : nil
      )
      next
    end

    step[:capture]&.call(php[:value], ctx)

    # a just-created media must reach "Ready" before playback-ids / tracks can
    # be added, otherwise those create steps 400 and cascade into SKIPs.
    if step[:op] == OP_CREATE_MEDIA && ctx[:mediaId]
      warn "  ⏳ waiting for media #{ctx[:mediaId]} to be Ready..."
      warn "  media status: #{wait_for_media_ready(base_url, username, password, ctx[:mediaId])}"
    end

    captured_id = CAPTURE_SOURCE.find { |key, op| op == step[:op] && ctx[key] }&.then { |key, _| ctx[key] }

    openapi_valid, openapi_errors = validate_openapi_response(spec, ep, php[:status_code], php[:raw_body])

    api_norm = normalize_json(php[:raw_body])
    sdk_norm = php[:value].is_a?(Hash) || php[:value].is_a?(Array) ? normalize_json(php[:value]) : nil
    api_paths = collect_json_paths(api_norm, '', include_empty_arrays: false)
    sdk_paths = sdk_norm ? collect_json_paths(sdk_norm, '', include_empty_arrays: false) : Set.new
    missing_in_sdk = sdk_paths.empty? ? [] : sort_unique(api_paths.reject { |p| sdk_paths.include?(p) }.to_a)
    missing_in_api = sdk_paths.empty? ? [] : sort_unique(sdk_paths.reject { |p| api_paths.include?(p) }.to_a)

    write_artifacts(step[:op], php[:raw_body], php[:value])

    status = (openapi_valid.nil? || openapi_valid) && missing_in_sdk.empty? && missing_in_api.empty? ? 'PASS' : 'FAIL'
    warn "  #{status == 'PASS' ? '✅ PASS' : '❌ FAIL'} (HTTP #{php[:status_code] || '?'})#{captured_id ? " id=#{captured_id}" : ''}"

    results << base.merge(
      status: status, http_status: php[:status_code], openapi_valid: openapi_valid, openapi_errors: openapi_errors,
      sdk_ok: true, missing_in_sdk: missing_in_sdk, missing_in_api: missing_in_api, captured_id: captured_id
    )
  end

  write_report(results, ctx)
  pass = results.count { |r| r[:status] == 'PASS' }
  fail = results.count { |r| r[:status] == 'FAIL' }
  skip = results.count { |r| r[:status] == 'SKIP' }
  xfail = results.count { |r| r[:status] == 'XFAIL' }
  warn "Summary: total=#{results.size} pass=#{pass} fail=#{fail} skip=#{skip} xfail=#{xfail}"
end

main if $PROGRAM_NAME == __FILE__
