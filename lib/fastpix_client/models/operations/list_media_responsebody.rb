# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # List of video media
      class ListMediaResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Demonstrates whether the request is successful or not.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success') } }
        # Displays the result of the request.
        field :data, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::GetAllMediaResponse)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data') } }
        # Pagination organizes content into pages for better readability and navigation.
        field :pagination, Crystalline::Nilable.new(Models::Components::Pagination), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('pagination') } }

        sig { params(success: T.nilable(T::Boolean), data: T.nilable(T::Array[Models::Components::GetAllMediaResponse]), pagination: T.nilable(Models::Components::Pagination)).void }
        def initialize(success: nil, data: nil, pagination: nil)
          @success = success
          @data = data
          @pagination = pagination
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          return false unless @data == other.data
          return false unless @pagination == other.pagination
          true
        end
      end
    end
  end
end
