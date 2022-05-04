Rails.application.routes.draw do
  devise_for :users
  resources :likes
  resources :tweets
  resources :users

  root "tweets#index"
end
