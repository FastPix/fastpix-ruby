
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class MediaClipResponse
        extend T::Sig
        include Crystalline::MetadataFields


        field :success, Crystalline::Boolean.new, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('success'), required: true } }

        field :data, Crystalline::Array.new(Models::Components::MediaClipResponseData), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('data'), required: true } }

        field :pagination, Models::Components::MediaClipResponsePagination, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('pagination'), required: true } }

        sig { params(success: T::Boolean, data: T::Array[Models::Components::MediaClipResponseData], pagination: Models::Components::MediaClipResponsePagination).void }
        def initialize(success:, data:, pagination:)
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
