Rails.application.routes.draw do
  resource :profile, only: [:show]
  resource :push_subscriptions, only: %i[create destroy]
  resources :push_messages, only: :create
  root to: 'profiles#show'
end
