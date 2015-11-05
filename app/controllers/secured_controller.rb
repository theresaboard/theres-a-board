class SecuredController < ApplicationController
  before_action :redirect_if_not_logged_in

  private

  def redirect_if_not_logged_in
    unless logged_in?
      redirect_to '/login'
    end
  end
end
