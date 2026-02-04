# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class BrowserNameDimensiondetails
        extend T::Sig
        include Crystalline::MetadataFields

        # The specific metric value calculated based on the applied filters.
        field :value, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('value') } }
        # The count of unique viewers who interacted with the content.
        field :unique_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('uniqueCount') } }
        # The count of viewers.
        field :count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('count') } }

        sig { params(value: T.nilable(::String), unique_count: T.nilable(::Integer), count: T.nilable(::Integer)).void }
        def initialize(value: nil, unique_count: nil, count: nil)
          @value = value
          @unique_count = unique_count
          @count = count
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @value == other.value
          return false unless @unique_count == other.unique_count
          return false unless @count == other.count
          true
        end
      end
    end
  end
end
