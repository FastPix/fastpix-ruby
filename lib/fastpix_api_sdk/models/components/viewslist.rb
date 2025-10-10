
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class ViewsList
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier for the viewing session of the user.
        # 
        field :view_id, ::String, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewId'), required: true } }
        # Operating System signifies the software platform utilized by the viewer
        # 
        field :operating_system, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('operatingSystem'), required: true } }
        # The browser name of the viewer.
        # 
        field :application, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('application'), required: true } }
        # The start timestamp of the video view.
        # 
        field :view_start_time, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewStartTime'), required: true } }
        # The end timestamp of the video view.
        # 
        field :view_end_time, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewEndTime'), required: true } }
        # The title of the Video.
        # 
        field :video_title, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoTitle'), required: true } }
        # Country of the viewer.
        # 
        field :country, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('country'), required: true } }
        # The code which represents specific issues or failures that occur during playback. These can be implementation specific.
        # 
        field :error_code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('errorCode') } }
        # The notifications or messages that inform users or developers about issues or failures that have occurred during the playback representing error codes.
        # 
        field :error_message, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('errorMessage') } }
        # The unique identifier which identifies each type of error that occurs.
        # 
        field :error_id, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('errorId') } }
        # The watch time represents the time spent watching the video including staruptime, playback time ,buffering time.
        # 
        field :view_watch_time, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('viewWatchTime') } }
        # The viewer experience encapsulated in the form of score while watching the video.
        # 
        field :qoe_score, Crystalline::Nilable.new(::Float), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('QoeScore') } }

        sig { params(view_id: ::String, operating_system: T.nilable(::String), application: T.nilable(::String), view_start_time: T.nilable(::String), view_end_time: T.nilable(::String), video_title: T.nilable(::String), country: T.nilable(::String), error_code: T.nilable(::String), error_message: T.nilable(::String), error_id: T.nilable(::Integer), view_watch_time: T.nilable(::Float), qoe_score: T.nilable(::Float)).void }
        def initialize(view_id:, operating_system: nil, application: nil, view_start_time: nil, view_end_time: nil, video_title: nil, country: nil, error_code: nil, error_message: nil, error_id: nil, view_watch_time: nil, qoe_score: nil)
          @view_id = view_id
          @operating_system = operating_system
          @application = application
          @view_start_time = view_start_time
          @view_end_time = view_end_time
          @video_title = video_title
          @country = country
          @error_code = error_code
          @error_message = error_message
          @error_id = error_id
          @view_watch_time = view_watch_time
          @qoe_score = qoe_score
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @view_id == other.view_id
          return false unless @operating_system == other.operating_system
          return false unless @application == other.application
          return false unless @view_start_time == other.view_start_time
          return false unless @view_end_time == other.view_end_time
          return false unless @video_title == other.video_title
          return false unless @country == other.country
          return false unless @error_code == other.error_code
          return false unless @error_message == other.error_message
          return false unless @error_id == other.error_id
          return false unless @view_watch_time == other.view_watch_time
          return false unless @qoe_score == other.qoe_score
          true
        end
      end
    end
  end
end
