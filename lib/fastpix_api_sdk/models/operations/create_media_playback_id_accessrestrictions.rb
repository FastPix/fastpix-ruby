
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class CreateMediaPlaybackIdAccessRestrictions
        extend T::Sig
        include Crystalline::MetadataFields

        # Restrictions based on the originating domain of a request
        field :domains, Crystalline::Nilable.new(Models::Components::DomainRestrictions), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('domains') } }
        # Restrictions based on the user agent
        field :user_agents, Crystalline::Nilable.new(Models::Components::UserAgentRestrictions), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('userAgents') } }

        sig { params(domains: T.nilable(Models::Components::DomainRestrictions), user_agents: T.nilable(Models::Components::UserAgentRestrictions)).void }
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
