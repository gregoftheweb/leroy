class AddGenderRefToPlayers < ActiveRecord::Migration[7.1]
  def change
    add_reference :players, :gender, foreign_key: true, null: true
  end
end
