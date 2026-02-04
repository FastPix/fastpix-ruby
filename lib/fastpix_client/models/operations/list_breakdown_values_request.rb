# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class ListBreakdownValuesRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Pass metric Id
        # 
        field :metric_id, Models::Operations::ListBreakdownValuesMetricId, { 'path_param': { 'field_name': 'metricId', 'style': 'simple', 'explode': false } }
        # This parameter specifies the time span between which the video views list must be retrieved by. You can provide either from and to unix epoch timestamps or time duration. The scope of duration is between 60 minutes to 30 days.
        # 
        # **Accepted formats are:**
        # 
        # array of epoch timestamps for example 
        # `timespan[]=1498867200&timespan[]=1498953600`
        # 
        # duration string for example  
        # `timespan[]=24:hours` or `timespan[]=7:days`
        # 
        field :timespan, Crystalline::Nilable.new(Models::Operations::ListBreakdownValuesTimespan), { 'query_param': { 'field_name': 'timespan[]', 'style': 'form', 'explode': true } }
        # Pass the dimensions and their corresponding values you want to filter the views by. For excluding the values in the filter we can pass "!" before the filter value. The list of filters can be obtained from list of dimensions endpoint.
        # Example Values : [ browser_name:Chrome , os_name:macOS , !device_name:Galaxy ]
        # 
        field :filterby, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'filterby[]', 'style': 'form', 'explode': true } }
        # Pass this value to group the metrics list by.
        # Possible Values : ["browser_name", "browser_version", "os_name","os_version" , "device_name", "device_model", "device_type", "device_manufacturer", "player_remote_played",player_name", "player_version", "player_software_name", "player_software_version", "player_resolution", "fp_sdk","fp_sdk_version", "player_autoplay_on", "player_preload_on","video_title",  "video_id", "video_series" ,  "fp_playback_id","fp_live_stream_id", "media_id","video_source_stream_type", "video_source_type", "video_encoding_variant", "experiment_name", "sub_property_id", "drm_type","asn_name", "cdn", "video_source_hostname", "connection_type", "view_session_id","continent","country", "region","viewer_id", "error_code", "exit_before_video_start", "view_has_ad", "video_startup_failed" , "page_context", "playback_failed".]
        # 
        field :group_by, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'groupBy', 'style': 'form', 'explode': true } }
        # Pass the limit to display only the rows specified by the value.
        # 
        field :limit, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'limit', 'style': 'form', 'explode': true } }
        # Pass the offset value to indicate the page number.
        # 
        field :offset, Crystalline::Nilable.new(::Integer), { 'query_param': { 'field_name': 'offset', 'style': 'form', 'explode': true } }
        # Pass this value to order the metrics list by.
        # 
        field :order_by, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'orderBy', 'style': 'form', 'explode': true } }
        # The order direction to sort the metrics list by.
        # 
        field :sort_order, Crystalline::Nilable.new(Models::Operations::ListBreakdownValuesSortOrder), { 'query_param': { 'field_name': 'sortOrder', 'style': 'form', 'explode': true } }
        # The measurement for the given metrics.
        # Possible Values : [95th, median, avg, count or sum]
        # 
        field :measurement, Crystalline::Nilable.new(::String), { 'query_param': { 'field_name': 'measurement', 'style': 'form', 'explode': true } }

        sig { params(metric_id: Models::Operations::ListBreakdownValuesMetricId, timespan: T.nilable(Models::Operations::ListBreakdownValuesTimespan), filterby: T.nilable(::String), group_by: T.nilable(::String), limit: T.nilable(::Integer), offset: T.nilable(::Integer), order_by: T.nilable(::String), sort_order: T.nilable(Models::Operations::ListBreakdownValuesSortOrder), measurement: T.nilable(::String)).void }
        def initialize(metric_id:, timespan: nil, filterby: nil, group_by: nil, limit: 10, offset: 1, order_by: 'views', sort_order: Models::Operations::ListBreakdownValuesSortOrder::ASC, measurement: 'avg')
          @metric_id = metric_id
          @timespan = timespan
          @filterby = filterby
          @group_by = group_by
          @limit = limit
          @offset = offset
          @order_by = order_by
          @sort_order = sort_order
          @measurement = measurement
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @metric_id == other.metric_id
          return false unless @timespan == other.timespan
          return false unless @filterby == other.filterby
          return false unless @group_by == other.group_by
          return false unless @limit == other.limit
          return false unless @offset == other.offset
          return false unless @order_by == other.order_by
          return false unless @sort_order == other.sort_order
          return false unless @measurement == other.measurement
          true
        end
      end
    end
  end
end
