Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope path: '/api' do
    resources :messages, only: [:index, :create]
    resources :users, only: [:index]
    resources :contexts, only: [:index]
    resources :translated_enums, only: [:show]
    scope module: 'food' do
      resources :recipes, only: [:index, :show, :create, :update]
    end
    scope module: 'photos' do
      resources :photos, only: [:show, :create, :destroy, :update]
      resources :albums, only: [:index, :show, :create, :destroy]
    end
  end
end
