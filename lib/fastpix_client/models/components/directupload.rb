# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Displays the result of the request.
      class DirectUpload
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier assigned to the media when created. The value must be a valid UUID.
        field :upload_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('uploadId') } }
        # Indicates if the upload was a trial.
        field :trial, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('trial') } }
        # Determines the media's status, which can be one of the possible values.
        field :status, Crystalline::Nilable.new(Models::Components::DirectUploadStatus), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('status'), 'decoder': Utils.enum_from_string(Models::Components::DirectUploadStatus, true) } }
        # The url hosts the media file for FastPix, which needs to be download to use further.  It supports formats like MP3, MP4, MOV, MKV, or TS, and includes text tracks for subtitles/CC (SRT file/VTT file). While FastPix can handle various audio and video formats and codecs, using standard inputs can help with optimal processing speed.
        field :url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('url') } }
        # Upload media directly from a device using the url name or enter "*" to allow all.
        field :cors_origin, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('corsOrigin') } }

        field :push_media_settings, Crystalline::Nilable.new(Models::Components::DirectUploadResponse), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('pushMediaSettings') } }
        # The duration set for the validity of the upload URL. If the upload isn't completed within this timespan, it's marked as timed out.
        # 
        field :timeout, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('timeout') } }

        sig { params(upload_id: T.nilable(::String), trial: T.nilable(T::Boolean), status: T.nilable(Models::Components::DirectUploadStatus), url: T.nilable(::String), cors_origin: T.nilable(::String), push_media_settings: T.nilable(Models::Components::DirectUploadResponse), timeout: T.nilable(::Float)).void }
        def initialize(upload_id: nil, trial: nil, status: nil, url: nil, cors_origin: nil, push_media_settings: nil, timeout: 14_400.0)
          @upload_id = upload_id
          @trial = trial
          @status = status
          @url = url
          @cors_origin = cors_origin
          @push_media_settings = push_media_settings
          @timeout = timeout
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @upload_id == other.upload_id
          return false unless @trial == other.trial
          return false unless @status == other.status
          return false unless @url == other.url
          return false unless @cors_origin == other.cors_origin
          return false unless @push_media_settings == other.push_media_settings
          return false unless @timeout == other.timeout
          true
        end
      end
    end
  end
end
