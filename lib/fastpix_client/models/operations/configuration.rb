# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Represents configuration details for the media.
      class Configuration
        extend T::Sig
        include Crystalline::MetadataFields

        # The URL hosting the media file to be downloaded and processed by FastPix.   Supports formats like MP4, MOV, MKV, TS, MP3, and text tracks (SRT/VTT).   Using standard formats ensures optimal processing speed.
        # 
        field :url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('url') } }

        sig { params(url: T.nilable(::String)).void }
        def initialize(url: nil)
          @url = url
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @url == other.url
          true
        end
      end
    end
  end
end
