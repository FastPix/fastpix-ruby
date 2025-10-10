
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # Successfully retrieved concurrent viewers timeseries.
      class GetDataViewlistCurrentViewsGetTimeseriesViewsResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Indicates if the request was successful.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('success') } }
        # Time series data for concurrent viewers.
        field :data, Crystalline::Nilable.new(Crystalline::Array.new(Models::Operations::GetDataViewlistCurrentViewsGetTimeseriesViewsData)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('data') } }
        # Start and end epoch timestamps (milliseconds) for the timeseries window.
        field :timespan, Crystalline::Nilable.new(Crystalline::Array.new(::Integer)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('timespan') } }

        sig { params(success: T.nilable(T::Boolean), data: T.nilable(T::Array[Models::Operations::GetDataViewlistCurrentViewsGetTimeseriesViewsData]), timespan: T.nilable(T::Array[::Integer])).void }
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
