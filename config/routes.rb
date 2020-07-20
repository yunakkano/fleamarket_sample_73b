Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile_address'
    post 'profiles', to: 'users/registrations#create_profile_address'
  end

  root 'items#index'

  # resources :items, except: :show
  resources :items do
    collection do
      get 'index', to: 'items#index'
      get 'purchase/:id', to:'items#purchase'
      post 'pay/:id', to:'items#pay'#httpメソッドはpostなので注意
      get  'done', to:'items#done'
    end
  end
  resources :users, only: :show
  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
      post 'pay', to: 'cards#pay'
      delete 'delete', to: 'cards#delete'
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