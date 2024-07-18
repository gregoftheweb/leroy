class CreateGenders < ActiveRecord::Migration[7.1]
  def change
    create_table :genders do |t|
      t.string :name

      t.timestamps
    end

    # Insert predefined genders
    genders = ["Male", "Female", "Binary", "Other", "Decline to Say"]
    genders.each do |gender|
      Gender.create(name: gender)
    end
  end
end
