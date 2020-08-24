Rails.application.routes.draw do
  # get 'categories/index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
  }
  devise_scope :user do
    get  'sending_destinations', to: 'users/registrations#new_address'
    post 'sending_destinations', to: 'users/registrations#create_address'
    get  '/users/:user_id/sessions', to: 'users/sessions#index'
  end

  root 'items#index'

  namespace :items do
    resources :searches, only: :index
    resources :brand_searches, only: :index
  end

  resources :items do
    scope module: :items do
      resources :cards,                 only:[:new, :create, :show, :destroy]
      resources :sending_destinations,  onyl:[:edit,:update]
    end
    collection do
      get  'done', to:'items#done'
    end
    member do
      get "purchase"
      post "pay"
    end
    resources :comments, only: :create
    collection do
      get :search
    end
    resource :favorites, only: [:create, :destroy]
  end

  resources :users do
    scope module: :users do
      resources :sessions,            only: [:index,  :destroy]
      resources :cards,               only: [:index,  :new,   :create, :destroy]
      resources :sending_destinations,only: [:edit,   :update]
      resources :profiles,            only: [:edit,   :update]
      resources :self_introductions,  only: [:new,    :create,:edit, :update]
      resources :on_sale_items,       only: [:index]
      resources :sold_items,          only: [:index]
      resources :purchased_items,     only: [:index]
    end
  end
  
  resources :categories,  only: [:index, :show]
  resources :categories do
    scope module: :categories do
      resources :brands,  only: [:index]
    end
  end

  resources :brands,     only: [:index, :show]

  resources :users, only: [:index, :show] do
    member do
      get :favorites
    end
  end
end
