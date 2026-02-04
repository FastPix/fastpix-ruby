# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class SimulcastUpdateRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # You can search for videos with specific key-value pairs using metadata, when you tag a video in "key":"value" pairs.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }
        # When set to false, the simulcast is disabled for the specified stream.
        field :is_enabled, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('isEnabled') } }

        sig { params(metadata: T.nilable(T::Hash[Symbol, ::String]), is_enabled: T.nilable(T::Boolean)).void }
        def initialize(metadata: nil, is_enabled: true)
          @metadata = metadata
          @is_enabled = is_enabled
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @metadata == other.metadata
          return false unless @is_enabled == other.is_enabled
          true
        end
      end
    end
  end
end
