Rails.application.routes.draw do
  root to: "home#index"  # Set the root of your application to a different controller and action

  devise_for :players

  # Resourceful routes for offers, including custom member route for claiming offers
  resources :offers, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    member do
      patch :claim
      patch :drop
    end
  end

  # This assumes you have resources for PlayersController
  resources :players, only: [:edit, :update]
end
