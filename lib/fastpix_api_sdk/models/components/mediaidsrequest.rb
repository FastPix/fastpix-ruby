
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # The list of mediaId(s) you want to perform the operation on.rds by limit.
      class MediaIdsRequest
        extend T::Sig
        include Crystalline::MetadataFields


        field :media_ids, Crystalline::Array.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mediaIds'), required: true } }

        sig { params(media_ids: T::Array[::String]).void }
        def initialize(media_ids:)
          @media_ids = media_ids
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @media_ids == other.media_ids
          true
        end
      end
    end
  end
end
