class SessionsController < ApplicationController
  def new
    render "new", layout: false
  end

  def destroy
    session.clear
    redirect_to root_url
  end
end