Rails.application.routes.draw do
  get 'cards/new'
  get 'cards/show'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_scope :user do
    get  'sending_destinations', to: 'users/registrations#new_address'
    post 'sending_destinations', to: 'users/registrations#create_address'
    get 'logout_confirmation', to: 'users/sessions#logout_confirmation'
  end

  root 'items#index'

  resources :items, except: :show
  resources :users, only: :show
  get '/users/:id/credit_card', to: 'users#credit_card'
  resources :cards, only: [:new, :show] do
    collection do
      post 'show', to: 'cards#show'
    end
  end
end
