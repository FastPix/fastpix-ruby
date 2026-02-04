# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Media details updated successfully with the named entity extraction feature enabled or disabled
      class UpdateMediaNamedEntitiesResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Indicates if the request was successful or not.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('success') } }

        field :data, Crystalline::Nilable.new(Models::Components::NamedEntitiesResponse), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data') } }

        sig { params(success: T.nilable(T::Boolean), data: T.nilable(Models::Components::NamedEntitiesResponse)).void }
        def initialize(success: nil, data: nil)
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
