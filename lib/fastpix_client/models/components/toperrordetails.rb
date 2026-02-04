# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components

      class TopErrorDetails
        extend T::Sig
        include Crystalline::MetadataFields

        # views affected by the specific errors.
        field :percentage, Crystalline::Nilable.new(Crystalline::Union.new(::Integer, ::Float)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('percentage') } }
        # percentage of unique viewers affected by the specific error.
        field :unique_viewers_effected_percentage, Crystalline::Nilable.new(Crystalline::Union.new(::Integer, ::Float)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('uniqueViewersEffectedPercentage') } }
        # Information about the specific error.
        field :notes, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('notes') } }
        # error message or description.
        field :message, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('message') } }
        # The timestamp of when the error was last observed.
        field :last_seen, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('lastSeen') } }
        # Number of occurrences of the specific error.
        field :count, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('count') } }
        # Error code associated with the specific error.
        field :code, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('code') } }

        sig { params(percentage: T.nilable(T.any(::Integer, ::Float)), unique_viewers_effected_percentage: T.nilable(T.any(::Integer, ::Float)), notes: T.nilable(::String), message: T.nilable(::String), last_seen: T.nilable(::String), count: T.nilable(::Integer), code: T.nilable(::String)).void }
        def initialize(percentage: nil, unique_viewers_effected_percentage: nil, notes: nil, message: nil, last_seen: nil, count: nil, code: nil)
          @percentage = percentage
          @unique_viewers_effected_percentage = unique_viewers_effected_percentage
          @notes = notes
          @message = message
          @last_seen = last_seen
          @count = count
          @code = code
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @percentage == other.percentage
          return false unless @unique_viewers_effected_percentage == other.unique_viewers_effected_percentage
          return false unless @notes == other.notes
          return false unless @message == other.message
          return false unless @last_seen == other.last_seen
          return false unless @count == other.count
          return false unless @code == other.code
          true
        end
      end
    end
  end
end
