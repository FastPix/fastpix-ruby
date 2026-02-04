# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class CreateMediaRequestAccessRestrictions
        extend T::Sig
        include Crystalline::MetadataFields


        field :domains, Crystalline::Nilable.new(Models::Components::CreateMediaRequestDomains), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('domains') } }

        field :user_agents, Crystalline::Nilable.new(Models::Components::CreateMediaRequestUserAgents), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('userAgents') } }

        sig { params(domains: T.nilable(Models::Components::CreateMediaRequestDomains), user_agents: T.nilable(Models::Components::CreateMediaRequestUserAgents)).void }
        def initialize(domains: nil, user_agents: nil)
          @domains = domains
          @user_agents = user_agents
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @domains == other.domains
          return false unless @user_agents == other.user_agents
          true
        end
      end
    end
  end
end
