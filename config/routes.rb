# frozen_string_literal: true

Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server'
  get 'errors/unprocessable'
  get 'errors/unacceptable'
  devise_for :users
  scope '(:locale)', locale: /fr|es|de/ do
    authenticated :user do
      root to: 'dashboard#index', as: :authenticated_root
        # get '*path', to: 'dashboard#index'
      # You can add other routes accessible only when authenticated here
    end

    unauthenticated do
      root to: 'home#welcome'
      get 'offers', to: 'home#offers'
      # get '*path', to: 'home#welcome'
      # Define other routes accessible only when not authenticated here
    end

    resources :clients
    resources :services
    resources :transactions
    resources :dashboard
  end

  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server'
  get '/406', to: 'errors#unacceptable'
  get '/422', to: 'errors#unprocessable'

  get '/mywebsite/:website', to: 'users#show', as: 'user_profile'
  get '/mywebsite/:website/edit', to: 'users#edit', as: 'edit_user_profile'
  patch '/mywebsite/:website', to: 'users#update'

end
