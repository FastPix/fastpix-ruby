# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)

require 'json'
require 'minitest/autorun'
require 'fastpixapi'

# Standard response handling for any SDK operation. Prints only the JSON body.
#   res = s.input_video.create_media(request: req)
#   print_response(res)
def print_response(res)
  begin
    puts JSON.pretty_generate(JSON.parse(res.raw_response.body))
  rescue StandardError
    puts res.raw_response.body.to_s
  end
end

# Standard error handling when the SDK raises APIError (4xx/5xx). Prints only the JSON body.
#   rescue FastpixClient::Models::Errors::APIError => e
#     print_api_error(e)
def print_api_error(err)
  begin
    puts JSON.pretty_generate(JSON.parse(err.body))
  rescue StandardError
    puts err.body.to_s
  end
end
