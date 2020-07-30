Rails.application.routes.draw do
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
  resources :users, only: :show
  resources :users do
    scope module: :users do
      resources :sessions, only: [:index, :destroy]
      resources :cards,    only: [:index, :new, :create]
    end
  end
  # get '/users/:id/credit_card', to: 'users#credit_card'
  # resources :cards, only: [:new, :show] do
  #   collection do
  #     post 'show', to: 'cards#show'
  #   end
  # end
end
