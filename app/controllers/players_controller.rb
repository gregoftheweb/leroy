class PlayersController < ApplicationController

  # Devise command to ensure player is authenticated
  before_action :authenticate_player! # Ensure the user is authenticated

  # Edit player
  def edit
    @player = current_player # Assuming you're using Devise and want to edit the current player
  end

  # Perform update on the player
  def update
    @player = current_player # Assuming you're updating the current player
    if @player.update(player_params)
      # Handle successful update
      redirect_to root_path, notice: "Profile updated successfully"
    else
      # Handle validation errors or other issues
      render :edit
    end
  end

  # Private methods
  private

  def player_params
    # Allow parameters based on whether they are provided
    params.require(:player).permit(:email, :age, :gender_id, :current_password).tap do |whitelisted|
      whitelisted[:password] = params[:player][:password] if params[:player][:password].present?
      whitelisted[:password_confirmation] = params[:player][:password_confirmation] if params[:player][:password_confirmation].present?
    end
  end
end
