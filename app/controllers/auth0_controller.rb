class Auth0Controller < ApplicationController
  def callback

    user = User.find_or_create_by(uid: request.env['omniauth.auth']['uid'])
    user.image = request.env['omniauth.auth']['info']['image']
    user.name  = request.env['omniauth.auth']['info']['name']
    user.email = request.env['omniauth.auth']['info']['email']
    user.save

    session[:uid] = user.uid
    redirect_to root_url
  end

  def failure
    @error_msg = request.params['message']
    render plain: @error_msg.to_s
  end
end
