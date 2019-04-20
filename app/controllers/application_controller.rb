class ApplicationController < ActionController::Base
  include ExceptionHandler
  include Response

  # to permit access from other applications
  skip_before_action :verify_authenticity_token
end
