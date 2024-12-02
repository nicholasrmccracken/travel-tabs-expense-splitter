Rails.application.routes.draw do
  get 'pages/about'
  devise_for :users

  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  get '/about', to: 'pages#about', as: 'about'

  resources :trips do
    resources :expenses, only: %i[index show new create edit update destroy]
  end
  

  root 'trips#index'
end
