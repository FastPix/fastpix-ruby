
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class SimulcastUpdateRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # When the value is set to false, the simulcast will be disabled for the given stream.
        field :is_enabled, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('isEnabled') } }
        # You can search for videos with specific key value pairs using metadata, when you tag a video in "key":"value"s pairs. Dynamic Metadata allows you to define a key that allows any value pair. You can have maximum of 255 characters and upto 10 entries are allowed.
        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('metadata') } }

        sig { params(is_enabled: T.nilable(T::Boolean), metadata: T.nilable(T::Hash[Symbol, ::String])).void }
        def initialize(is_enabled: nil, metadata: nil)
          @is_enabled = is_enabled
          @metadata = metadata
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @is_enabled == other.is_enabled
          return false unless @metadata == other.metadata
          true
        end
      end
    end
  end
end
