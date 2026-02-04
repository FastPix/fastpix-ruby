# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class Custom1
        extend T::Sig
        include Crystalline::MetadataFields

        # Unique identifier for a custom dimension used to categorize or segment analytics data (for example, custom_1).
        # 
        field :dimension_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('dimensionName') } }
        # A user-friendly display label that represents the corresponding custom dimension in analytics dashboards and reports; users can assign a specific name based on their tracking needs.
        # 
        field :display_name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('displayName') } }
        # Allows assigning user-friendly data values such as email addresses, identifiers, or other meaningful information.
        # 
        field :value, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('value') } }

        sig { params(dimension_name: T.nilable(::String), display_name: T.nilable(::String), value: T.nilable(::String)).void }
        def initialize(dimension_name: nil, display_name: nil, value: nil)
          @dimension_name = dimension_name
          @display_name = display_name
          @value = value
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @dimension_name == other.dimension_name
          return false unless @display_name == other.display_name
          return false unless @value == other.value
          true
        end
      end
    end
  end
end
