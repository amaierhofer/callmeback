Rails.application.routes.draw do
  resource :profile, only: [:show]
  root to: 'profiles#show'
end
