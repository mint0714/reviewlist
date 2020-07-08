Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root to: "reviews#index"
  
  get "reviews", to: "reviews#index"
  get "reviews/:id", to: "reviews#show"
end
