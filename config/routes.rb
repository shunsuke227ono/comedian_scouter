Rails.application.routes.draw do
  root to: 'top#show'

  resources :comedians, only: [:index, :show]
  resources :popularities, only: [:index] do
    collection do
      get :appear_ranking_data
      get :search
    end
    member do
      get :history
      get :history_data
    end
  end
  resources :relations, only: [:index] do
    collection do
      get :map_data
      get :search
    end
    member do
      get :show
    end
  end
end
