class SessionsController < ApplicationController

  def new
  end

  def destroy
    session.clear
    redirect_to root_url
  end
end