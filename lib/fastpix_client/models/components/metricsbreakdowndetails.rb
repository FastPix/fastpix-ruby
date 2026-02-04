# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class MetricsBreakdownDetails
        extend T::Sig
        include Crystalline::MetadataFields

        # Total count of view sessions for a paricular video content.
        field :views, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('views') } }
        # The specific metric value calculated based on the applied filters.
        field :value, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('value') } }
        # Total time watched across all views, represented in milliseconds.
        field :total_watch_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('totalWatchTime') } }
        # Total time spent playing the video, represented in milliseconds.
        field :total_playing_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('totalPlayingTime') } }
        # the value of dimension or filter value on which the aggregation is to be applied.
        field :field, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('field') } }

        sig { params(views: T.nilable(::Integer), value: T.nilable(::Float), total_watch_time: T.nilable(::Integer), total_playing_time: T.nilable(::Integer), field: T.nilable(::String)).void }
        def initialize(views: nil, value: nil, total_watch_time: nil, total_playing_time: nil, field: nil)
          @views = views
          @value = value
          @total_watch_time = total_watch_time
          @total_playing_time = total_playing_time
          @field = field
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @views == other.views
          return false unless @value == other.value
          return false unless @total_watch_time == other.total_watch_time
          return false unless @total_playing_time == other.total_playing_time
          return false unless @field == other.field
          true
        end
      end
    end
  end
end
