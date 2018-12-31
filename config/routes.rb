Rails.application.routes.draw do
  resources :trees, only: [:index, :show]
  resources :users
  resources :collections
end
