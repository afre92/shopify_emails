Rails.application.routes.draw do
  get 'template', to: 'templates#index'
  patch 'template/update', to: 'templates#update'
  get 'template/edit', to: 'templates#edit'
  root :to => 'home#show'
  mount ShopifyApp::Engine, at: '/'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
