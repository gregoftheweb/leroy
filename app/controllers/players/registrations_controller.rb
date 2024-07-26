# frozen_string_literal: true

class Players::RegistrationsController < Devise::RegistrationsController
  private

  # Configure parameters for player sign up
  def sign_up_params
    params.require(:player).permit(:email, :new_password, :password_confirmation, :age, :gender_id, :password)
  end

  # Configure parameters for player account updates
  def account_update_params
    params.require(:player).permit(:email, :new_password, :password_confirmation, :age, :gender_id, :password, :current_password)
  end
end
