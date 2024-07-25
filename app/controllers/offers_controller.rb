# app/controllers/offers_controller.rb
class OffersController < ApplicationController
  before_action :set_offer, only: %i[show claim]

  def index
    @offers = Offer.all

    if params[:filter] == "player"
      if current_player
        @offers = @offers.where(gender: current_player.gender)
        @offers = @offers.select { |offer| offer_in_age_range?(offer) }
      end
    end
  end

  def show
  end

  def claim
    if player_signed_in?
      @offer = Offer.find(params[:id])
      if @offer.update(player: current_player, status: ["claimed"])
        respond_to do |format|
          format.html { redirect_to offers_path, notice: "Offer was successfully claimed." }
          format.js   # This will look for a file named `claim.js.erb`
        end
      else
        respond_to do |format|
          format.html { redirect_to offers_path, alert: "Failed to claim the offer." }
          format.js { render js: "alert('Failed to claim the offer.');" }
        end
      end
    else
      redirect_to new_player_session_path, alert: "You need to sign in to claim an offer."
    end
  end

  def drop
    if player_signed_in?
      @offer = Offer.find(params[:id])
      if @offer.update(player: nil, status: ["returned"])
        respond_to do |format|
          format.html { redirect_to offers_path, notice: "Offer was successfully dropped." }
          format.js   # This will look for a file named `drop.js.erb`
        end
      else
        respond_to do |format|
          format.html { redirect_to offers_path, alert: "Failed to drop the offer." }
          format.js { render js: "alert('Failed to drop the offer.');" }
        end
      end
    else
      redirect_to new_player_session_path, alert: "You need to sign in to claim an offer."
    end
  end

  private

  def set_offer
    @offer = Offer.find(params[:id])
  end

  def offer_in_age_range?(offer)
    offer.age_range.any? { |range| age_in_range?(range) }
  end

  def age_in_range?(range)
    if range == "55 and up"
      current_player.age >= 55
    else
      min_age, max_age = range.split("-").map(&:to_i)
      min_age <= current_player.age && current_player.age <= max_age
    end
  end
end
