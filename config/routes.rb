Rails.application.routes.draw do
  devise_for :users  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  get '/public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'

  # Defines the root path route ("/")
  root "foods#index"

  devise_scope :user do
    authenticated :user do
      root :to => 'foods#index', as: :authenticated_root
    end
    unauthenticated :user do
      root :to => 'recipes#public_recipes', as: :unauthenticated_root
    end
  end

  
  rresources :recipes, only: [:index, :new, :create, :show, :update, :destroy] do
    resources :recipe_foods
  end

  resources :food, only: [:index, :new, :create, :destroy]

  resources :shopping_lists, only: [:index]
end
