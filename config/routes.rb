Rails.application.routes.draw do
  root to: 'comedians#index'

  resources :comedians, only: [:index, :show] do
    member do
      get :analysis
      get :history_data
      get :map_data
    end
  end
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
  resources :futures, only: [:index]
  resources :pasts, only: [:index]
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
