# frozen_string_literal: true

Rails.application.routes.draw do
  get '/settings', to: 'settings#edit', as: 'settings'
  patch '/settings', to: 'settings#update'
  resources :templates
  get '/convert/:token', to: 'analytics#convert', as: :views
  root to: 'home#index'
  get 'activatecharge', to: 'settings#activate_charge'
  get 'create-charge', to: 'settings#create_recurring_application_charge', as: 'create_charge'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
