Rails.application.routes.draw do
  resources :trees, only: [:index, :show]
end
