Rails.application.routes.draw do
  resources :line_items
  resources :carts
  root 'store#index', as: 'store_index'
  resources :products
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :carts do
    member do
      put 'decrement', to: 'carts#decrement'
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
