
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # Get filter/ dimension value details by dimension name.
      class ListComparisonValuesResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # It demonstrates whether the request is successful or not.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('success') } }
        # Displays the result of the request.
        # 
        field :data, Crystalline::Nilable.new(Crystalline::Array.new(Crystalline::Array.new(Models::Components::MetricsComparisonDetails))), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('data') } }
        # The timeframe from and to details displayed in the form of unix epoch timestamps.
        # 
        field :timespan, Crystalline::Nilable.new(Crystalline::Array.new(::Integer)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('timespan') } }

        sig { params(success: T.nilable(T::Boolean), data: T.nilable(T::Array[T::Array[Models::Components::MetricsComparisonDetails]]), timespan: T.nilable(T::Array[::Integer])).void }
        def initialize(success: nil, data: nil, timespan: nil)
          @success = success
          @data = data
          @timespan = timespan
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          return false unless @data == other.data
          return false unless @timespan == other.timespan
          true
        end
      end
    end
  end
end
