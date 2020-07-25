Rails.application.routes.draw do
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
end
