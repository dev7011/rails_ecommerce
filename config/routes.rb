Rails.application.routes.draw do

  resources :products, only: %i[index show]

  devise_for :admins

  # authenticated :admin do
  #   root to: "admin#index", as: :admin_root
  # end
  #
  # unauthenticated do
  #   root "home#index"
  # end

  get "admin" => "admin#index", as: :admin_root
  get "home/index"
  root "home#index"

  resources :products, only: %i[index show ]
  get "products/:id/buy_now", to: "products#buy_now", as: :buy_now_product

  namespace :admin do
    get "dashboard"
    resources :products do
      member do
        patch :reorder
      end
      resources :stocks, only: %i[index new create edit update destroy]
    end
    resources :categories
    resources :stocks
    resources :orders
  end
end