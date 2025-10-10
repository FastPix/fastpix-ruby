
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # GetDataViewlistCurrentViewsFilterDimension - The dimension to group and breakdown the concurrent viewers data by.
      # This determines how the results will be categorized and aggregated.
      # Choose from geographic, content, technical, or behavioral dimensions.
      # 
      class GetDataViewlistCurrentViewsFilterDimension < T::Enum


        enums do
          COUNTRY = new('country')
          REGION = new('region')
          ASN_ID = new('asn_id')
          CDN = new('cdn')
          VIDEO_TITLE = new('video_title')
          VIDEO_SERIES = new('video_series')
          VIDEO_ID = new('video_id')
          SUB_PROPERTY_ID = new('sub_property_id')
          VIDEO_SOURCE_STREAM_TYPE = new('video_source_stream_type')
          OS_NAME = new('os_name')
          PLAYER_NAME = new('player_name')
          MEDIA_ID = new('media_id')
          FP_PLAYBACK_ID = new('fp_playback_id')
          VIEW_ID = new('view_id')
        end
      end
    end
  end
end
