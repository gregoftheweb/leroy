class ChangePlayerIdInOffersToBeNullable < ActiveRecord::Migration[6.0]
  def change
    change_column_null :offers, :player_id, true
  end
end
