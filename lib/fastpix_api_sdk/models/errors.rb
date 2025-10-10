
# typed: true
# frozen_string_literal: true

module FastpixApiSDK
  module Models
    module Errors
      autoload :APIError, 'fastpix_api_sdk/models/errors/apierror.rb'
      autoload :BadRequestError, 'fastpix_api_sdk/models/errors/badrequest_error.rb'
      autoload :DuplicateMp4SupportError, 'fastpix_api_sdk/models/errors/duplicatemp4support_error.rb'
      autoload :DuplicateReferenceIdErrorResponse, 'fastpix_api_sdk/models/errors/duplicatereferenceiderrorresponse.rb'
      autoload :ForbiddenResponseError, 'fastpix_api_sdk/models/errors/forbiddenresponse_error.rb'
      autoload :ForbiddenError, 'fastpix_api_sdk/models/errors/forbidden_error.rb'
      autoload :InvalidPermissionError, 'fastpix_api_sdk/models/errors/invalidpermission_error.rb'
      autoload :InvalidPlaylistIdResponseError, 'fastpix_api_sdk/models/errors/invalidplaylistidresponse_error.rb'
      autoload :LiveNotFoundError, 'fastpix_api_sdk/models/errors/livenotfounderror.rb'
      autoload :MediaClipNotFoundError, 'fastpix_api_sdk/models/errors/mediaclipnotfound_error.rb'
      autoload :MediaNotFoundError, 'fastpix_api_sdk/models/errors/medianotfound_error.rb'
      autoload :MediaOrPlaybackNotFoundError, 'fastpix_api_sdk/models/errors/mediaorplaybacknotfound_error.rb'
      autoload :NotFoundError, 'fastpix_api_sdk/models/errors/notfounderror.rb'
      autoload :NotFoundErrorPlaybackId, 'fastpix_api_sdk/models/errors/notfounderrorplaybackid.rb'
      autoload :NotFoundErrorSimulcast, 'fastpix_api_sdk/models/errors/notfounderrorsimulcast.rb'
      autoload :SigningKeyNotFoundError, 'fastpix_api_sdk/models/errors/signingkeynotfounderror.rb'
      autoload :SimulcastUnavailableError, 'fastpix_api_sdk/models/errors/simulcastunavailable_error.rb'
      autoload :StreamAlreadyDisabledError, 'fastpix_api_sdk/models/errors/streamalreadydisablederror.rb'
      autoload :TrackDuplicateRequestError, 'fastpix_api_sdk/models/errors/trackduplicaterequest_error.rb'
      autoload :UnAuthorizedResponseError, 'fastpix_api_sdk/models/errors/unauthorizedresponse_error.rb'
      autoload :UnauthorizedError, 'fastpix_api_sdk/models/errors/unauthorized_error.rb'
      autoload :ValidationErrorResponse, 'fastpix_api_sdk/models/errors/validationerrorresponse.rb'
      autoload :ViewNotFoundError, 'fastpix_api_sdk/models/errors/viewnotfound_error.rb'
    end
  end
end
