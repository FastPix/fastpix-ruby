# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class GetPlaybackIdDomains
        extend T::Sig
        include Crystalline::MetadataFields


        field :default_policy, Crystalline::Nilable.new(Models::Operations::GetPlaybackIdDomainsDefaultPolicy), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('defaultPolicy'), 'decoder': Utils.enum_from_string(Models::Operations::GetPlaybackIdDomainsDefaultPolicy, true) } }

        field :allow, Crystalline::Nilable.new(Crystalline::Array.new(::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('allow') } }

        field :deny, Crystalline::Nilable.new(Crystalline::Array.new(::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('deny') } }

        sig { params(default_policy: T.nilable(Models::Operations::GetPlaybackIdDomainsDefaultPolicy), allow: T.nilable(T::Array[::String]), deny: T.nilable(T::Array[::String])).void }
        def initialize(default_policy: nil, allow: nil, deny: nil)
          @default_policy = default_policy
          @allow = allow
          @deny = deny
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @default_policy == other.default_policy
          return false unless @allow == other.allow
          return false unless @deny == other.deny
          true
        end
      end
    end
  end
end
