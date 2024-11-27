Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users

  resources :users, only: [:index, :show, :edit]
  resources :books, only: [:new, :create, :index, :show, :destroy]

  # Aboutページのルート設定
  get 'about', to: 'homes#about', as: 'about'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
