Rails.application.routes.draw do
  devise_for :players
  root "home#index"
end
