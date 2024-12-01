Rails.application.routes.draw do
  devise_for :users

  resources :trips do
    member do
      delete :leave
    end

    resources :expenses
  end

  root 'trips#index'
end
