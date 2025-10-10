
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Operations
    

      class GetVideoViewDetailsRequest
        extend T::Sig
        include Crystalline::MetadataFields

        # Pass View id
        field :view_id, ::String, { 'path_param': { 'field_name': 'viewId', 'style': 'simple', 'explode': false } }

        sig { params(view_id: ::String).void }
        def initialize(view_id:)
          @view_id = view_id
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @view_id == other.view_id
          true
        end
      end
    end
  end
end
