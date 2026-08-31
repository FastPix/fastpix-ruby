#!/usr/bin/env ruby
# frozen_string_literal: true

# Read-only tour of the analytics endpoints: views, dimensions, metrics, errors.
# All are scoped to a time window; here we use the last 24 hours.

require 'fastpixapi'
require 'json'

Models = ::FastpixClient::Models
Ops = Models::Operations

sdk = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: ENV.fetch('FASTPIX_USERNAME'),
    password: ENV.fetch('FASTPIX_PASSWORD')
  )
)

def rows(res)
  data = JSON.parse(res.raw_response.body)['data']
  data.is_a?(Array) ? data.length : 'n/a'
rescue StandardError
  'n/a'
end

views = sdk.views.list_video_views(
  request: Ops::ListVideoViewsRequest.new(timespan: Ops::ListVideoViewsTimespan::TWENTY_FOURHOURS)
)
puts "list_video_views    -> HTTP #{views.status_code}, #{rows(views)} row(s)"

dims = sdk.dimensions.list_dimensions
puts "list_dimensions     -> HTTP #{dims.status_code}, #{rows(dims)} row(s)"

overall = sdk.metrics.list_overall_values(
  metric_id: Ops::ListOverallValuesMetricId::QUALITY_OF_EXPERIENCE_SCORE,
  measurement: 'avg',
  timespan: Ops::ListOverallValuesTimespan::TWENTY_FOURHOURS
)
puts "list_overall_values -> HTTP #{overall.status_code}"

errors = sdk.errors.list_errors(timespan: Ops::ListErrorsTimespan::TWENTY_FOURHOURS)
puts "list_errors         -> HTTP #{errors.status_code}, #{rows(errors)} row(s)"
