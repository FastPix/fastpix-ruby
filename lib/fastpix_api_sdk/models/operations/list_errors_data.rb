
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    
      # Displays the result of the request.
      class ListErrorsData
        extend T::Sig
        include Crystalline::MetadataFields

        # Retrieves a list of errors that have occurred in the system.
        field :errors, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::ErrorDetails)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('errors') } }
        # Retrieves a list of errors that have occurred most frequently in the system, ranked by their count of occurrences.
        field :top_errors, Crystalline::Nilable.new(Crystalline::Array.new(Models::Components::TopErrorDetails)), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('topErrors') } }

        sig { params(errors: T.nilable(T::Array[Models::Components::ErrorDetails]), top_errors: T.nilable(T::Array[Models::Components::TopErrorDetails])).void }
        def initialize(errors: nil, top_errors: nil)
          @errors = errors
          @top_errors = top_errors
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @errors == other.errors
          return false unless @top_errors == other.top_errors
          true
        end
      end
    end
  end
end
