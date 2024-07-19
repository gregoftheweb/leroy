# app/controllers/offers_controller.rb
class OffersController < ApplicationController
  before_action :set_offer, only: %i[show claim]

  def index
    @offers = Offer.all
  end

  def show
  end

  def claim
    if player_signed_in?
      @offer.update(player: current_player, status: "claimed")
      redirect_to offers_path, notice: "Offer claimed successfully."
    else
      redirect_to new_player_session_path, alert: "You need to sign in to claim an offer."
    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end
end
