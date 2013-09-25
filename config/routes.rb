Gunlicense::Application.routes.draw do
  devise_for :users

  root 'home#index'

  get 'unmapped_addresses', :controller => :home, :action => :unmapped_addresses

  resources :gun_owners
  resources :uploads

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end
