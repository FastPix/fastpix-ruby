# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class TracksSubtitles
        extend T::Sig
        include Crystalline::MetadataFields

        # Current status of the generated subtitle track.
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('status') } }
        # URL of the generated subtitle file (VTT). Null while preparing.
        field :url, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('url') } }

        sig { params(status: T.nilable(::String), url: T.nilable(::String)).void }
        def initialize(status: nil, url: nil)
          @status = status
          @url = url
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @status == other.status
          return false unless @url == other.url
          true
        end
      end
    end
  end
end
