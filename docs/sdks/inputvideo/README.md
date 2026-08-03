# InputVideo

## Overview

Operations for inputting and creating video media

### Available Operations

* [create_media](#create_media) - Create media from URL
* [direct_upload_video_media](#direct_upload_video_media) - Upload media from device

## create_media

This endpoint allows developers or users to create a new video or audio media in FastPix using a publicly accessible URL. FastPix fetches the media from the provided URL, processes it, and stores it on the platform for use.



#### Public URL requirement:


  The provided URL must be publicly accessible and must point to a video stored in one of the following supported formats: .m4v, .ogv, .mpeg, .mov, .3gp, .f4v, .rm, .ts, .wtv, .avi, .mp4, .wmv, .webm, .mts, .vob, .mxf, asf, m2ts 



#### Supported storage types:

The URL can originate from various cloud storage services or content delivery networks (CDNs) such as: 


* **Amazon S3:** URLs from Amazon's Simple Storage Service. 

* **Google Cloud Storage:** URLs from Google Cloud's storage solution. 

* **Azure Blob Storage:** URLs from Microsoft's Azure storage. 

* **Public CDNs:** URLs from public content delivery networks that host video files. 

Upon successful creation, the API returns an `id` that must be retained for future operations related to this media. 

#### How it works


1. Send a POST request to this endpoint with the media URL (typically a video or audio file) and optional media settings. 

2. FastPix uploads the video from the provided URL to its storage. 

3. Receive a response containing the unique id for the newly created media item. 

4. Use the id in subsequent API calls, such as checking the status of the media with the <a href="https://fastpix.com/docs/video-on-demand-api/manage-videos/get-media">Get Media by ID</a> endpoint to determine when the media is ready for playback. 

FastPix uses webhooks to tell your application about things that happen in the background, outside of the API regular request flow. For instance, after the media file is created (but not yet processed or encoded), FastPix sends a `POST` request to your specified webhook URL with the event <a href="https://fastpix.com/docs/webhooks/media-events#videomediacreated">video.media.created</a>. 


After processing completes, monitor the events <a href="https://fastpix.com/docs/webhooks/media-events#videomediaready">video.media.ready</a> and <a href="https://fastpix.com/docs/webhooks/media-events#videomediafailed">video.media.failed</a> to track the status of the media file.


Related guide: <a href="https://fastpix.com/docs/upload-videos/upload-videos-from-a-url">Upload videos from URL</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="create-media" method="post" path="/on-demand" -->
```ruby
require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

req = Models::Components::CreateMediaRequest.new(
  inputs: [
    Models::Components::PullVideoInput.new(
      type: 'video',
      url: 'https://static.fastpix.com/fp-sample-video.mp4',
    ),
  ],
  metadata: {
    "key1": 'value1',
  },
)

res = s.input_video.create_media(request: req)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                           | Type                                                                                | Required                                                                            | Description                                                                         |
| ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------- |
| `request`                                                                           | [Models::Components::CreateMediaRequest](../../models/shared/createmediarequest.md) | :heavy_check_mark:                                                                  | The request object to use for the request.                                          |

### Response

**[T.nilable(Models::Operations::CreateMediaResponse)](../../models/operations/createmediaresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |

## direct_upload_video_media

This endpoint enables accelerated uploads of large media files directly from your local device to FastPix for processing and storage.

> **NOTE**
>
> This version now supports uploads with no file size limitations and offers faster uploads. The previous endpoint (which had a 500MB size limit) is now deprecated. You can find details in the [changelog](https://fastpix.com/docs/changelog/release-notes).

#### How it works

1. Send a POST request to this endpoint with optional media settings.  

2. The response includes an `uploadId` and a signed `url` for direct video file upload.

3. Upload your video file to the provided url by making a PUT request. The API accepts the media file from your device and uploads it to the FastPix platform. (Refer to <a href="https://fastpix.com/docs/upload-videos/upload-videos-from-device#initiate-the-upload-session-web-only">Step 3: Initiate the upload</a> for complete instructions.)


4. Once uploaded, the media undergoes processing and is assigned a unique ID for tracking. Retain this `uploadId` for any future operations related to this upload. 



After uploading, you can use the <a href="https://fastpix.com/docs/video-on-demand-api/manage-videos/get-media">Get Media by ID</a> endpoint to check the status of the uploaded media asset and see if it has transitioned to a `Ready` status for playback. 

To notify your application about the status of this API request check for the webhooks for <a href="https://fastpix.com/docs/webhooks/webhook-event-reference#media-related-events">media related events</a>.  


#### Example

A social media platform allows users to upload video content directly from their phones or computers. This endpoint facilitates the upload process. For example, if you are developing a video-sharing app where users can upload short clips from their mobile devices, this endpoint enables them to select a video, upload it to the platform.

Related guide: <a href="https://fastpix.com/docs/upload-videos/upload-videos-from-device">Upload videos directly</a>


### Example Usage

<!-- UsageSnippet language="ruby" operationID="direct-upload-video-media" method="post" path="/on-demand/upload" -->
```ruby
require 'json'
require 'fastpixapi'

Models = ::FastpixClient::Models
s = ::FastpixClient::Fastpixapi.new(
      security: Models::Components::Security.new(
        username: 'your-access-token',
        password: 'your-secret-key',
      ),
    )

req = Models::Operations::DirectUploadVideoMediaRequest.new(
  push_media_settings: Models::Operations::PushMediaSettings.new(
    metadata: {
      "key1": 'value1',
    },
  ),
)

res = s.input_video.direct_upload_video_media(request: req)

begin
  puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError
  puts res.raw_response.body.to_s
end

```

### Parameters

| Parameter                                                                                                     | Type                                                                                                          | Required                                                                                                      | Description                                                                                                   |
| ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| `request`                                                                                                     | [Models::Operations::DirectUploadVideoMediaRequest](../../models/operations/directuploadvideomediarequest.md) | :heavy_check_mark:                                                                                            | The request object to use for the request.                                                                    |

### Response

**[T.nilable(Models::Operations::DirectUploadVideoMediaResponse)](../../models/operations/directuploadvideomediaresponse.md)**

### Errors

| Error Type       | Status Code      | Content Type     |
| ---------------- | ---------------- | ---------------- |
| Errors::APIError | 4XX, 5XX         | \*/\*            |