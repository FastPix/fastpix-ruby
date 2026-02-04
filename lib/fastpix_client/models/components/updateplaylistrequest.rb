# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class UpdatePlaylistRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # New name to the playlist.
        field :name, ::String, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('name'), required: true } }
        # Updated description to the playlist.
        field :description, ::String, { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('description'), required: true } }

        sig { params(name: ::String, description: ::String).void }
        def initialize(name:, description:)
          @name = name
          @description = description
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @name == other.name
          return false unless @description == other.description
          true
        end
      end
    end
  end
end
