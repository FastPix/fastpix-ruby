
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class DirectUploadVideoMediaModeration
        extend T::Sig
        include Crystalline::MetadataFields

        # Type of media content
        field :type, Crystalline::Nilable.new(Models::Components::MediaType), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('type'), 'decoder': Utils.enum_from_string(Models::Components::MediaType, true) } }

        sig { params(type: T.nilable(Models::Components::MediaType)).void }
        def initialize(type: nil)
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
