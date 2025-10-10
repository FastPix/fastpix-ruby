
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Response returned when an upload is cancelled.
      class MediaCancelResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier of the cancelled upload.
        field :upload_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('uploadId') } }
        # Indicates if the upload was a trial.
        field :trial, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('trial') } }
        # The status of the upload after cancellation.
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('status') } }
        # The upload URL (if available) after cancellation.
        field :url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('url') } }
        # The timeout value for the upload.
        field :timeout, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('timeout') } }
        # CORS origin allowed for the upload.
        field :cors_origin, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('corsOrigin') } }
        # The maximum resolution allowed for the upload.
        field :max_resolution, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('maxResolution') } }
        # The access policy for the upload.
        field :access_policy, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('accessPolicy') } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key" : "value" pairs. Dynamic Metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }

        sig { params(upload_id: T.nilable(::String), trial: T.nilable(T::Boolean), status: T.nilable(::String), url: T.nilable(::String), timeout: T.nilable(::Integer), cors_origin: T.nilable(::String), max_resolution: T.nilable(::String), access_policy: T.nilable(::String), metadata: T.nilable(T::Hash[Symbol, ::String])).void }
        def initialize(upload_id: nil, trial: nil, status: nil, url: nil, timeout: nil, cors_origin: nil, max_resolution: nil, access_policy: nil, metadata: nil)
          @upload_id = upload_id
          @trial = trial
          @status = status
          @url = url
          @timeout = timeout
          @cors_origin = cors_origin
          @max_resolution = max_resolution
          @access_policy = access_policy
          @metadata = metadata
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @upload_id == other.upload_id
          return false unless @trial == other.trial
          return false unless @status == other.status
          return false unless @url == other.url
          return false unless @timeout == other.timeout
          return false unless @cors_origin == other.cors_origin
          return false unless @max_resolution == other.max_resolution
          return false unless @access_policy == other.access_policy
          return false unless @metadata == other.metadata
          true
        end
      end
    end
  end
end
