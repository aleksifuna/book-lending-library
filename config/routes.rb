Rails.application.routes.draw do
  # Authentication routes
  resources :registrations, only: [ :new, :create ]
  resources :passwords, param: :token
  resource :session, only: [ :new, :create, :destroy ]

  # Books routes
  resources :books do
    member do
      post :borrow
      post :return
    end
  end

  resources :users, only: [ :show ]

  # Root route
  root "books#index"
end
