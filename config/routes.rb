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

  
  resources :posts do
    resources :comments
  end  
  resources :favorites, only: [:create, :destroy]  
  resources :relationships, only: [:create, :destroy]
  
  resources :tags do
    get 'posts', to: 'posts#search'
  end
end
