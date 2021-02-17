Rails.application.routes.draw do
  
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :create, :edit, :update] do
    member do
      get :followings
      get :followers
      get :likes
    end
  end  
  # resource :users, only: [:edit, :update]
  
  resources :posts, only: [:show, :new, :create, :destroy, :edit, :update]
  resources :favorites, only: [:create, :destroy]  
  resources :relationships, only: [:create, :destroy]
end
