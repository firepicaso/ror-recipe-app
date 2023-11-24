Rails.application.routes.draw do
  devise_for :users
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/inventories', to: 'inventories#index'
  get '/inventories/new', to: 'inventories#new'
  post '/inventories', to: 'inventories#create'
  get '/inventories/:id', to: 'inventories#show'
  delete '/inventories/:id', to: 'inventories#destroy'
  get '/inventories/:id/inventory_foods/new', to: 'inventory_foods#new'
  post '/inventories/:id/inventory_foods', to: 'inventory_foods#create'
  delete '/inventory_foods/:id', to: 'inventory_foods#destroy'

  # Defines the root path route ("/")
  root "foods#index"

  resources :users

  resources :recipes, only: [:index, :new, :create, :show, :update, :destroy] do
    resources :recipe_foods, only: [:new, :create, :edit, :update, :destroy]
  end
  
  resources :public_recipes, only: [:index]
  
  resources :inventories, only: [:index, :show, :new, :create, :destroy] do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end
  
  resources :foods, only: [:index, :new, :create, :show, :edit, :update, :destroy]

  resources :general_shopping_list, only: [:index]
end
