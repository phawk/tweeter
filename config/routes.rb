Rails.application.routes.draw do
  # Authentication routes
  get  "sign_in", to: "sessions#new"
  post "sign_in", to: "sessions#create"
  get  "sign_up", to: "registrations#new"
  post "sign_up", to: "registrations#create"
  resources :sessions, only: [:index, :show, :destroy]
  resource  :password, only: [:edit, :update]
  namespace :identity do
    resource :email,              only: [:edit, :update]
    resource :email_verification, only: [:edit, :create]
    resource :password_reset,     only: [:new, :edit, :create, :update]
  end

  # App routes
  resources :tweets do
    resources :likes, only: %i[create destroy]
    resources :retweets, only: :create
  end

  resources :profiles, param: :username, only: %i[edit update]

  get "/close_modal", to: "pages#close_modal", as: :close_modal
  get "/:username", to: "profiles#show", as: :show_profile

  root "tweets#index"
end
