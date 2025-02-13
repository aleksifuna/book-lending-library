Rails.application.routes.draw do
  resources :registrations, only: [:new, :create]
  resources :passwords, param: :token

  resource :session, only: [:new, :create, :destroy]

  root "home#index"
end
