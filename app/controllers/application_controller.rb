class ApplicationController < ActionController::Base
  # to permit access from other applications
  skip_before_action :verify_authenticity_token
end
