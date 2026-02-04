# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class PullVideoInputSegment2
        extend T::Sig
        include Crystalline::MetadataFields

        # The URL of the **video segment** to be added.  
        # The URL must be **valid, publicly accessible, and downloadable** so that FastPix can retrieve and process the segment successfully.  
        # Supported video formats include **MP4, MOV, MKV, and TS** for best compatibility and performance.
        # 
        field :url, ::String, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('url'), required: true } }
        # Flag indicating the segment should be inserted at the end.
        field :insert_at_end, Crystalline::Boolean.new, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('insertAtEnd'), required: true } }

        sig { params(url: ::String, insert_at_end: T::Boolean).void }
        def initialize(url:, insert_at_end:)
          @url = url
          @insert_at_end = insert_at_end
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @url == other.url
          return false unless @insert_at_end == other.insert_at_end
          true
        end
      end
    end
  end
end
