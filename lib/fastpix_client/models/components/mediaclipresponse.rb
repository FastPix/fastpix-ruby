# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class MediaClipResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # Shows the request status. Returns true for success and false for failure.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success') } }

        field :data, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::MediaClipResponseData)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data') } }

        field :pagination, Crystalline::Nilable.new(Models::Components::MediaClipResponsePagination), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('pagination') } }

        sig { params(success: T.nilable(T::Boolean), data: T.nilable(T::Array[Models::Components::MediaClipResponseData]), pagination: T.nilable(Models::Components::MediaClipResponsePagination)).void }
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
