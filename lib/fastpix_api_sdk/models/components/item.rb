
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class Item
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
        # value can be avg, sum, count or 95th
        field :measurement, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('measurement') } }

        sig { params(value: T.nilable(::Integer), type: T.nilable(::String), name: T.nilable(::String), metric: T.nilable(::String), measurement: T.nilable(::String)).void }
        def initialize(value: nil, type: nil, name: nil, metric: nil, measurement: nil)
          @value = value
          @type = type
          @name = name
          @metric = metric
          @measurement = measurement
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @value == other.value
          return false unless @type == other.type
          return false unless @name == other.name
          return false unless @metric == other.metric
          return false unless @measurement == other.measurement
          true
        end
      end
    end
  end
end
