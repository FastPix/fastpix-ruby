# FastPix Ruby SDK examples

Small, runnable scripts that show how to use the SDK against the FastPix API,
plus a minimal Rails app that wires uploads and webhooks into HTTP endpoints.

## Setup

You'll need Ruby 3.2+ and a FastPix account.

1. Install the SDK (from RubyGems, or point Bundler at this repo while developing):

   ```bash
   gem install fastpixapi
   ```

2. Set your credentials. Copy `.env.example` to `.env`, fill it in, and load it:

   ```bash
   cp .env.example .env
   # edit .env, then:
   export $(grep -v '^#' .env | xargs)
   ```

   `FASTPIX_USERNAME` is your Access Token and `FASTPIX_PASSWORD` is your Secret
   Key, both from the [Dashboard](https://dashboard.fastpix.com). The examples
   read them from the environment — nothing is hardcoded.

3. Run any example:

   ```bash
   ruby examples/basic_usage.rb
   ```

## The examples

| File | What it does |
| --- | --- |
| `basic_usage.rb` | Initialise the SDK and read from a few endpoints. |
| `create_upload.rb` | Mint a signed direct-upload URL for a device upload. |
| `verify_webhook.rb` | Verify a webhook signature. Runs offline, no credentials. |
| `media_upload.rb` | Create a media from a URL, read it, delete it. |
| `live_streaming.rb` | Create a live stream, toggle it, delete it. |
| `playlist_management.rb` | Create a playlist, add a media, delete it. |
| `signing_keys.rb` | Create, read and delete a signing key. |
| `analytics.rb` | Read views, dimensions, metrics and errors. |
| `drm_configuration.rb` | List DRM configurations. |
| `ai_features.rb` | Enable summary, chapters and named entities on a media. |
| `configuration.rb` | SDK options: timeout, retries, custom server URL. |
| `rails-example/` | A Rails app exposing `/uploads` and `/webhooks`. |

A few examples need account features to be enabled (live streaming, DRM,
admin-level signing keys) or an existing ready media (`ai_features.rb`, via
`FASTPIX_MEDIA_ID`). When something isn't available they print why and exit
cleanly rather than failing hard.

## Uploading a file after you have a signed URL

`create_upload.rb` (and the Rails `/uploads` endpoint) hand you a signed URL.
The client uploads the file straight to that URL, so the bytes never touch your
server. Once it finishes, FastPix processes the video and sends the
`video.media.ready` webhook.

We keep this simple and PUT the whole file in one request — good enough for
small files. For larger ones you'll usually want a resumable upload (chunked,
with retries and progress); the same signed URL supports that too.

```bash
# Upload the file straight to the signed URL from create_upload.rb
curl -X PUT --upload-file video.mp4 \
  -H "Content-Type: video/mp4" \
  "$UPLOAD_URL"
```

Or from the browser, straight off a file input:

```js
const { url } = await (await fetch("/uploads", { method: "POST" })).json();
await fetch(url, {
  method: "PUT",
  headers: { "Content-Type": file.type || "application/octet-stream" },
  body: file,
});
```

The examples mint uploads with `cors_origin: "*"` so the browser can PUT from
anywhere — lock that down before you ship. The docs go deeper, resumable
included: https://fastpix.com/docs/upload-videos/upload-videos-from-device
