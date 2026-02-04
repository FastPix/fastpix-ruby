# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class PullVideoInputSegment1
        extend T::Sig
        include Crystalline::MetadataFields

        # The URL of the **video segment** to be added.  
        # The URL must be **valid, publicly accessible, and downloadable** so that FastPix can retrieve and process the segment successfully.  
        # Supported video formats include **MP4, MOV, MKV, and TS** for best compatibility and performance.
        # 
        field :url, ::String, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('url'), required: true } }
        # The timestamp(in seconds) at which the segment must be inserted.
        field :insert_at, ::Integer, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('insertAt'), required: true } }

        sig { params(url: ::String, insert_at: ::Integer).void }
        def initialize(url:, insert_at:)
          @url = url
          @insert_at = insert_at
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @url == other.url
          return false unless @insert_at == other.insert_at
          true
        end
      end
    end
  end
end
