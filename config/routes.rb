
Rails.application.routes.draw do
  root 'users#index'
  resources :users
  resources :friendships, only: [:create, :destroy]
  resources :headings
end
