
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Retrieves overall values for a specified metric
      class MetricsOverallDataDetails
        extend T::Sig
        include Crystalline::MetadataFields

        # metric value calculated based on the applied filters.
        field :value, Crystalline::Nilable.new(Crystalline::Union.new(::Integer, ::Float)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('value') } }
        # Total time watched across all views, represented in milliseconds.
        field :total_watch_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('totalWatchTime') } }
        # The count of unique viewers who interacted with the content.
        field :unique_views, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('uniqueViews') } }
        # The total number of views recorded.
        field :total_views, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('totalViews') } }
        # Total time spent playing the video, represented in milliseconds.
        field :total_play_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('totalPlayTime') } }
        # A global metric value that reflects the overall performance of the specified metric across the entire dataset for the given timespan.
        field :global_value, Crystalline::Nilable.new(Crystalline::Union.new(::Integer, ::Float)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('globalValue') } }

        sig { params(value: T.nilable(T.any(::Integer, ::Float)), total_watch_time: T.nilable(::Integer), unique_views: T.nilable(::Integer), total_views: T.nilable(::Integer), total_play_time: T.nilable(::Integer), global_value: T.nilable(T.any(::Integer, ::Float))).void }
        def initialize(value: nil, total_watch_time: nil, unique_views: nil, total_views: nil, total_play_time: nil, global_value: nil)
          @value = value
          @total_watch_time = total_watch_time
          @unique_views = unique_views
          @total_views = total_views
          @total_play_time = total_play_time
          @global_value = global_value
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @value == other.value
          return false unless @total_watch_time == other.total_watch_time
          return false unless @unique_views == other.unique_views
          return false unless @total_views == other.total_views
          return false unless @total_play_time == other.total_play_time
          return false unless @global_value == other.global_value
          true
        end
      end
    end
  end
end
