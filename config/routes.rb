Rails.application.routes.draw do
  root 'home#index'

  scope :api, defaults: { format: 'json' } do
    resources :measurements do
      get :aggregated, on: :collection
    end
    resources :sensors
    resources :sponsors
  end
end
