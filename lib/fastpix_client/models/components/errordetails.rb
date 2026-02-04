# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class ErrorDetails
        extend T::Sig
        include Crystalline::MetadataFields

        # views affected by the specific errors.
        field :percentage, Crystalline::Nilable.new(Crystalline::Union.new(::Integer, ::Float)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('percentage') } }
        # Information about the specific error.
        field :notes, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('notes') } }
        # error message or description.
        field :message, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('message') } }
        # The timestamp of when the error was last observed.
        field :last_seen, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('lastSeen') } }
        # Unique identifier for the error instance.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('id') } }
        # A brief description of the error.
        field :description, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('description') } }
        # Number of occurrences of the specific error.
        field :count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('count') } }
        # Error code associated with the specific error.
        field :code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('code') } }

        sig { params(percentage: T.nilable(T.any(::Integer, ::Float)), notes: T.nilable(::String), message: T.nilable(::String), last_seen: T.nilable(::String), id: T.nilable(::String), description: T.nilable(::String), count: T.nilable(::Integer), code: T.nilable(::String)).void }
        def initialize(percentage: nil, notes: nil, message: nil, last_seen: nil, id: nil, description: nil, count: nil, code: nil)
          @percentage = percentage
          @notes = notes
          @message = message
          @last_seen = last_seen
          @id = id
          @description = description
          @count = count
          @code = code
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @percentage == other.percentage
          return false unless @notes == other.notes
          return false unless @message == other.message
          return false unless @last_seen == other.last_seen
          return false unless @id == other.id
          return false unless @description == other.description
          return false unless @count == other.count
          return false unless @code == other.code
          true
        end
      end
    end
  end
end
