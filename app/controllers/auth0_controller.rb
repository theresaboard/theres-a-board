class Auth0Controller < ApplicationController
  def callback
    if github_org_authorized?
      user = User.find_or_create_by(uid: request.env['omniauth.auth']['uid'])
      user.image = request.env['omniauth.auth']['info']['image']
      user.name  = request.env['omniauth.auth']['info']['name']
      user.email = request.env['omniauth.auth']['info']['email']
      user.save
      if github_mentor?
        user.roles << Role.find_by(name: "mentor")
      end

      session[:uid] = user.uid
      if user.is_mentor?
        redirect_to mentor_index_url
      else
        redirect_to root_url
      end
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

  def github_mentor?
    conn = Faraday.new(:url => 'https://api.github.com') do |faraday|
      faraday.adapter  Faraday.default_adapter
    end

    token = "#{request.env['omniauth.auth']['extra']['raw_info']['identities'][0]['access_token']}"
    response = conn.get do |req|
      req.url "/teams/1889928/memberships/#{request.env['omniauth.auth']['info']['nickname']}"
      req.headers['Authorization'] = "token #{token}"
    end

    response[:status] == "200 OK"
  end
end
