# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Get filter/ dimension value details by dimension name.
      class ListOverallValuesResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Shows the request status. Returns true for success and false for failure.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success') } }
        # metadata that has to be paased for metric calculations.
        field :metadata, Crystalline::Nilable.new(Models::Components::MetricsOverallmetadataDetails), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }
        # Retrieves overall values for a specified metric
        field :data, Crystalline::Nilable.new(Models::Components::MetricsOverallDataDetails), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data') } }
        # The timespan from and to details displayed in the form of unix epoch timestamps.
        # 
        field :timespan, Crystalline::Nilable.new(Crystalline::Array.new(::Integer)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('timespan') } }

        sig { params(success: T.nilable(T::Boolean), metadata: T.nilable(Models::Components::MetricsOverallmetadataDetails), data: T.nilable(Models::Components::MetricsOverallDataDetails), timespan: T.nilable(T::Array[::Integer])).void }
        def initialize(success: nil, metadata: nil, data: nil, timespan: nil)
          @success = success
          @metadata = metadata
          @data = data
          @timespan = timespan
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          return false unless @metadata == other.metadata
          return false unless @data == other.data
          return false unless @timespan == other.timespan
          true
        end
      end
    end
  end
end
