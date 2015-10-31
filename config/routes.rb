Rails.application.routes.draw do

  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get   '/login', :to => 'sessions#new', :as => :login
  get   '/logout', :to => 'sessions#destroy', :as => :logout

  namespace :api, defaults: {format: :json} do
    resources :timeslots, only: [:index, :create, :update]
  end

  resources :timeslots, only: [:show]

  root "dashboard#index"

end
