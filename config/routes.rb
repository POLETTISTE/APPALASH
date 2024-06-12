Rails.application.routes.draw do
  root "home#index"

    get 'offers', to: 'home#offers'

  resources :clients
  # get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
