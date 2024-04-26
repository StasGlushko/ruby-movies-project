require 'sidekiq/web'

Rails.application.routes.draw do
  # resources :films
  resources :posts
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => '/sidekiq'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get "/articles", to: "articles#index"
  # Defines the root path route ("/")
  root "articles#index"
  resources :films do
    collection do
      get :omdb_search
      post :omdb_import
    end

    resources :comments, only: %i[create edit update destroy]
  end

  resource :profile, only: %i[edit update], controller: :profiles
end
