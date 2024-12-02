Rails.application.routes.draw do
  devise_for :users

  resources :trips do
    resources :expenses, only: %i[index show new create edit update destroy] do
      member do
        delete :leave
      end
    end
  end

  root 'trips#index'
end
