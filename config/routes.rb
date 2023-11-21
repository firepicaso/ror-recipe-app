Rails.application.routes.draw do
  root to: "foods#index"
  resources :foods, only: [:index, :new, :create, :show, :edit, :update, :destroy]
end
