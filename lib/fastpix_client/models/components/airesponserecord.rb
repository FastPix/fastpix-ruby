# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # Represents an AI response record containing status and data for AI-generated features like summary, chapters, named entities, or moderation.
      class AiResponseRecord
        extend T::Sig
        include Crystalline::MetadataFields

        # The status of the AI processing (for example, "available", "preparing", "failed").
        field :status, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('status') } }
        # The AI-generated content data. Can be a Map, List, or other structured data depending on the AI feature type.
        field :data, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::Object)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('data') } }

        sig { params(status: T.nilable(::String), data: T.nilable(T::Hash[Symbol, ::Object])).void }
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
