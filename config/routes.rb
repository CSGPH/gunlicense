Gunlicense::Application.routes.draw do
  devise_for :users

  root 'home#index'

  namespace :admin do
    resources :gun_owners
    resources :uploads
    resource  :dashboard, :controller => 'dashboard' do
      get 'unmapped_addresses'
      get 'search'
    end
  end

  namespace :owner do
    resource :dashboard, :controller => 'dashboard'

  end
  


  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  #for static pages only
  get "step_2", :controller => "home", :action => "step_2"
  get "step_3", :controller => "home", :action => "step_3"
end
