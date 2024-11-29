Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/login', to: 'session#new', as: 'login' # route to show log in form
  post '/login', to: 'sessions#create' # route to handle login submission
  delete '/logout', to: 'sessions#destroy', as: 'logout' # route to handle logout
  # Defines the root path route ("/")
  root 'home#index'
end
