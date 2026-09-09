# frozen_string_literal: true

require 'spec_helper'
require 'fastpixapi'

# Every resource method must declare (in its Sorbet sig) the exact
# Models::Operations::*Response envelope it constructs on a 2xx response, and
# that envelope's payload field must be typed as the class the method
# unmarshals the response body into. This scans the source so drift fails
# by method name.
RSpec.describe 'resource method return types' do
  RESOURCE_FILES = Dir[File.expand_path('../lib/fastpix_client/*.rb', __dir__)].reject do |f|
    %w[fastpixapi.rb sdkconfiguration.rb].include?(File.basename(f))
  end
  HELPERS = %w[apply_after_request_hooks encode_request_body initialize get_url].freeze
  EXPECTED_METHOD_COUNT = 70

  def self.scan(file)
    src = File.read(file, encoding: 'UTF-8')
    # Split on method sigs; each chunk holds one method body.
    chunks = src.split(/^    sig \{ params\(/)[1..] || []
    chunks.filter_map do |chunk|
      declared = chunk[/\)\.returns\((Models::Operations::\w+)\) \}\n    def (\w+)/, 1]
      name = chunk[/\)\.returns\((Models::Operations::\w+)\) \}\n    def (\w+)/, 2]
      next if name.nil? || HELPERS.include?(name)

      success = chunk[/match_status_code\(http_response\.status, \[['"]20\d['"]\]\).*?return response/m] || ''
      unmarshaled = success[/Crystalline\.unmarshal_json\(JSON\.parse\(response_data\), (Models::[\w:]+)\)/, 1]
      constructed = success[/(Models::Operations::\w+)\.new\(/, 1]
      payload_field = success[/^\s+(\w+): T\.unsafe\(obj\)/, 1]
      { file: File.basename(file), name: name, declared: declared, unmarshaled: unmarshaled,
        constructed: constructed, payload_field: payload_field }
    end
  end

  METHODS = RESOURCE_FILES.flat_map { |f| scan(f) }

  it "scans every resource method (#{EXPECTED_METHOD_COUNT})" do
    expect(METHODS.size).to eq(EXPECTED_METHOD_COUNT)
  end

  METHODS.each do |m|
    describe "#{m[:file]}##{m[:name]}" do
      it 'declares the envelope it constructs on 2xx' do
        expect(m[:constructed]).not_to be_nil, 'no 2xx response construction found'
        expect(m[:declared]).to eq(m[:constructed])
      end

      it 'types the payload field as the unmarshaled class' do
        expect(m[:unmarshaled]).not_to be_nil, 'no 2xx unmarshal found'
        expect(m[:payload_field]).not_to be_nil, 'no payload keyword found'
        klass = Object.const_get("FastpixClient::#{m[:constructed]}")
        field = klass.fields.find { |f| f.name == m[:payload_field].to_sym }
        expect(field).not_to be_nil, "#{m[:constructed]} has no field #{m[:payload_field]}"
        inner = field.type.is_a?(Crystalline::Nilable) ? field.type.inner_type : field.type
        expect(inner).to eq(Object.const_get("FastpixClient::#{m[:unmarshaled]}"))
      end
    end
  end
end
