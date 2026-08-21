Rails.application.routes.draw do
  devise_for :admins

  authenticated :admin do
    root to: "admin#index", as: :admin_root
  end

  unauthenticated do
    root "home#index"
  end

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

  get "home/index"
  get "admin" => "admin#index"
end