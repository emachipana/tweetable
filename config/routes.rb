Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: :callbacks }
  resources :tweets do
    resources :likes, only: [:create]
  end

  root "tweets#index"
  get "/profile", to: "users#profile"
end
