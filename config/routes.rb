Rails.application.routes.draw do
  devise_for :users
  # root to: "foods#index"
  root "foods#index"
  resources :foods, only: [:index, :new, :create, :show, :edit, :update, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  resources :inventories, only: [:index, :show, :new, :create, :destroy] do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end

  resources :recipes, only: [:index, :new, :create, :show, :update, :destroy] do
    resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
  end

  resources :public_recipes, only: [:index]
  resources :general_shopping_list, only: [:index]
end
