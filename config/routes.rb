Rails.application.routes.draw do
  get '/settings', to: 'settings#show'
  resources :templates
  root :to => 'home#show'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
