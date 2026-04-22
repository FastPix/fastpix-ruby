# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class Event
        extend T::Sig
        include Crystalline::MetadataFields

        DETAILS_KEY_MAP = {
          # variantChanged details
          'br'  => 'bitrate',
          'h'   => 'height',
          'w'   => 'width',
          'cd'  => 'codec',
          'fps' => 'fps',
          # requestFailed details
          'host' => 'hostName',
          'u'    => 'url',
          't'    => 'type',
          'txt'  => 'text',
          'c'    => 'code',
          'err'  => 'error'
        }.freeze


        field :event_details, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::Object)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('d') } }
        # The player_playhead_time represents the current position of the playhead (the point in the video that is being watched) on the video seekbar, measured in milliseconds. This value indicates how far into the video playback has progressed at any given moment.
        #
        field :player_playhead_time, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('pt') } }
        # Name of the event.
        #
        field :event_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('e') } }
        # The unix epoch timestamp which represents the actual time the event has occurred.
        #
        field :viewer_time, Crystalline::Nilable.new(Crystalline::Union.new(::String, ::Integer)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('vt') } }
        # The unix epoch timestamp when the event was captured.
        #
        field :event_time, Crystalline::Nilable.new(Crystalline::Union.new(::String, ::Integer)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('event_time') } }

        sig { params(event_details: T.nilable(T::Hash[Symbol, ::Object]), player_playhead_time: T.nilable(::Integer), event_name: T.nilable(::String), viewer_time: T.nilable(T.any(::String, ::Integer)), event_time: T.nilable(T.any(::String, ::Integer))).void }
        def initialize(event_details: nil, player_playhead_time: nil, event_name: nil, viewer_time: nil, event_time: nil)
          @event_details = event_details
          @player_playhead_time = player_playhead_time
          @event_name = event_name
          @viewer_time = viewer_time
          @event_time = event_time
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @event_details == other.event_details
          return false unless @player_playhead_time == other.player_playhead_time
          return false unless @event_name == other.event_name
          return false unless @viewer_time == other.viewer_time
          return false unless @event_time == other.event_time
          true
        end

        def to_dict
          expanded_details = @event_details&.transform_keys { |k| DETAILS_KEY_MAP.fetch(k.to_s, k) }
          result = {
            'playerPlayheadTime' => @player_playhead_time,
            'eventName'          => @event_name
          }
          result['eventDetails'] = expanded_details if expanded_details
          result['viewerTime'] = @viewer_time
          result
        end
      end
    end
  end
end
