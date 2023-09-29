Rails.application.routes.draw do
  resources :orders
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :line_items do
    member do
      put 'decrement', to: 'line_items#decrement'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
