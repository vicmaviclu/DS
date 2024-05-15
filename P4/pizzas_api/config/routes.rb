Rails.application.routes.draw do
  resources :tareas, only: [:index, :create, :update, :destroy]
end
