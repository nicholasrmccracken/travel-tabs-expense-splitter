Rails.application.routes.draw do
  devise_for :users

  resources :trips do
    resources :expenses
    member do
      post :leave
    end
  end

  root 'trips#index'
end
