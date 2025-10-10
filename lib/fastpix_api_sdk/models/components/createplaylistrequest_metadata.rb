
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Required when playlist type is smart - media created between startDate and endDate of createdDate will be add, similarily updatedDate (Optional)
      class CreatePlaylistRequestMetadata
        extend T::Sig
        include Crystalline::MetadataFields

        # Date range with start and end dates.
        field :created_date, Crystalline::Nilable.new(Models::Components::DateRange), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('createdDate') } }
        # Date range with start and end dates.
        field :updated_date, Crystalline::Nilable.new(Models::Components::DateRange), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('updatedDate') } }

        sig { params(created_date: T.nilable(Models::Components::DateRange), updated_date: T.nilable(Models::Components::DateRange)).void }
        def initialize(created_date: nil, updated_date: nil)
          @created_date = created_date
          @updated_date = updated_date
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @created_date == other.created_date
          return false unless @updated_date == other.updated_date
          true
        end
      end
    end
  end
end
