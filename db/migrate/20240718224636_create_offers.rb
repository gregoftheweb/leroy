class CreateOffers < ActiveRecord::Migration[6.0]
  def change
    create_table :offers do |t|
      t.string :title
      t.string :description
      t.decimal :payout, precision: 10, scale: 2
      t.string :status, array: true, default: []
      t.string :age_range, array: true, default: []
      t.references :gender, null: false, foreign_key: true
      t.references :player, foreign_key: { to_table: :players }, null: true

      t.timestamps
    end
  end
end
