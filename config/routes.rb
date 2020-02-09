# frozen_string_literal: true

Rails.application.routes.draw do
  get '/settings', to: 'settings#edit', as: 'settings'
  patch '/settings', to: 'settings#update'
  resources :templates
  get '/convert/:token' => 'analytics#convert', as: :views
  root to: 'dashboard#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
