Rails.application.routes.draw do
  root "dashboard#index"
  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/failure" => "auth0#failure"
  get   '/login', to: 'sessions#new', as: :login
  get   '/logout', to: 'sessions#destroy', as: :logout
  post '/shares/search', as: :search

  resources :timeslots, only: [:show]
  resources :users, only: [:edit]
  resources :shares, only: [:index, :create, :new]

  namespace :api, defaults: {format: :json} do
    get 'stats', to: 'stats#index'
    patch 'timeslots/:id/cancel', to: 'timeslots#cancel', as: :cancel
    resources :timeslots, only: [:index, :create, :update, :destroy]
    resources :users, only: [:update]
    post "mentor_requests", to: 'mentor_requests#open'
    put "mentor_requests", to: 'mentor_requests#close'
    get "mentor_requests", to: 'mentor_requests#status'
    get "mentor_requests/available", to: 'mentor_requests#available_mentors'
    post "mentor", to: 'mentor#checkin'
    put "mentor", to: 'mentor#checkout'
    get "mentor", to: 'mentor#status'
    get "mentor/queue", to: 'mentor#index'
    put "mentor/queue/:id", to: 'mentor#close_request'
  end

  resources :mentor, only: [:index]
  
  get "/403", :to => "errors#forbidden"
  get "/404", :to => "errors#not_found"
  get "/422", :to => "errors#unacceptable"
  get "/500", :to => "errors#internal_error"
end
