Rails.application.routes.draw do
  resource :profile, only: [:show]
  resource :push_subscriptions, only: [:create, :destroy]
  root to: 'profiles#show'
end
