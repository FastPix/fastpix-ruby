# frozen_string_literal: true

require 'spec_helper'
require 'json'
require 'fastpixapi'

RSpec.describe FastpixClient::LivePlayback do
  Op = FastpixClient::Models::Operations
  BASE = 'https://api.example.test/v1'

  let(:sdk) do
    FastpixClient::Fastpixapi.new(
      security: FastpixClient::Models::Components::Security.new(username: 'u', password: 'p'),
      server_url: BASE
    )
  end
  let(:ok_body) { { success: true, data: { defaultPolicy: 'deny', allow: ['example.com'], deny: [] } }.to_json }

  before { WebMock.disable_net_connect! }
  after { WebMock.allow_net_connect! }

  it 'PATCHes the domains path with a flat JSON body' do
    stub = stub_request(:patch, "#{BASE}/live/streams/stream-1/playback-ids/pb-1/domains")
           .with(headers: { 'Content-Type' => 'application/json' },
                 body: { 'defaultPolicy' => 'deny', 'allow' => ['example.com'], 'deny' => [] })
           .to_return(status: 200, body: ok_body, headers: { 'Content-Type' => 'application/json' })
    res = sdk.live_playback.update_live_stream_domain_restrictions(
      stream_id: 'stream-1', playback_id: 'pb-1',
      body: Op::UpdateLiveStreamDomainRestrictionsRequestBody.new(
        default_policy: Op::UpdateLiveStreamDomainRestrictionsDefaultPolicy::DENY, allow: ['example.com'], deny: []
      )
    )
    expect(stub).to have_been_requested
    expect(res.status_code).to eq(200)
    expect(res.object.data.allow).to eq(['example.com'])
  end

  it 'PATCHes the user-agents path with a flat JSON body' do
    stub = stub_request(:patch, "#{BASE}/live/streams/stream-1/playback-ids/pb-1/user-agents")
           .with(headers: { 'Content-Type' => 'application/json' },
                 body: { 'defaultPolicy' => 'allow', 'deny' => ['PostmanRuntime/7.29.0'] })
           .to_return(status: 200, body: ok_body, headers: { 'Content-Type' => 'application/json' })
    res = sdk.live_playback.update_live_stream_user_agent_restrictions(
      stream_id: 'stream-1', playback_id: 'pb-1',
      body: Op::UpdateLiveStreamUserAgentRestrictionsRequestBody.new(deny: ['PostmanRuntime/7.29.0'])
    )
    expect(stub).to have_been_requested
    expect(res.object.success).to be(true)
  end

  it 'raises APIError on 4XX' do
    stub_request(:patch, "#{BASE}/live/streams/stream-1/playback-ids/missing/domains")
      .to_return(status: 404, body: '{"success":false,"error":{"message":"not found"}}', headers: { 'Content-Type' => 'application/json' })
    expect do
      sdk.live_playback.update_live_stream_domain_restrictions(
        stream_id: 'stream-1', playback_id: 'missing', body: Op::UpdateLiveStreamDomainRestrictionsRequestBody.new
      )
    end.to raise_error(FastpixClient::Models::Errors::APIError) { |e|
      expect(e.status_code).to eq(404)
      expect(e.body).to include('not found')
    }
  end
end
