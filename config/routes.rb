Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  post 'register', to: 'auth#register'
  post 'login', to: 'auth#login'

  resources :users, only: [:show, :update, :destroy]
  resources :posts do
    resources :comments, only: [:index, :create, :destroy] do
      resources :comments, only: [:index, :create, :destroy], as: 'replies'
    end
  end

  post 'follow/:user_id', to: 'follows#create'
  delete 'unfollow/:user_id', to: 'follows#destroy'
  get 'followers', to: 'follows#followers'
  get 'following', to: 'follows#following'
end
