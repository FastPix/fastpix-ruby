
# typed: true
# frozen_string_literal: true


module FastpixApiSDK
  module Models
    module Components
    

      class SigningKeyWorkspaceDTO
        extend T::Sig
        include Crystalline::MetadataFields

        # FastPix generates a unique identifier for each workspace.
        field :id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('id') } }
        # Designated title for the workspace.
        field :name, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('name') } }
        # Describes the type of a workspace.  Possible value: QA, staging, production, or development.
        field :workspace_type, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixApiSDK::Utils.field_name('workspaceType') } }

        sig { params(id: T.nilable(::String), name: T.nilable(::String), workspace_type: T.nilable(::String)).void }
        def initialize(id: nil, name: nil, workspace_type: nil)
          @id = id
          @name = name
          @workspace_type = workspace_type
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @id == other.id
          return false unless @name == other.name
          return false unless @workspace_type == other.workspace_type
          true
        end
      end
    end
  end
end
