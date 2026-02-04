# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class UpdateMediaChaptersRequestBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Enable or disable the chapters feature for the media. Set to `true` to enable chapters or `false` to disable.
        # 
        field :chapters, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('chapters') } }

        sig { params(chapters: T.nilable(T::Boolean)).void }
        def initialize(chapters: true)
          @chapters = chapters
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @chapters == other.chapters
          true
        end
      end
    end
  end
end
