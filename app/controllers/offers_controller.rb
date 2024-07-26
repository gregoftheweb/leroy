# app/controllers/offers_controller.rb
class OffersController < ApplicationController
  # This line sets up a callback to run the set_offer method before the show and claim actions are executed.
  # It retrieves an Offer record from the database using the id parameter from the request (params[:id]) and assigns it to the instance variable @offer.
  # when a request is made to the claim action, the set_offer method is called to load the specific offer into @offer.
  before_action :set_offer, only: %i[show claim]

  # retrieve the list of offoers
  # Return either the full list or the filtered list depending on the players age and gender
  def index
    @offers = Offer.all

    if params[:filter] == "player"
      if current_player
        @offers = @offers.where(gender: current_player.gender)
        # call the private method to determine if the Player is within the age range for the filter
        @offers = @offers.select { |offer| offer_in_age_range?(offer) }
      end
    end
  end

  def show
  end

  # Player claims an offer
  def claim
    if player_signed_in?
      @offer = Offer.find(params[:id])
      # set player id on offer, change status to claimed
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

  # Player drops offer
  def drop
    if player_signed_in?
      @offer = Offer.find(params[:id])
      # Remove player id from offer, set status to "returned"
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

  # the range is a string like "19-30" we need to split it and then do a compare.
  def offer_in_age_range?(offer)
    offer.age_range.any? { |range| age_in_range?(range) }
  end

  # Here is the actual split/compare logic
  def age_in_range?(range)
    if range == "55 and up"
      current_player.age >= 55
    else
      # split string on "-"
      # maps the two variables min_age, max_age -- AND converts them to integers with the .map(&:to_i)
      min_age, max_age = range.split("-").map(&:to_i)
      # and here's our comparison
      min_age <= current_player.age && current_player.age <= max_age
    end
    # Ruby  implicitely returns the last evaluated expression in a method.
    # thus if we have a true evaluated, return it
  end
end
