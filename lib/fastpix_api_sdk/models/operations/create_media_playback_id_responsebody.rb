
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # Playback id for an media
      class CreateMediaPlaybackIdResponseBody
        extend T::Sig
        include Crystalline::MetadataFields

        # Demonstrates whether the request is successful or not.
        field :success, Crystalline::Nilable.new(Crystalline::Boolean.new), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('success') } }
        # Displays the result of the request.
        field :data, Crystalline::Nilable.new(Models::Operations::CreateMediaPlaybackIdData), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('data') } }

        sig { params(success: T.nilable(T::Boolean), data: T.nilable(Models::Operations::CreateMediaPlaybackIdData)).void }
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
