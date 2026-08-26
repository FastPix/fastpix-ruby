# FastPix + Rails example

A minimal Rails app with two endpoints:

- `POST /uploads` — mints a signed direct-upload URL via the SDK and returns
  `{ uploadId, url }`. Your client PUTs the file straight to that URL, so the
  video never passes through this server.
- `POST /webhooks` — verifies the `FastPix-Signature` on the raw request body,
  then handles the event and acks with `200` quickly.

It's a single file (`app.rb`) to keep the moving parts visible.

## Run it

Rails 8 needs Ruby 3.2+. The commands use `ruby -S bundle` so bundler always
runs under your current `ruby` — handy on machines (like macOS) where a stray
`bundle` points at an older system Ruby. If your `bundle` already matches your
`ruby`, plain `bundle ...` works just as well.

```bash
cd examples/rails-example
ruby -S bundle install
cp .env.example .env   # fill in your credentials
export $(grep -v '^#' .env | xargs)
ruby -S bundle exec rackup -p 9292
```

While developing against this repo (before the gem is published), point Ruby at
the local SDK: `RUBYLIB=../../lib ruby -S bundle exec rackup -p 9292`.

If `bundle install` hits a permission error writing to the gem directory,
install the gems into the project instead: `ruby -S bundle config set --local
path vendor/bundle`, then `ruby -S bundle install`.

## Try it

```bash
# 1. Get a signed upload URL
UPLOAD_URL=$(curl -s -X POST localhost:9292/uploads | ruby -rjson -e 'puts JSON.parse(STDIN.read)["url"]')

# 2. Upload a file straight to it
curl -X PUT --upload-file video.mp4 -H "Content-Type: video/mp4" "$UPLOAD_URL"
```

FastPix will POST a `video.media.ready` webhook to `/webhooks` once processing
finishes. To test webhook verification locally, sign a payload with your
`FASTPIX_WEBHOOK_SECRET` and send it with a `FastPix-Signature` header — a valid
signature returns `200`, a bad one returns `401`.

## Before you ship

- `/uploads` mints upload URLs with no auth here — add your own before exposing it.
- Uploads are created with `cors_origin: "*"` so any browser can PUT; scope it
  to your own origin in production.
- `config.hosts` is cleared for the demo; set your allowed hosts.
