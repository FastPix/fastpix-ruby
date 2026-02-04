# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class UpdateDomainRestrictionsRequestBody
        extend T::Sig
        include Crystalline::MetadataFields

        # List of domains explicitly allowed to play the media.
        field :allow, Crystalline::Nilable.new(Crystalline::Array.new(::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('allow') } }
        # List of domains explicitly denied from accessing the media.
        field :deny, Crystalline::Nilable.new(Crystalline::Array.new(::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('deny') } }
        # Specify the fallback behavior for domains that are not listed in the `allow` or `deny` lists.
        field :default_policy, Crystalline::Nilable.new(Models::Operations::UpdateDomainRestrictionsDefaultPolicy), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('defaultPolicy'), 'decoder': Utils.enum_from_string(Models::Operations::UpdateDomainRestrictionsDefaultPolicy, true) } }

        sig { params(allow: T.nilable(T::Array[::String]), deny: T.nilable(T::Array[::String]), default_policy: T.nilable(Models::Operations::UpdateDomainRestrictionsDefaultPolicy)).void }
        def initialize(allow: nil, deny: nil, default_policy: Models::Operations::UpdateDomainRestrictionsDefaultPolicy::ALLOW)
          @allow = allow
          @deny = deny
          @default_policy = default_policy
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @allow == other.allow
          return false unless @deny == other.deny
          return false unless @default_policy == other.default_policy
          true
        end
      end
    end
  end
end
