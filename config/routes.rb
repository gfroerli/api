Rails.application.routes.draw do
  constraints format: :json do
    resources :measurements
    resources :sensors
    resources :sponsors
  end
end
