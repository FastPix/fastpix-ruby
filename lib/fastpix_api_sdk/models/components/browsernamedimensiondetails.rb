
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class BrowserNameDimensiondetails
        extend T::Sig
        include Crystalline::MetadataFields

        # The specific metric value calculated based on the applied filters.
        field :value, ::String, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('value'), required: true } }
        # The count of viewers.
        field :count, ::Integer, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('count'), required: true } }
        # The count of unique viewers who interacted with the content.
        field :unique_count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('uniqueCount') } }

        sig { params(value: ::String, count: ::Integer, unique_count: T.nilable(::Integer)).void }
        def initialize(value:, count:, unique_count: nil)
          @value = value
          @count = count
          @unique_count = unique_count
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @value == other.value
          return false unless @count == other.count
          return false unless @unique_count == other.unique_count
          true
        end
      end
    end
  end
end
