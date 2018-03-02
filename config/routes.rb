Rails.application.routes.draw do
  root 'products#index'
  devise_for :users

  resources :products, only: [:index] do
    resources :orders, only: :create
  end
  resources :orders, only: [:index, :destroy]
  delete 'empty_cart', to: 'orders#empty'
  # For details on the DSL a vailable within this file, see http://guides.rubyonrails.org/routing.html
end
