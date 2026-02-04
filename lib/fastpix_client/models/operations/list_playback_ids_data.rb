# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class ListPlaybackIdsData
        extend T::Sig
        include Crystalline::MetadataFields

        # Unique identifier of the playback ID.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('id') } }
        # The access policy set for the playback ID.
        field :access_policy, Crystalline::Nilable.new(Models::Operations::ListPlaybackIdsAccessPolicy), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessPolicy'), 'decoder': Utils.enum_from_string(Models::Operations::ListPlaybackIdsAccessPolicy, true) } }
        # Restrictions applied to this playback ID.
        field :access_restrictions, Crystalline::Nilable.new(Models::Operations::ListPlaybackIdsAccessRestrictions), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('accessRestrictions') } }

        sig { params(id: T.nilable(::String), access_policy: T.nilable(Models::Operations::ListPlaybackIdsAccessPolicy), access_restrictions: T.nilable(Models::Operations::ListPlaybackIdsAccessRestrictions)).void }
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
