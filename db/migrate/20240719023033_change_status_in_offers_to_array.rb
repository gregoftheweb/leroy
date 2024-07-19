class ChangeStatusInOffersToArray < ActiveRecord::Migration[6.0]
  def change
    change_column :offers, :status, :string, array: true, default: []
  end
end
