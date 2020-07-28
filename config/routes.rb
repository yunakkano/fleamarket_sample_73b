Rails.application.routes.draw do
  get 'categories/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get  'sending_destinations', to: 'users/registrations#new_address'
    post 'sending_destinations', to: 'users/registrations#create_address'
  end

  root 'items#index'

  resources :items, except: [:show] do
    collection do
      get :search
    end
  end
  resources :users, only: :show
  resources :categories, only: [:index, :show]
end