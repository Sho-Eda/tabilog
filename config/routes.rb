Rails.application.routes.draw do
  
  get 'posts/new'
  get 'posts/create'
  get 'posts/destroy'
  get 'sessions/new'
  get 'sessions/create'
  get 'sessions/destroy'
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create, :edit, :update]
  resources :posts, only: [:new, :create, :destroy]
  
end
