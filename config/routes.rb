Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  get 'users/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "reviews#index"
  
  get "reviews/:id", to: "reviews#show"
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create]
end
