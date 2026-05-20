Rails.application.routes.draw do
  devise_for :admins

  authenticated :admin do
    root to: "admin#index", as: :admin_root
  end

  unauthenticated do
    root "home#index"
  end

  namespace :admin do
    resources :products
    resources :categories
    # resources :stocks
  end

  get "home/index"
  get "admin" => "admin#index"
end