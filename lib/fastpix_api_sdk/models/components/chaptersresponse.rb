
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class ChaptersResponse
        extend T::Sig
        include Crystalline::MetadataFields


        field :media_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mediaId') } }

        field :is_generated_chapters, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('isGeneratedChapters') } }

        sig { params(media_id: T.nilable(::String), is_generated_chapters: T.nilable(T::Boolean)).void }
        def initialize(media_id: nil, is_generated_chapters: nil)
          @media_id = media_id
          @is_generated_chapters = is_generated_chapters
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @media_id == other.media_id
          return false unless @is_generated_chapters == other.is_generated_chapters
          true
        end
      end
    end
  end
end
