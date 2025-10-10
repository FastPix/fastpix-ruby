
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class ModerationResponse
        extend T::Sig
        include Crystalline::MetadataFields


        field :media_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mediaId') } }

        field :is_moderation_enabled, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('isModerationEnabled') } }

        sig { params(media_id: T.nilable(::String), is_moderation_enabled: T.nilable(T::Boolean)).void }
        def initialize(media_id: nil, is_moderation_enabled: nil)
          @media_id = media_id
          @is_moderation_enabled = is_moderation_enabled
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @media_id == other.media_id
          return false unless @is_moderation_enabled == other.is_moderation_enabled
          true
        end
      end
    end
  end
end
