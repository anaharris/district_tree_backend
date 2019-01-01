Rails.application.routes.draw do
  resources :trees, only: [:index, :show]
  resources :collections
  resources :users, only: [:create, :update, :destroy]
    post '/login', to: 'auth#create'
    get '/profile', to: 'users#profile'
end
