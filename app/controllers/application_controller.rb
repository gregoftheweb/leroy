class ApplicationController < ActionController::Base
  # This line ensures Devise helper methods are available in your views
  helper_method :user_signed_in?, :current_user
end
