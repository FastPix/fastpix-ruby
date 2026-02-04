# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations

      class UpdatedMediaRequestBody
        extend T::Sig
        include Crystalline::MetadataFields


        field :metadata, Crystalline::Nilable.new(Crystalline::Hash.new(Symbol, ::String)), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('metadata') } }
        # Title of the media file.
        field :title, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('title') } }
        # The unique identifier of the user who created this media.
        field :creator_id, Crystalline::Nilable.new(::String), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('creatorId') } }

        sig { params(metadata: T.nilable(T::Hash[Symbol, ::String]), title: T.nilable(::String), creator_id: T.nilable(::String)).void }
        def initialize(metadata: nil, title: 'My Video Title', creator_id: '8fa85f64-5717-4562-b3fc-2c963f66afa6')
          @metadata = metadata
          @title = title
          @creator_id = creator_id
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @metadata == other.metadata
          return false unless @title == other.title
          return false unless @creator_id == other.creator_id
          true
        end
      end
    end
  end
end
