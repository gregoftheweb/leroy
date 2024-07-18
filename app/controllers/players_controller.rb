class PlayersController < ApplicationController
  before_action :authenticate_player! # Ensure the user is authenticated

  def edit
    @player = current_player # Assuming you're using Devise and want to edit the current player
  end

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

  private

  def player_params
    params.require(:player).permit(:email, :password, :password_confirmation, :age, :gender_id)
    # Adjust permitted parameters based on your actual model attributes
  end
end
