
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # Get the list of Views
      class ListVideoViewsResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # It demonstrates whether the request is successful or not.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('success') } }
        # Displays the result of the request.
        field :data, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::ViewsList)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('data') } }
        # Pagination organizes content into pages for better readability and navigation.
        field :pagination, Crystalline::Nilable.new(Models::Components::DataPagination), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('pagination') } }
        # The timeframe from and to details displayed in the form of unix epoch timestamps.
        # 
        field :timespan, Crystalline::Nilable.new(Crystalline::Array.new(::Integer)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('timespan') } }

        sig { params(success: T.nilable(T::Boolean), data: T.nilable(T::Array[Models::Components::ViewsList]), pagination: T.nilable(Models::Components::DataPagination), timespan: T.nilable(T::Array[::Integer])).void }
        def initialize(success: nil, data: nil, pagination: nil, timespan: nil)
          @success = success
          @data = data
          @pagination = pagination
          @timespan = timespan
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          return false unless @data == other.data
          return false unless @pagination == other.pagination
          return false unless @timespan == other.timespan
          true
        end
      end
    end
  end
end
