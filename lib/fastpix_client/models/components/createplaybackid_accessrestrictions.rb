# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Controls access based on domains and user agents. Defines a default policy (either "allow" or "deny") and provides lists for explicitly allowed or denied domains and user agents.
      class CreatePlaybackIdAccessRestrictions
        extend T::Sig
        include Crystalline::MetadataFields

        # Restrictions based on the originating domain of a request (for example, whether requests from certain websites should be allowed or blocked).
        field :domains, Crystalline::Nilable.new(Models::Components::CreatePlaybackIdDomains), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('domains') } }
        # Restrictions based on the user agent (which is typically a string sent by browsers or bots identifying themselves).
        field :user_agents, Crystalline::Nilable.new(Models::Components::CreatePlaybackIdUserAgents), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('userAgents') } }

        sig { params(domains: T.nilable(Models::Components::CreatePlaybackIdDomains), user_agents: T.nilable(Models::Components::CreatePlaybackIdUserAgents)).void }
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
