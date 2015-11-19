class Auth0Controller < ApplicationController
  def callback
    if github_org_authorized?
      user = User.find_or_create_by(uid: request.env['omniauth.auth']['uid'])
      user.image = request.env['omniauth.auth']['info']['image']
      user.name  = request.env['omniauth.auth']['info']['name']
      user.email = request.env['omniauth.auth']['info']['email']
      user.save

      session[:uid] = user.uid
      redirect_to root_url
    else
      render plain: "You are not a member of the Devbootcamp Org on GitHub", status: 403
    end
  end

  def failure
    @error_msg = request.params['message']
    render plain: @error_msg.to_s
  end

  def github_org_authorized?
    conn = Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.adapter  Faraday.default_adapter
    end

    token = "#{request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['access_token']}"
    response = conn.get do |req|
      req.url "/orgs/devbootcamp/members/#{request.env['omniauth.auth']['info']['nickname']}"
      req.headers['Authorization'] = "token #{token}"
    end

    if response[:status] == "204 No Content"
      return true
    end
    false
  end
end
