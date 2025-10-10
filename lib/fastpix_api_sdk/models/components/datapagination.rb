
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Pagination organizes content into pages for better readability and navigation.
      class DataPagination
        extend T::Sig
        include Crystalline::MetadataFields

        # The total number of records retrieved within the timeframe.
        # 
        field :total_records, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('totalRecords') } }
        # The current offset value. 
        # 
        # Default: 1
        # 
        field :current_offset, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('currentOffset') } }
        # The total number of offsets based on limit.
        # 
        field :offset_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('offsetCount') } }

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
