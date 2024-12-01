Rails.application.routes.draw do
  devise_for :users

  resources :trips, only: %i[index show new create destroy]

  root 'trips#index'
end
