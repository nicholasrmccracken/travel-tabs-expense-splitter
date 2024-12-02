Rails.application.routes.draw do
  get 'pages/about'
  devise_for :users

  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  get '/about', to: 'pages#about', as: 'about'

  resources :trips do
    resources :expenses do
      post 'leave', on: :member, to: 'expenses#leave', as: 'leave'
    end

    member do
      post :leave
    end
  end

  root 'trips#index'
end
