
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class UpdateMediaChaptersRequestBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Enable or disable the chapters feature for the media. Set to `true` to enable chapters or `false` to disable.
        # 
        field :chapters, Crystalline::Boolean.new, { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('chapters'), required: true } }

        sig { params(chapters: T::Boolean).void }
        def initialize(chapters:)
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
