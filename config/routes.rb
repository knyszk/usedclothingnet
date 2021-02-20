Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'

  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users do
    get :favorites, on: :collection
    member do
      get :followings
      get :followers
    end
    
    collection do
      get :search
    end
    
    get :search, on: :collection
  end
  
  resources :photos do
    # resources :favorites, only: [:create, :destroy, :index]
    resources :comments, only: [:create ,:destroy]
  end
  
  resources :relationships, only: [:create, :destroy]
  
end