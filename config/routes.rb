Rails.application.routes.draw do

  root 'home#index'

  get "/cart" => "orders#cart", as: "cart"
  get "/checkout" => "orders#checkout", as: "checkout"

  resources :products do
    resources :reviews, except: [:index]
  end

  resources :merchants do
    resources :products, only: [:index]
  end

  resources :categories do
    resources :products, only: [:index]
  end

  resources :orders do
  end

  resources :order_items do
    put :shipped, on: :member
  end

  resources :sessions, :only => [:new, :create]

  delete "/logout", to: "sessions#destroy", as: :logout

end
