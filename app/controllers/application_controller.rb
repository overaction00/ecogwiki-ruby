class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :facebook_id

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def facebook_id
    CONFIG['facebook']['app_id']
  end
end
