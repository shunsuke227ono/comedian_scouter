Rails.application.routes.draw do
  root to: 'top#show'

  resources :popularities, only: [:index]
end
