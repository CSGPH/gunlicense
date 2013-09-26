Gunlicense::Application.routes.draw do
  devise_for :users

  root 'home#index'

  namespace :admin do
    resources :gun_owners
    resources :uploads
    resource  :dashboard do
      get 'unmapped_addresses'
    end
  end

  namespace :owner do
    resource :dashboard
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
