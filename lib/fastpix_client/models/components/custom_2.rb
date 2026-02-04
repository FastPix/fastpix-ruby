# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # User defined metadata. Only accessible once it is enabled in the organization settings.
      # 
      class Custom2
        extend T::Sig
        include Crystalline::MetadataFields

        # A list of custom dimension objects.
        field :custom, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::Custom1)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('Custom') } }

        sig { params(custom: T.nilable(T::Array[Models::Components::Custom1])).void }
        def initialize(custom: nil)
          @custom = custom
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @custom == other.custom
          true
        end
      end
    end
  end
end
