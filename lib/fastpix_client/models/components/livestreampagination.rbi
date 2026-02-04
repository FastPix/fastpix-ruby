# typed: true
# frozen_string_literal: true


class FastpixClient::Models::Components::LiveStreamPagination
  extend ::Crystalline::MetadataFields::ClassMethods
end


class FastpixClient::Models::Components::LiveStreamPagination
  def total_records(); end
  def total_records=(str_); end
  def current_offset(); end
  def current_offset=(str_); end
  def offset_count(); end
  def offset_count=(str_); end
end