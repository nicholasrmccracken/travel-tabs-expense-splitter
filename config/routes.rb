Rails.application.routes.draw do
  get 'friends/index'
  get 'user/verify_email'
  devise_for :users

  # Define authenticated and unauthenticated root paths
  authenticated :user do
    root 'dashboard#index', as: :authenticated_root
  end

  unauthenticated do
    root 'pages#landing', as: :unauthenticated_root
  end


  get 'pages/about'
  get '/dashboard', to: 'dashboard#index', as: 'dashboard'
  get '/about', to: 'pages#about', as: 'about'

  resources :users do
    collection do
      get :verify_email
    end
  end

  resources :friend_requests, only: [:index, :create, :update, :destroy]
  resources :friends, only: [:index]
  resources :users, only: [:index]



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
