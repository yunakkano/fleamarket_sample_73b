Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get  'sending_destinations', to: 'users/registrations#new_address'
    post 'sending_destinations', to: 'users/registrations#create_address'
  end

  root 'items#index'

  # resources :items, except: :show
  resources :items do
    collection do
      get  'done', to:'items#done'
    end
    member do
      get "purchase"
      post "pay"
    end
  end
  resources :users, only: :show
  resources :cards, only: [:new, :show] do
    collection do
      # get 'index', to: 'cards#index'
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      post 'delete', to: 'cards#delete'
    end
  end
  resources :purchases, only: [:index] do
    collection do
      get 'index', to: 'purchases#index'
      post 'pay', to: 'purchases#pay'
      get 'done', to: 'purchases#done'
    end
  end
end
