Rails.application.routes.draw do
  resource :profile, only: [:show]
  resource :endpoint, only: [:create, :destroy]
  root to: 'profiles#show'
end
