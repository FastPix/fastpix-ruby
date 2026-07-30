# frozen_string_literal: true

require 'json'
require_relative 'lib/fastpixapi'

Models = ::FastpixClient::Models

s = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: 'your_access_token',
    password: 'your_secrect_key',
  ),
)

begin
  res = s.views.get_video_view_details(view_id: 'your_view_id')
  puts JSON.pretty_generate(res.object.to_dict)
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError => e
  puts e.message
end
