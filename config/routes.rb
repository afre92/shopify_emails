Rails.application.routes.draw do
  get '/settings', to: 'settings#edit'
  patch '/settings', to: 'settings#update'
  resources :templates
  root :to => 'home#show'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
