Rails.application.routes.draw do
  get "offers/index"
  get "offers/show"
  devise_for :players

  # Resourceful routes for offers, including custom member route for claiming offers
  resources :offers do
    member do
      patch :claim
    end
  end

  # This assumes you have resources for PlayersController
  resources :players, only: [:edit, :update]

  root "home#index"
end
