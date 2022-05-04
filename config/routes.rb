Rails.application.routes.draw do
  resources :likes
  resources :tweets
  resources :users

  root "tweets#index"
end
