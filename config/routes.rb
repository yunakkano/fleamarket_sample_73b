Rails.application.routes.draw do
  get 'sending_destinations/new'
  get 'sending_destinations/show'
  get 'sends/new'
  get 'sends/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile_address'
    post 'profiles', to: 'users/registrations#create_profile_address'
  end

  root 'items#index'

  resources :items, except: :show
  resources :items do
    collection do
      get  'done', to:'items#done'
    end
    member do
      get "purchase"
      post "pay"
      post 'card_show', to:'cards#show'
    end
  end
  get '/items/:id/card_show', to: 'items#card_show'
  resources :users, only: [:show] do
    member do
      get "sending_destination"
    end
  end
  resources :cards, only: [:new, :show] do
    collection do
      # get 'index', to: 'cards#index'（確認中）
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
