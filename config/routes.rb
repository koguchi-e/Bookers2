Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users

  resources :users, only: [:new, :index, :show]
  resources :books, only: [:new, :create, :index, :show]

  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
