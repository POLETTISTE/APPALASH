# frozen_string_literal: true
require 'admin_constraint'

Rails.application.routes.draw do
  # get 'errors/not_found'
  # get 'errors/internal_server'
  # get 'errors/unprocessable'
  # get 'errors/unacceptable'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  scope '(:locale)', locale: /fr|es|de/ do
    get 'offers', to: 'home#offers', as: :offers
    get '/switch_language', to: 'application#switch_language', as: :switch_language

    authenticated :user do
      root to: 'dashboard#index', as: :authenticated_root
      get 'users/personal_information', to: 'users#index_personal_information', as: :personal_information
    end

    constraints AdminConstraint.new do
      get 'documentation', to: 'home#documentation', as: :documentation
    end

    unauthenticated do
      root to: 'home#home'
      get 'home', to: 'home#home'
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

  get '/home/:website', to: 'users#show_website', as: 'user_profile'
  get '/home/:website/edit', to: 'users#edit_website', as: 'edit_website_user_profile'
  patch '/home/:website', to: 'users#update_website', as: 'update_website_user_profile'

  # Catch-all route for undefined paths
  match '*path', to: 'errors#not_found', via: :all
end
