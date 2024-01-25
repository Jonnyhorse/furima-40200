Rails.application.routes.draw do
  devise_for :users
  get 'messages/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # root to: "items#index"

  root to: 'products#index'
  resources :products do
    resources :orders
  end
  
  
end
