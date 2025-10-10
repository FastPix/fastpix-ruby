
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Retrieves breakdown values for a specified metric and timespan
      class MetricsTimeseriesMetaDataDetails
        extend T::Sig
        include Crystalline::MetadataFields

        # the unit for aggregating the timeseries data.
        field :granularity, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('granularity') } }
        # defines the field or dimension on which the aggregation is to be   applied.
        field :aggregation, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('aggregation') } }

        sig { params(granularity: T.nilable(::String), aggregation: T.nilable(::String)).void }
        def initialize(granularity: nil, aggregation: nil)
          @granularity = granularity
          @aggregation = aggregation
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @granularity == other.granularity
          return false unless @aggregation == other.aggregation
          true
        end
      end
    end
  end
end
