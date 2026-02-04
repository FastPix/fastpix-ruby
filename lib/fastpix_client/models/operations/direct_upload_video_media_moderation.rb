# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class DirectUploadVideoMediaModeration
        extend T::Sig
        include Crystalline::MetadataFields

        # Defines the type of input. Possible values include video, audio, av.
        # 
        field :type, Crystalline::Nilable.new(Models::Operations::Type), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('type'), 'decoder': Utils.enum_from_string(Models::Operations::Type, true) } }

        sig { params(type: T.nilable(Models::Operations::Type)).void }
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
