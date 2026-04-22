# frozen_string_literal: true

require 'json'
require_relative 'lib/fastpixapi'

Models = ::FastpixClient::Models

s = ::FastpixClient::Fastpixapi.new(
  security: Models::Components::Security.new(
    username: '34539a06-62d4-4a60-95ca-99dfe8679487',
    password: 'da6bc2a8-58a8-4703-8332-0f469ce69d06',
  ),
)

begin
  res = s.views.get_video_view_details(view_id: '64bb9e7c-bf00-4939-b145-4008aca47fc7')
  puts JSON.pretty_generate(res.object.to_dict)
rescue FastpixClient::Models::Errors::APIError => e
  puts JSON.pretty_generate(JSON.parse(e.body))
rescue StandardError => e
  puts e.message
end
