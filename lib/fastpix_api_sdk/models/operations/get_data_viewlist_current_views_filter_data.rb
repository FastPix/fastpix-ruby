
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GetDataViewlistCurrentViewsFilterData
        extend T::Sig
        include Crystalline::MetadataFields

        # Number of concurrent viewers for this dimension value.
        field :concurrent_viewers, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('concurrent_viewers') } }
        # Name of the dimension (e.g., country, device type, etc.).
        field :dimension_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('dimension_name') } }
        # Additional metric value for this dimension (if applicable).
        field :metric_value, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metricValue') } }

        sig { params(concurrent_viewers: T.nilable(::Integer), dimension_name: T.nilable(::String), metric_value: T.nilable(::Integer)).void }
        def initialize(concurrent_viewers: nil, dimension_name: nil, metric_value: nil)
          @concurrent_viewers = concurrent_viewers
          @dimension_name = dimension_name
          @metric_value = metric_value
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @concurrent_viewers == other.concurrent_viewers
          return false unless @dimension_name == other.dimension_name
          return false unless @metric_value == other.metric_value
          true
        end
      end
    end
  end
end
