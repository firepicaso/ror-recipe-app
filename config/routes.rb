Rails.application.routes.draw do
  root to: "foods#index"
  
  resources :foods, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    # additional routes or constraints can go here if needed
  end
end
