# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Operations
      # Displays the result of the request.
      class RetrieveMediaInputInfoData
        extend T::Sig
        include Crystalline::MetadataFields

        # Represents configuration details for the media.
        field :configuration, Crystalline::Nilable.new(Models::Operations::Configuration), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('configuration') } }
        # Contains metadata and structural details about the media file.
        field :file, Crystalline::Nilable.new(Models::Operations::File), { 'format_json': { 'letter_case': ::FastpixClient::Utils.field_name('file') } }

        sig { params(configuration: T.nilable(Models::Operations::Configuration), file: T.nilable(Models::Operations::File)).void }
        def initialize(configuration: nil, file: nil)
          @configuration = configuration
          @file = file
        end

        sig { params(other: T.untyped).returns(T::Boolean) }
        def ==(other)
          return false unless other.is_a? self.class
          return false unless @configuration == other.configuration
          return false unless @file == other.file
          true
        end
      end
    end
  end
end
