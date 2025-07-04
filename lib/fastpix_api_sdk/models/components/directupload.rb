# Code generated by Speakeasy (https://speakeasy.com). DO NOT EDIT.

# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Displays the result of the request.
      class DirectUpload
        extend T::Sig
        include Crystalline::MetadataFields

        # When creating the upload, FastPix assigns a universally unique identifier with a maximum length of 255 characters.
        field :id, T.nilable(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('id') } }
        # When creating the media, FastPix assigns a universally unique identifier with a maximum length of 255 characters.
        field :media_id, T.nilable(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mediaId') } }
        # Determines the media's status, which can be one of the possible values.
        field :status, T.nilable(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('status') } }
        # The url hosts the media file for FastPix, which needs to be download to use further.  It supports formats like MP3, MP4, MOV, MKV, or TS, and includes text tracks for subtitles/CC (SRT file/VTT file). While FastPix can handle various audio and video formats and codecs, using standard inputs can help with optimal processing speed.
        field :url, T.nilable(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('url') } }
        # Upload media directly from a device using the url name or enter '*' to allow all.
        field :cors_origin, T.nilable(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('corsOrigin') } }

        field :push_media_settings, T.nilable(Models::Components::DirectUploadResponse), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('pushMediaSettings') } }
        # The duration set for the validity of the upload URL. If the upload isn't completed within this timeframe, it's marked as timed out.
        # 
        field :timeout, T.nilable(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('timeout') } }

        sig { params(id: T.nilable(::String), media_id: T.nilable(::String), status: T.nilable(::String), url: T.nilable(::String), cors_origin: T.nilable(::String), push_media_settings: T.nilable(Models::Components::DirectUploadResponse), timeout: T.nilable(::Float)).void }
        def initialize(id: nil, media_id: nil, status: nil, url: nil, cors_origin: nil, push_media_settings: nil, timeout: 14_400.0)
          @id = id
          @media_id = media_id
          @status = status
          @url = url
          @cors_origin = cors_origin
          @push_media_settings = push_media_settings
          @timeout = timeout
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @media_id == other.media_id
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
