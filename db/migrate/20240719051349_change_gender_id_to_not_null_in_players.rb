class ChangeGenderIdToNotNullInPlayers < ActiveRecord::Migration[6.0]
  def change
    change_column_null :players, :gender_id, false
  end
end
