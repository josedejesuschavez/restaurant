Rails.application.routes.draw do
  root 'store#index', as: 'store_index'
  resources :line_items
  resources :carts
  get 'line_items/index'
  get 'line_items/show'
  get 'line_items/new'
  get 'line_items/create'
  get 'store/index'
  resources :users
  resources :foods
  resources :categories

  get '/login', to: 'sessions#login'
  post 'login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
  get '/logout', to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
