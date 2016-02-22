Rails.application.routes.draw do
  root 'home#index'

  scope :api, defaults: {format: 'json'} do
    resources :measurements
    resources :sensors
    resources :sponsors
  end
end
