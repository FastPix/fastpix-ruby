# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Date range with start and end dates.
      class DateRange
        extend T::Sig
        include Crystalline::MetadataFields


        field :start_date, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('startDate') } }

        field :end_date, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('endDate') } }

        sig { params(start_date: T.nilable(::String), end_date: T.nilable(::String)).void }
        def initialize(start_date: nil, end_date: nil)
          @start_date = start_date
          @end_date = end_date
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @start_date == other.start_date
          return false unless @end_date == other.end_date
          true
        end
      end
    end
  end
end
