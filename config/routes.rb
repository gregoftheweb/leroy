Rails.application.routes.draw do
  devise_for :players

  # This assumes you have resources for PlayersController
  resources :players, only: [:edit, :update]

  root "home#index"
end
