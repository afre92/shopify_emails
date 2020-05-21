# frozen_string_literal: true

Rails.application.routes.draw do
  get '/settings', to: 'settings#edit', as: 'settings'
  patch '/settings', to: 'settings#update'
  get '/pricing', to: 'settings#pricing'
  resources :templates
  get '/convert/:token', to: 'analytics#convert'
  root to: 'home#index'
  get '/activatecharge', to: 'settings#activate_charge'
  get 'create-charge/:id', to: 'settings#create_recurring_application_charge', as: 'create_charge'
  get 'cancel-charge', to: 'settings#cancel_charge', as: 'cancel_charge'
  get '/reviews', to: 'reviews#index', as: 'reviews'
  get '/review/:id', to: 'reviews#show', as: 'review'
  get '/review_update/:id', to: 'reviews#update', as: 'review_update'

  get '/emails', to: 'emails#index', as: 'emails'
  get '/email/:id', to: 'emails#show', as: 'email'

  get '/dashboard', to: 'home#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
