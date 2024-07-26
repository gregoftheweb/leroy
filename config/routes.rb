Rails.application.routes.draw do
  root to: "home#index"  # Set the root of your application to a different controller and action

  devise_for :players, controllers: { registrations: "players/registrations" }

  resources :players, only: [:edit, :update]

  # Resourceful routes for offers, including custom member route for claiming offers
  resources :offers, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      # add functionality for a player to claim an offer or drop an offer
      patch :claim
      patch :drop
    end
  end
end
