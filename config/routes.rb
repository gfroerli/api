Rails.application.routes.draw do
  root 'home#index'

  scope :api, defaults: { format: 'json' } do
    resources :measurements do
      get :aggregated, on: :collection
    end
    resources :sensors
    resources :sponsors

    namespace :mobile_app do
      resources :sensors, only: [:index, :show] do
        member do
          get :daily_temperatures
          get :hourly_temperatures
          get :sponsor
        end
      end
    end
  end
end
