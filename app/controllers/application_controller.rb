class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  layout proc { false if request.xhr? }
  # include EventTrackingHelper

  private
  def current_user
    @current_user ||= User.find_by(uid: session[:uid]) if session[:uid]
  end

  def logged_in?
    current_user != nil
  end
end
