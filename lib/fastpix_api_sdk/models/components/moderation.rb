
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class Moderation
        extend T::Sig
        include Crystalline::MetadataFields

        # Type of media content
        field :type, Models::Components::MediaType, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('type'), required: true, 'decoder': Utils.enum_from_string(Models::Components::MediaType, false) } }

        sig { params(type: Models::Components::MediaType).void }
        def initialize(type:)
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
