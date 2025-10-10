
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class UpdatedMp4SupportRequestBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Determines the type of MP4 support for the media.   - **none**: Disables MP4 support.   - **capped_4k**: Enables MP4 downloads with resolutions up to 4K.   - **audioOnly**: Provides an MP4 stream containing only the audio.   - **audioOnly,capped_4k**: Enables both MP4 video downloads (up to 4K) and an audio-only stream.  
        field :mp4_support, Crystalline::Nilable.new(Models::Operations::UpdatedMp4SupportMp4Support), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('mp4Support'), 'decoder': Utils.enum_from_string(Models::Operations::UpdatedMp4SupportMp4Support, true) } }

        sig { params(mp4_support: T.nilable(Models::Operations::UpdatedMp4SupportMp4Support)).void }
        def initialize(mp4_support: nil)
          @mp4_support = mp4_support
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @mp4_support == other.mp4_support
          true
        end
      end
    end
  end
end
