
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class MetricsComparisonDetails
        extend T::Sig
        include Crystalline::MetadataFields

        # The specific metric value calculated based on the applied filters.
        field :value, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('value') } }
        # value can be score that ranges from 0 to 100
        field :type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('type') } }
        # value can be score that ranges from 0 to 100
        field :name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('name') } }
        # The metric field represents the name of the Key Performance Indicator (KPI) being tracked or analyzed. It identifies a specific measurable aspect of the video playback experience, such as buffering time, video start failure rate, or playback quality.
        # 
        field :metric, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metric') } }

        field :items, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::Item)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('items') } }

        sig { params(value: T.nilable(::Integer), type: T.nilable(::String), name: T.nilable(::String), metric: T.nilable(::String), items: T.nilable(T::Array[Models::Components::Item])).void }
        def initialize(value: nil, type: nil, name: nil, metric: nil, items: nil)
          @value = value
          @type = type
          @name = name
          @metric = metric
          @items = items
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @value == other.value
          return false unless @type == other.type
          return false unless @name == other.name
          return false unless @metric == other.metric
          return false unless @items == other.items
          true
        end
      end
    end
  end
end
