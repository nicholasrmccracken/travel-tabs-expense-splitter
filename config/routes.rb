Rails.application.routes.draw do
  devise_for :users

  resources :trips, only: %i[index show new create destroy] do
    member do
      delete :leave
    end
  end

  root 'trips#index'
end
