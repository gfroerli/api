Rails.application.routes.draw do
  root 'home#index'

  scope :api, defaults: { format: 'json' } do
    resources :measurements do
      get :aggregated, on: :collection
    end
    resources :sensors
    resources :sponsors

    namespace :ios_app do
      resources :sensors, only: [:index, :show] do
        member do
          get :aggregated_temperatures
        end
      end
    end
  end
end
