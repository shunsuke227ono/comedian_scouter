Rails.application.routes.draw do
  root to: 'top#show'

  resources :popularities, only: [:index] do
    collection do
      get :appear_ranking_data
    end
  end
  resources :relations, only: [:index] do
    collection do
      get :map_data
    end
  end
end
