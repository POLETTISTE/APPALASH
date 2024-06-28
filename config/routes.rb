# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  scope '(:locale)', locale: /fr|es|de/ do
    authenticated :user do
      root to: 'dashboard#index', as: :authenticated_root
      # You can add other routes accessible only when authenticated here
    end

    unauthenticated do
      root to: 'home#welcome'
      get 'offers', to: 'home#offers'
      # Define other routes accessible only when not authenticated here
    end

    resources :clients
    resources :services
    resources :transactions
    resources :dashboard
  end
end
