# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /fr|es|de/ do

  root 'home#welcome'

  get 'offers', to: 'home#offers'

  resources :clients
  resources :prestations
  resources :transactions
  resources :dashboard

  end
  # get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
end
