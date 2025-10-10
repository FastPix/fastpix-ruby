
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    
      # Contains the view count details.
      class ViewsCountResponseData
        extend T::Sig
        include Crystalline::MetadataFields

        # Number of views for the stream or resource.
        field :views, Crystalline::Nilable.new(::Integer), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('views') } }

        sig { params(views: T.nilable(::Integer)).void }
        def initialize(views: nil)
          @views = views
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @views == other.views
          true
        end
      end
    end
  end
end
