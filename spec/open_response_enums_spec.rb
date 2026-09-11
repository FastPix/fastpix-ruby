# frozen_string_literal: true

# Run with Ruby 3.2 (the default `bundle` may resolve to system Ruby 2.6):
#   export PATH="/opt/homebrew/opt/ruby@3.2/bin:$PATH"
#   RUBYOPT=-W0 bundle exec rspec spec/open_response_enums_spec.rb

require 'spec_helper'
require 'json'
require 'fastpixapi'

# Unknown enum values from the server should survive as strings; known ones stay
# typed.
RSpec.describe 'open response enums' do
  C = FastpixClient::Models::Components
  Op = FastpixClient::Models::Operations
  U = FastpixClient::Utils

  UNKNOWN = 'zzz-not-a-real-enum-value'

  # every enum field routes through this one decoder
  describe 'Utils.enum_from_string' do
    it 'preserves an unknown value as the raw string' do
      expect(U.enum_from_string(C::MediaSourceResolution, true).call('800')).to eq('800')
    end

    it 'still resolves a known value to the typed member' do
      value = U.enum_from_string(C::MediaSourceResolution, true).call('1080p')
      expect(value).to be_a(C::MediaSourceResolution)
      expect(value.serialize).to eq('1080p')
    end

    it 'returns nil for an absent optional value' do
      expect(U.enum_from_string(C::MediaSourceResolution, true).call(nil)).to be_nil
    end

    it 'preserves an unknown value even for a required (non-optional) field' do
      expect(U.enum_from_string(C::PlaylistOrder, false).call('weird')).to eq('weird')
    end
  end

  # Response models with enum fields. Each optional field is checked through the
  # real unmarshal path below, so new enum fields on these models are covered too.
  # Add a model here if it starts coming back in a 2xx body with an enum field.
  RESPONSE_ENUM_MODELS = [
    C::Media, C::GetAllMediaResponse, C::GetMediaDetailResponse, C::UpdateMedia,
    C::SourceAccessMedia, C::LiveMediaClips, C::CreateMediaResponse, C::MediaClipResponseData,
    C::AddTrackResponse, C::AudioTrack, C::SubtitleTrack, C::GenerateTrackResponse,
    C::UpdateTrackResponse, C::CreatePlaybackId, C::CreatePlaybackIdDomains,
    C::CreatePlaybackIdUserAgents, C::PlaybackId, C::PlaybackIdDomains, C::PlaybackIdUserAgents,
    C::UnusedUploadsPlaybackId, C::UnusedUploadsPlaybackIdDomains, C::UnusedUploadsPlaybackIdUserAgents,
    C::DirectUpload, C::DirectUploadResponse, C::UnusedDirectUpload, C::UnusedDirectUploadResponse,
    C::PlaylistItem, Op::GetPlaybackIdData, Op::GetPlaybackIdDomains, Op::GetPlaybackIdUserAgents,
    Op::ListPlaybackIdsData, Op::ListPlaybackIdsDomains, Op::ListPlaybackIdsUserAgents
  ].freeze

  def self.optional_enum_fields(klass)
    klass.fields.select do |field|
      next false unless Crystalline::Utils.nilable?(field.type)

      inner = Crystalline::Utils.nilable_of(field.type)
      inner.is_a?(Class) && inner < T::Enum
    end
  end

  RESPONSE_ENUM_MODELS.each do |klass|
    describe klass.name.split('::').last do
      optional_enum_fields(klass).each do |field|
        wire = field.metadata.dig(:format_json, :letter_case).call

        it "preserves an unknown #{wire} as a String" do
          obj = Crystalline.unmarshal_json({ wire => UNKNOWN }, klass)
          expect(obj.send(field.name)).to eq(UNKNOWN)
        end
      end
    end
  end

  # known values stay typed
  MEDIA_MODELS = [C::Media, C::GetAllMediaResponse, C::GetMediaDetailResponse,
                  C::UpdateMedia, C::SourceAccessMedia, C::LiveMediaClips].freeze

  MEDIA_MODELS.each do |klass|
    describe "#{klass.name.split('::').last} resolution" do
      it 'decodes a known sourceResolution to the typed member' do
        obj = Crystalline.unmarshal_json({ 'sourceResolution' => '1080p' }, klass)
        expect(obj.source_resolution).to respond_to(:serialize)
        expect(obj.source_resolution.serialize).to eq('1080p')
      end

      it 'preserves an unknown sourceResolution as a String' do
        expect(Crystalline.unmarshal_json({ 'sourceResolution' => '1920' }, klass).source_resolution).to eq('1920')
      end
    end
  end

  it 'does not fail sibling fields when one enum value is unknown' do
    obj = Crystalline.unmarshal_json({ 'id' => 'm1', 'sourceResolution' => UNKNOWN, 'status' => 'Ready' }, C::Media)
    expect(obj.source_resolution).to eq(UNKNOWN)
    expect(obj.status).to be_a(C::MediaStatus)
    expect(obj.id).to eq('m1')
  end

  # required enum fields (playlist discriminators) must tolerate unknowns too
  describe 'PlaylistByIdResponseDataSmart (required enums)' do
    it 'preserves unknown type and playOrder as Strings' do
      obj = Crystalline.unmarshal_json(
        { 'type' => UNKNOWN, 'playOrder' => 'weird', 'metadata' => {} },
        C::PlaylistByIdResponseDataSmart
      )
      expect(obj.type).to eq(UNKNOWN)
      expect(obj.play_order).to eq('weird')
    end

    it 'still decodes a known type to the typed member' do
      obj = Crystalline.unmarshal_json(
        { 'type' => 'smart', 'playOrder' => 'createdDate ASC', 'metadata' => {} },
        C::PlaylistByIdResponseDataSmart
      )
      expect(obj.type).to respond_to(:serialize)
    end
  end

  describe 'PlaylistByIdResponseDataManual (required enum)' do
    it 'preserves an unknown type as a String' do
      obj = Crystalline.unmarshal_json({ 'type' => UNKNOWN }, C::PlaylistByIdResponseDataManual)
      expect(obj.type).to eq(UNKNOWN)
    end
  end
end
