
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GetPlaybackIdData
        extend T::Sig
        include Crystalline::MetadataFields

        # The unique identifier for the playback ID.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('id') } }
        # Access policy for media content
        field :access_policy, Crystalline::Nilable.new(Models::Components::AccessPolicy), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('accessPolicy'), 'decoder': Utils.enum_from_string(Models::Components::AccessPolicy, true) } }

        sig { params(id: T.nilable(::String), access_policy: T.nilable(Models::Components::AccessPolicy)).void }
        def initialize(id: nil, access_policy: nil)
          @id = id
          @access_policy = access_policy
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @access_policy == other.access_policy
          true
        end
      end
    end
  end
end
