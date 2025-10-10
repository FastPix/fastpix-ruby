# typed: true
# frozen_string_literal: true


class FastpixApiSDK::Models::Operations::GetTimeseriesDataRequest
  extend ::Crystalline::MetadataFields::ClassMethods
end


class FastpixApiSDK::Models::Operations::GetTimeseriesDataRequest
  def metric_id(); end
  def metric_id=(str_); end
  def timespan(); end
  def timespan=(str_); end
  def filterby(); end
  def filterby=(str_); end
  def group_by(); end
  def group_by=(str_); end
  def sort_order(); end
  def sort_order=(str_); end
  def measurement(); end
  def measurement=(str_); end
end