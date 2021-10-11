Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  resources :labels
  get 'topics/new'
  root 'static_pages#home'
  get  '/help',    to: 'static_pages#help'
  get  '/about',   to: 'static_pages#about'
  get  '/contact', to: 'static_pages#contact'
  get  '/signup',  to: 'users#new'
  get  '/login',   to: 'sessions#new'
  get  '/favorites/index'
  post '/favorites', to: 'favorites#create'
  post '/login',   to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  delete '/favorites', to: 'favorites#destroy'
  
  
  resources :users
  resources :account_activations, only: [:edit]
  resources :topics
  resources :comments, only: [:create, :destroy]
  resources :password_resets, only: [:new, :create, :edit, :update]

end