Gunlicense::Application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :gun_owners
  resources :uploads

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
