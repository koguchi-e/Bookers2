Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users, controllers: { 
    registrations: 'users/registrations', 
    sessions: 'users/sessions' 
  }

  resources :users, only: [:index, :show, :edit, :update]

  resources :books, only: [:new, :create, :index, :show, :edit, :update, :destroy]  do
    resource :favorite, only: [:create, :destroy]
  end

  # Aboutページのルート設定
  get 'home/about', to: 'homes#about', as: 'about'
end
