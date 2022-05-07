Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: :callbacks }
  resources :tweets do
    resources :likes, only: [:create]
  end

  root "tweets#index"
  resources :users, only: [:show]

  namespace :api do
    resources :tweets
    
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
  end
end
