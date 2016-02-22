Rails.application.routes.draw do
  root 'application#root'

  scope :api, defaults: {format: 'json'} do
    resources :measurements
    resources :sensors
    resources :sponsors
  end
end
