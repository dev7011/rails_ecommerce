Rails.application.routes.draw do
  namespace :admin do
    resources :categories
  end

  devise_for :admins
  get 'home/index'

  authenticated :admins do
    root to: 'admin#index', as: :admin_root
  end

  root 'home#index'

  get 'admin' => 'admin#index'
end