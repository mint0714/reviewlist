Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "reviews#index"
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get "reviews", to: "reviews#index"
  post "reviews", to: "reviews#create"
  delete "reviews", to: "reviews#delete"
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create]
end
