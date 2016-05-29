Rails.application.routes.draw do
  root to: 'top#show'

  resources :popularities, only: [:index] do
    collection do
      get :appear_ranking_data
    end
    member do
      get :history
    end
  end
  resources :relations, only: [:index] do
    collection do
      get :map_data
    end
    member do
      get :show
    end
  end
end
