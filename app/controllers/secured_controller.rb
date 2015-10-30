class SecuredController < ApplicationController

  before_action :logged_in_using_omniauth?

  private

  def logged_in_using_omniauth?
    unless logged_in?
      redirect_to '/login'
    end
  end

end
