# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Get the list of Views
      class ListByTopContentResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Shows the request status. Returns true for success and false for failure.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success') } }
        # Displays the result of the request.
        field :data, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::ViewsByTopContentDetails)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data') } }
        # The timespan from and to details displayed in the form of unix epoch timestamps.
        # 
        field :timespan, Crystalline::Nilable.new(Crystalline::Array.new(::Integer)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('timespan') } }

        sig { params(success: T.nilable(T::Boolean), data: T.nilable(T::Array[Models::Components::ViewsByTopContentDetails]), timespan: T.nilable(T::Array[::Integer])).void }
        def initialize(success: nil, data: nil, timespan: nil)
          @success = success
          @data = data
          @timespan = timespan
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          return false unless @data == other.data
          return false unless @timespan == other.timespan
          true
        end
      end
    end
  end
end
