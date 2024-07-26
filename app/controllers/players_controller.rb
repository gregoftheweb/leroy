class PlayersController < ApplicationController

  # Devise command to ensure player is authenticated
  before_action :authenticate_player! # Ensure the user is authenticated

  # Edit plyaer
  def edit
    @player = current_player # Assuming you're using Devise and want to edit the current player
  end

  # perform update on the player
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

  # everything below the private directive is a private method unless specified
  private

  def player_params
    params.require(:player).permit(:email, :password, :password_confirmation, :age, :gender_id)
    # Adjust permitted parameters based on your actual model attributes
  end
end
