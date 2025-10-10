
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class CancelUploadRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # When uploading the media, FastPix assigns a universally unique identifier with a maximum length of 255 characters.
        field :upload_id, ::String, { 'path_param': { 'field_name': 'uploadId', 'style': 'simple', 'explode': false } }

        sig { params(upload_id: ::String).void }
        def initialize(upload_id:)
          @upload_id = upload_id
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @upload_id == other.upload_id
          true
        end
      end
    end
  end
end
