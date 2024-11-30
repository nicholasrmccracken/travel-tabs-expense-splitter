Rails.application.routes.draw do
  devise_for :users

  resources :trips do
    resources :expenses, only: %i[new create show]
  end

  root 'trips#index'
end
