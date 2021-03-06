Rails.application.routes.draw do

  get 'orders/index'

  get 'orders/new'

  get 'orders/show'

  devise_for :users
  # For details on the DSL available within this file, see //guides.rubyonrails.org/routing.html
  root 'products#index'

  # get 网址 , to controller#action
  # get 'no_result', to:'products#no_result'

  namespace :admin do
  	resources :products
    resources :orders, only: [:index, :edit, :update, :destroy] do
      member do
        post :ship
        post :cancel
      end
    end
  end

  namespace :users do
    resources :delivery_addresses
  end

  resources :products, only: [:show, :index] 

  resources :carts, only: [:index] do
    post :empty_cart
  end
  
  resources :cart_items, only: [:create, :destroy] do 
    post :increment
    post :decrement
  end

  resources :orders, only: [:index, :new, :show, :create, :update] do
    member do
      post :cancel
      post :pay_by_wechat
      post :pay_by_alipay
      post :confirm
      post :return_good
    end
  end

end
