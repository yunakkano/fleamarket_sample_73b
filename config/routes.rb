Rails.application.routes.draw do
  get 'sending_destinations/new'
  get 'sending_destinations/show'
  get 'sends/new'
  get 'sends/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get  'sending_destinations', to: 'users/registrations#new_address'
    post 'sending_destinations', to: 'users/registrations#create_address'
    get  '/users/:user_id/sessions', to: 'users/sessions#index'
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
  resources :users, only: :show
  resources :users do
    scope module: :users do
      resources :sessions, only: [:index, :destroy]
      resources :cards,    only: [:index, :new, :create]
    end
  end
end
