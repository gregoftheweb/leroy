class Player < ApplicationRecord
  belongs_to :gender # Remove optional: true to make it required

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :email, presence: true
  validates :age, presence: true
  validates :gender, presence: true

  # Ensure password presence only when it's being updated
  validate :password_present_if_updating

  private

  # Custom validation to check if password is required
  def password_present_if_updating
    if password.present? && password_confirmation.blank?
      errors.add(:password_confirmation, "can't be blank if password is provided")
    end

    if new_record? || password.present?
      if password.blank?
        errors.add(:password, "can't be blank") if password_confirmation.present?
      end
    end
  end
end
