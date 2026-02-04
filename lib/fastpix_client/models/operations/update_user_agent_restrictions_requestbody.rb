# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class UpdateUserAgentRestrictionsRequestBody
        extend T::Sig
        include Crystalline::MetadataFields

        # List of user-agent substrings explicitly allowed.
        field :allow, Crystalline::Nilable.new(Crystalline::Array.new(::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('allow') } }
        # List of user-agent substrings explicitly denied.
        field :deny, Crystalline::Nilable.new(Crystalline::Array.new(::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('deny') } }
        # The default behavior when a user-agent is not listed in `allow` or `deny`.
        field :default_policy, Crystalline::Nilable.new(Models::Operations::UpdateUserAgentRestrictionsDefaultPolicy), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('defaultPolicy'), 'decoder': Utils.enum_from_string(Models::Operations::UpdateUserAgentRestrictionsDefaultPolicy, true) } }

        sig { params(allow: T.nilable(T::Array[::String]), deny: T.nilable(T::Array[::String]), default_policy: T.nilable(Models::Operations::UpdateUserAgentRestrictionsDefaultPolicy)).void }
        def initialize(allow: nil, deny: nil, default_policy: Models::Operations::UpdateUserAgentRestrictionsDefaultPolicy::ALLOW)
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
