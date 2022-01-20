Rails.application.routes.draw do
  root to: 'customers#index'
  resources :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :customers do
    resources :orders
  end
end
