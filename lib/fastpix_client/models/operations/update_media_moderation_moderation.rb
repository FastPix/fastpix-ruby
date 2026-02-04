# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class UpdateMediaModerationModeration
        extend T::Sig
        include Crystalline::MetadataFields

        # Type of media content
        field :type, Crystalline::Nilable.new(Models::Components::MediaType), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type'), 'decoder': Utils.enum_from_string(Models::Components::MediaType, true) } }

        sig { params(type: T.nilable(Models::Components::MediaType)).void }
        def initialize(type: Models::Components::MediaType::AUDIO)
          @type = type
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @type == other.type
          true
        end
      end
    end
  end
end
