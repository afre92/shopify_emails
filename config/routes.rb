Rails.application.routes.draw do
  get '/settings', to: 'settings#edit'
  patch '/settings', to: 'settings#update'
  resources :templates
  # get '/dashboard', to: 'dashboard#index'
  root :to => 'dashboard#index'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
