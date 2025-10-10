
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class CreateMediaRequestDomains
        extend T::Sig
        include Crystalline::MetadataFields

        # Policy action type
        field :default_policy, Crystalline::Nilable.new(Models::Components::PolicyAction), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('defaultPolicy'), 'decoder': Utils.enum_from_string(Models::Components::PolicyAction, true) } }
        # A list of domain names or patterns that are explicitly allowed access. 
        # This list is only effective when the `defaultPolicy` is set to `deny`.
        # 
        field :allow, Crystalline::Nilable.new(Crystalline::Array.new(::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('allow') } }
        # A list of domain names or patterns that are explicitly denied access. 
        # This list is only effective when the `defaultPolicy` is set to `allow`.
        # 
        field :deny, Crystalline::Nilable.new(Crystalline::Array.new(::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('deny') } }

        sig { params(default_policy: T.nilable(Models::Components::PolicyAction), allow: T.nilable(T::Array[::String]), deny: T.nilable(T::Array[::String])).void }
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
