Gunlicense::Application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :gun_owners do
    collection do
      post :import
      get  :upload
    end
  end
end
