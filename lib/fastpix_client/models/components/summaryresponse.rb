# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class SummaryResponse
        extend T::Sig
        include Crystalline::MetadataFields


        field :media_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('mediaId') } }

        field :is_summary_enabled, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('isSummaryEnabled') } }

        sig { params(media_id: T.nilable(::String), is_summary_enabled: T.nilable(T::Boolean)).void }
        def initialize(media_id: nil, is_summary_enabled: nil)
          @media_id = media_id
          @is_summary_enabled = is_summary_enabled
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @media_id == other.media_id
          return false unless @is_summary_enabled == other.is_summary_enabled
          true
        end
      end
    end
  end
end
