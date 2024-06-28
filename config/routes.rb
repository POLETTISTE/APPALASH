# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  scope '(:locale)', locale: /fr|es|de/ do
    authenticated :user do
      root to: 'dashboard#index', as: :authenticated_root
    end

    root to: 'home#welcome'

    get 'offers', to: 'home#offers'

    resources :clients
    resources :services
    resources :transactions
    resources :dashboard
  end
  # get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
