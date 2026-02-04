# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class MediaClipResponsePagination
        extend T::Sig
        include Crystalline::MetadataFields

        # Total number of records available.
        field :total_records, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('totalRecords') } }
        # The starting offset of the current result set.
        field :current_offset, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('currentOffset') } }
        # The number of items returned in the current response.
        field :offset_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('offsetCount') } }

        sig { params(total_records: T.nilable(::Integer), current_offset: T.nilable(::Integer), offset_count: T.nilable(::Integer)).void }
        def initialize(total_records: nil, current_offset: nil, offset_count: nil)
          @total_records = total_records
          @current_offset = current_offset
          @offset_count = offset_count
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @total_records == other.total_records
          return false unless @current_offset == other.current_offset
          return false unless @offset_count == other.offset_count
          true
        end
      end
    end
  end
end
