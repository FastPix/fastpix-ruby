# frozen_string_literal: true

require 'spec_helper'
require 'json'
require 'fastpixapi'

# Offline wire-format contracts for the models touched by the live
# restrictions / recording / numeric duration API sync.
RSpec.describe 'model contracts' do
  C = FastpixClient::Models::Components
  Op = FastpixClient::Models::Operations

  describe 'media duration' do
    DURATION_MODELS = [C::GetMediaDetailResponse, C::GetAllMediaResponse, C::Media, C::UpdateMedia,
                       C::SourceAccessMedia, C::LiveMediaClips, C::MediaClipResponseData,
                       C::PlaylistByIdResponseMediaListItem].freeze

    DURATION_MODELS.each do |klass|
      describe klass.name.split('::').last do
        it 'parses fractional seconds as Float' do
          d = Crystalline.unmarshal_json({ 'duration' => 145.821315 }, klass).duration
          expect(d).to be_a(Float)
          expect(d).to eq(145.821315)
        end

        it 'parses integer seconds as Float' do
          expect(Crystalline.unmarshal_json({ 'duration' => 10 }, klass).duration).to eq(10.0)
        end

        it 'is nil when absent' do
          expect(Crystalline.unmarshal_json({}, klass).duration).to be_nil
        end

        it 'rejects the legacy clock string' do
          expect { Crystalline.unmarshal_json({ 'duration' => '00:02:25' }, klass) }.to raise_error(TypeError)
        end

        it 'serializes as a JSON number' do
          expect(JSON.parse(klass.new(duration: 10.5).to_json)['duration']).to eq(10.5)
        end
      end
    end
  end

  describe 'enableRecording' do
    it 'defaults to true' do
      expect(C::InputMediaSettings.new.enable_recording).to be(true)
    end

    it 'round-trips false' do
      expect(Crystalline.unmarshal_json({ 'enableRecording' => false }, C::InputMediaSettings).enable_recording).to be(false)
      expect(JSON.parse(C::InputMediaSettings.new(enable_recording: false).to_json)['enableRecording']).to be(false)
    end

    it 'is carried by a serialized CreateLiveStreamRequest' do
      req = C::CreateLiveStreamRequest.new(playback_settings: C::PlaybackSettings.new,
                                           input_media_settings: C::InputMediaSettings.new)
      expect(JSON.parse(req.to_json).dig('inputMediaSettings', 'enableRecording')).to be(true)
    end
  end

  describe 'accessRestrictions' do
    let(:example) do
      { 'accessPolicy' => 'public',
        'accessRestrictions' => {
          'domains' => { 'defaultPolicy' => 'deny', 'allow' => ['example.com'], 'deny' => [] },
          'userAgents' => { 'defaultPolicy' => 'allow', 'allow' => [], 'deny' => [] }
        } }
    end

    [C::PlaybackIdRequest, C::PlaybackSettings, C::PlaybackIdSuccessResponseData, C::PlaybackIdResponse].each do |klass|
      describe klass.name.split('::').last do
        it 'parses the domains/userAgents example' do
          r = Crystalline.unmarshal_json(example, klass).access_restrictions
          expect(r.domains.default_policy).to eq(C::PolicyAction::DENY)
          expect(r.domains.allow).to eq(['example.com'])
          expect(r.user_agents.default_policy).to eq(C::PolicyAction::ALLOW)
        end

        it 'serializes with wire aliases' do
          json = JSON.parse(Crystalline.unmarshal_json(example, klass).to_json)
          expect(json.dig('accessRestrictions', 'userAgents', 'defaultPolicy')).to eq('allow')
          expect(json.dig('accessRestrictions', 'domains', 'defaultPolicy')).to eq('deny')
        end

        it 'is nil when absent and omitted from JSON' do
          obj = Crystalline.unmarshal_json({ 'accessPolicy' => 'public' }, klass)
          expect(obj.access_restrictions).to be_nil
          expect(JSON.parse(obj.to_json)).not_to have_key('accessRestrictions')
        end
      end
    end

    it 'parses PlaybackIdSuccessResponse with and without data.accessRestrictions' do
      with = Crystalline.unmarshal_json({ 'success' => true, 'data' => example.merge('id' => 'pid') }, C::PlaybackIdSuccessResponse)
      expect(with.data.access_restrictions.domains.allow).to eq(['example.com'])
      without = Crystalline.unmarshal_json({ 'success' => true, 'data' => { 'id' => 'pid', 'accessPolicy' => 'public' } }, C::PlaybackIdSuccessResponse)
      expect(without.data.access_restrictions).to be_nil
    end

    it 'is exposed on live stream response playbackIds items' do
      dto = Crystalline.unmarshal_json({ 'playbackIds' => [example.merge('id' => 'pid')] }, C::CreateLiveStreamResponseDTO)
      expect(dto.playback_ids.first.access_restrictions.domains.default_policy).to eq(C::PolicyAction::DENY)
    end
  end

  describe 'live restriction operation models' do
    { domain: [Op::UpdateLiveStreamDomainRestrictionsRequestBody, Op::UpdateLiveStreamDomainRestrictionsDefaultPolicy,
               Op::UpdateLiveStreamDomainRestrictionsRequest, Op::UpdateLiveStreamDomainRestrictionsResponseBody],
      user_agent: [Op::UpdateLiveStreamUserAgentRestrictionsRequestBody, Op::UpdateLiveStreamUserAgentRestrictionsDefaultPolicy,
                   Op::UpdateLiveStreamUserAgentRestrictionsRequest, Op::UpdateLiveStreamUserAgentRestrictionsResponseBody] }.each do |kind, (body_k, policy_k, req_k, resp_k)|
      describe kind.to_s do
        it 'serializes a flat body' do
          json = JSON.parse(body_k.new(default_policy: policy_k::DENY, allow: ['example.com'], deny: []).to_json)
          expect(json).to eq({ 'defaultPolicy' => 'deny', 'allow' => ['example.com'], 'deny' => [] })
        end

        it 'defaults defaultPolicy to allow and omits unset lists' do
          expect(JSON.parse(body_k.new.to_json)).to eq({ 'defaultPolicy' => 'allow' })
        end

        it 'carries streamId and playbackId, not mediaId' do
          req = req_k.new(stream_id: 's', playback_id: 'p', body: body_k.new)
          expect(req.stream_id).to eq('s')
          expect(req).not_to respond_to(:media_id)
        end

        it 'parses the response envelope' do
          r = Crystalline.unmarshal_json({ 'success' => true, 'data' => { 'defaultPolicy' => 'allow', 'allow' => ['a.com'], 'deny' => ['b.io'] } }, resp_k)
          expect(r.success).to be(true)
          expect(r.data.default_policy).to eq('allow')
          expect(r.data.deny).to eq(['b.io'])
        end
      end
    end
  end

  describe 'resource surface' do
    it 'exposes the live and on-demand restriction methods' do
      expect(FastpixClient::LivePlayback.instance_methods(false)).to include(:update_live_stream_domain_restrictions, :update_live_stream_user_agent_restrictions)
      expect(FastpixClient::Playback.instance_methods(false)).to include(:update_domain_restrictions, :update_user_agent_restrictions)
    end
  end
end
