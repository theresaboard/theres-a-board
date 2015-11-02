Rails.application.routes.draw do

  root "dashboard#index"
  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get   '/login', to: 'sessions#new', as: :login
  get   '/logout', to: 'sessions#destroy', as: :logout

  resources :timeslots, only: [:update, :show]

  namespace :api, defaults: {format: :json} do

    patch 'timeslots/:id/cancel', to: 'timeslots#cancel', as: :cancel
    resources :timeslots, only: [:index, :create, :update, :destroy]

  end
end
