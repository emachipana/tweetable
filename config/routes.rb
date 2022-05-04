Rails.application.routes.draw do
  devise_for :users
  resources :likes
  resources :tweets

  root "tweets#index"
end
