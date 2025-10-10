
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Retrieves a list of the top video views
      class ViewsByTopContentDetails
        extend T::Sig
        include Crystalline::MetadataFields

        # Title of the video
        field :video_title, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('videoTitle') } }
        # Total count of view sessions for a paricular video content.
        field :views, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('views') } }
        # Total count of unique video viewers for particular video content.
        field :unique_views, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('uniqueViews') } }

        sig { params(video_title: T.nilable(::String), views: T.nilable(::Integer), unique_views: T.nilable(::Integer)).void }
        def initialize(video_title: nil, views: nil, unique_views: nil)
          @video_title = video_title
          @views = views
          @unique_views = unique_views
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @video_title == other.video_title
          return false unless @views == other.views
          return false unless @unique_views == other.unique_views
          true
        end
      end
    end
  end
end
