# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Compare multiple metrics across specified dimensions.
      class MetricsComparisonDetails
        extend T::Sig
        include Crystalline::MetadataFields

        # The specific metric value calculated based on the applied filters.
        field :value, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('value') } }
        # value can be score that ranges from 0 to 100
        field :type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type') } }
        # value can be score that ranges from 0 to 100
        field :name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('name') } }
        # The metric field represents the name of the Key Performance Indicator (KPI) being tracked or analyzed. It identifies a specific measurable aspect of the video playback experience, such as buffering time, video start failure rate, or playback quality.
        # 
        field :metric, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metric') } }
        # value can be avg, sum, count or 95th
        field :measurement, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('measurement') } }
        # Nested comparison items
        field :items, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::MetricsComparisonDetails)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('items') } }

        sig { params(value: T.nilable(::Float), type: T.nilable(::String), name: T.nilable(::String), metric: T.nilable(::String), measurement: T.nilable(::String), items: T.nilable(T::Array[Models::Components::MetricsComparisonDetails])).void }
        def initialize(value: nil, type: nil, name: nil, metric: nil, measurement: nil, items: nil)
          @value = value
          @type = type
          @name = name
          @metric = metric
          @measurement = measurement
          @items = items
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @value == other.value
          return false unless @type == other.type
          return false unless @name == other.name
          return false unless @metric == other.metric
          return false unless @measurement == other.measurement
          return false unless @items == other.items
          true
        end
      end
    end
  end
end
