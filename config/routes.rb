Rails.application.routes.draw do
  devise_for :users

  get 'pages/about'
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  get '/about', to: 'pages#about', as: 'about'

  resources :trips do
    resources :expenses do
      post 'leave', on: :member, to: 'expenses#leave', as: 'leave'
      post :update_shares, on: :member
    end

    member do
      post :leave
    end
  end

  # Landing page route
  root 'pages#landing'
end