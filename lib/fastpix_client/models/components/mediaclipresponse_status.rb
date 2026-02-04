# Generated code for FastPix API SDK.

# typed: true
# frozen_string_literal: true


module FastpixClient
  module Models
    module Components
      # MediaClipResponseStatus - The current processing status of the media.
      class MediaClipResponseStatus < T::Enum


        enums do
          CREATED = new('Created')
          DOWNLOADING = new('Downloading')
          DOWNLOADED = new('Downloaded')
          VALIDATING = new('Validating')
          IN_QUEUE = new('In Queue')
          PROCESSING = new('Processing')
          READY = new('Ready')
          FAILED = new('Failed')
        end
      end
    end
  end
end
