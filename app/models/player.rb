class Player < ApplicationRecord
  belongs_to :gender # Remove optional: true to make it required

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validations
  validates :email, presence: true
  validates :password, presence: true
  validates :age, presence: true
  validates :gender, presence: true
end
