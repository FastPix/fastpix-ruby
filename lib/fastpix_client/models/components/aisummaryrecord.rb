# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Represents an AI response record containing status and data for AI-generated features like summary, chapters, named entities, or moderation.
      class AiSummaryRecord
        extend T::Sig
        include Crystalline::MetadataFields

        # The status of the AI processing (for example, "available", "preparing", "failed").
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('status') } }
        # The AI-generated summary of the media content. This field contains the processed textual output produced by the AI once summarization is complete.
        field :data, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data') } }

        sig { params(status: T.nilable(::String), data: T.nilable(::String)).void }
        def initialize(status: nil, data: nil)
          @status = status
          @data = data
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @status == other.status
          return false unless @data == other.data
          true
        end
      end
    end
  end
end
