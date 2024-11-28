Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users, controllers: { 
    registrations: 'users/registrations', 
    sessions: 'users/sessions' 
  }

  resources :users, only: [:index, :show, :edit, :update]
  resources :books, only: [:new, :create, :index, :show, :destroy]

  # Aboutページのルート設定
  get 'about', to: 'homes#about', as: 'about'
end
