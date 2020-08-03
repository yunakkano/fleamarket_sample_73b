Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  devise_scope :user do
    get 'profiles', to: 'users/registrations#new_profile_address'
    post 'profiles', to: 'users/registrations#create_profile_address'
  end

  root 'items#index'

  resources :items, except: :show
  # get '/items/:id/card_show', to: 'items#card_show'
  resources :items do
    scope module: :items do
      resources :cards, only:[:new] do
        collection do
          get 'show', to: 'cards#show'
          post 'pay', to: 'cards#pay'
          post 'delete', to: 'cards#delete'
        end
      end
    end
    collection do
      get  'done', to:'items#done'
    end
    member do
      get "purchase"
      post "pay"
      # get "card_show"
    end
  end
  
  resources :users, only: [:show] do
    member do
      get "sending_destination"
    end
  end
end
