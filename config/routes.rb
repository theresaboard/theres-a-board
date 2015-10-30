Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    resources :timeslots, only: [:index, :create, :update]
  end

  root "public#index"

end
