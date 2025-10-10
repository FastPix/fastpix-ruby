
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class Event
        extend T::Sig
        include Crystalline::MetadataFields


        field :details, Crystalline::Nilable.new(Models::Components::Details), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('details') } }
        # Name of the event.
        # 
        field :event_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('event_name') } }
        # The unix epoch timestamp when the event was captured.
        # 
        field :event_time, Crystalline::Nilable.new(Crystalline::Union.new(::String, ::Integer)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('event_time') } }
        # The unix epoch timestamp which represents the actual time the event has occured.
        # 
        field :viewer_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewer_time') } }
        # The player_playhead_time represents the current position of the playhead (the point in the video that is being watched) on the video seekbar, measured in milliseconds. This value indicates how far into the video playback has progressed at any given moment.
        # 
        field :player_playhead_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('player_playhead_time') } }

        sig { params(details: T.nilable(Models::Components::Details), event_name: T.nilable(::String), event_time: T.nilable(T.any(::String, ::Integer)), viewer_time: T.nilable(::Integer), player_playhead_time: T.nilable(::Integer)).void }
        def initialize(details: nil, event_name: nil, event_time: nil, viewer_time: nil, player_playhead_time: nil)
          @details = details
          @event_name = event_name
          @event_time = event_time
          @viewer_time = viewer_time
          @player_playhead_time = player_playhead_time
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @details == other.details
          return false unless @event_name == other.event_name
          return false unless @event_time == other.event_time
          return false unless @viewer_time == other.viewer_time
          return false unless @player_playhead_time == other.player_playhead_time
          true
        end
      end
    end
  end
end
