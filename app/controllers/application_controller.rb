class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  layout proc { false if request.xhr? }

  private
  def current_user
    @current_user ||= User.find_by(uid: session[:uid]) if session[:uid]
  end

  def logged_in?
    current_user != nil
  end
end
