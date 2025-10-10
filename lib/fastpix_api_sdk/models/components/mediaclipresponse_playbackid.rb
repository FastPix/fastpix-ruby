
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class MediaClipResponsePlaybackId
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier for playback.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('id') } }
        # The access policy of the playback.
        field :access_policy, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('accessPolicy') } }

        field :access_restrictions, Crystalline::Nilable.new(Models::Components::MediaClipResponseAccessRestrictions), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('accessRestrictions') } }

        sig { params(id: T.nilable(::String), access_policy: T.nilable(::String), access_restrictions: T.nilable(Models::Components::MediaClipResponseAccessRestrictions)).void }
        def initialize(id: nil, access_policy: nil, access_restrictions: nil)
          @id = id
          @access_policy = access_policy
          @access_restrictions = access_restrictions
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @access_policy == other.access_policy
          return false unless @access_restrictions == other.access_restrictions
          true
        end
      end
    end
  end
end
