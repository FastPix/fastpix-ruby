
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # Get filter/ dimension value details by dimension name.
      class ListOverallValuesResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # It demonstrates whether the request is successful or not.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('success') } }
        # Metadata that has to be paased for metric calculations.
        field :meta_data, Crystalline::Nilable.new(Models::Components::MetricsOverallMetaDataDetails), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metaData') } }
        # Retrieves overall values for a specified metric
        field :data, Crystalline::Nilable.new(Models::Components::MetricsOverallDataDetails), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('data') } }
        # The timeframe from and to details displayed in the form of unix epoch timestamps.
        # 
        field :timespan, Crystalline::Nilable.new(Crystalline::Array.new(::Integer)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('timespan') } }

        sig { params(success: T.nilable(T::Boolean), meta_data: T.nilable(Models::Components::MetricsOverallMetaDataDetails), data: T.nilable(Models::Components::MetricsOverallDataDetails), timespan: T.nilable(T::Array[::Integer])).void }
        def initialize(success: nil, meta_data: nil, data: nil, timespan: nil)
          @success = success
          @meta_data = meta_data
          @data = data
          @timespan = timespan
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          return false unless @meta_data == other.meta_data
          return false unless @data == other.data
          return false unless @timespan == other.timespan
          true
        end
      end
    end
  end
end
