Gunlicense::Application.routes.draw do
  devise_for :users

  root 'home#index'

  resources :users do
    collection do
      post :import
      get  :upload
    end
  end
end
