# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class UpdateMediaModerationRequestBody
        extend T::Sig
        include Crystalline::MetadataFields


        field :moderation, Crystalline::Nilable.new(Models::Operations::UpdateMediaModerationModeration), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('moderation') } }

        sig { params(moderation: T.nilable(Models::Operations::UpdateMediaModerationModeration)).void }
        def initialize(moderation: nil)
          @moderation = moderation
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @moderation == other.moderation
          true
        end
      end
    end
  end
end
