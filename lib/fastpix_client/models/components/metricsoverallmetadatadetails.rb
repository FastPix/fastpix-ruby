# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # metadata that has to be paased for metric calculations.
      class MetricsOverallmetadataDetails
        extend T::Sig
        include Crystalline::MetadataFields

        # defines the field or dimension on which the aggregation is to be   applied.
        field :aggregation, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('aggregation') } }

        sig { params(aggregation: T.nilable(::String)).void }
        def initialize(aggregation: nil)
          @aggregation = aggregation
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @aggregation == other.aggregation
          true
        end
      end
    end
  end
end
