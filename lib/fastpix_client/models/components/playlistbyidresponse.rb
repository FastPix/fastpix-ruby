# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class PlaylistByIdResponse
        extend T::Sig
        include Crystalline::MetadataFields

        # Shows the request status. Returns true for success and false for failure.
        field :success, Crystalline::Boolean.new, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success'), required: true } }

        field :data, Crystalline::Union.new(Models::Components::PlaylistByIdResponseDataManual, Models::Components::PlaylistByIdResponseDataSmart), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data'), required: true }, 'discriminator': 'type', 'discriminator_mapping': { 'manual' => Models::Components::PlaylistByIdResponseDataManual, 'smart' => Models::Components::PlaylistByIdResponseDataSmart } }

        sig { params(success: T::Boolean, data: T.any(Models::Components::PlaylistByIdResponseDataManual, Models::Components::PlaylistByIdResponseDataSmart)).void }
        def initialize(success:, data:)
          @success = success
          @data = data
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @success == other.success
          return false unless @data == other.data
          true
        end
      end
    end
  end
end
