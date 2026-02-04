# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class GetAllPlaylistsResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # Shows the request status. Returns true for success and false for failure.
        field :success, Crystalline::Boolean.new, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success'), required: true } }

        field :data, Crystalline::Array.new(Models::Components::PlaylistItem), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data'), required: true } }
        # Pagination organizes content into pages for better readability and navigation.
        field :pagination, Crystalline::Nilable.new(Models::Components::Pagination), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('pagination') } }

        sig { params(success: T::Boolean, data: T::Array[Models::Components::PlaylistItem], pagination: T.nilable(Models::Components::Pagination)).void }
        def initialize(success:, data:, pagination: nil)
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
