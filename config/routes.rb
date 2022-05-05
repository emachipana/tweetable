Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: :callbacks }
  resources :likes
  resources :tweets

  root "tweets#index"
end
