# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_07_19_051349) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # the genders schema will hold the set of genders a player can select from
  create_table "genders", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  #  offers belong to one player and also have a specific age and gender
  create_table "offers", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.decimal "payout", precision: 10, scale: 2
    t.string "status", default: [], array: true
    t.string "age_range", default: [], array: true
    t.bigint "gender_id", null: false
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["gender_id"], name: "index_offers_on_gender_id"
    t.index ["player_id"], name: "index_offers_on_player_id"
  end

  # Players have an age and gender specific for them.
  create_table "players", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "gender_id", null: false
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["gender_id"], name: "index_players_on_gender_id"
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true
  end

  add_foreign_key "offers", "genders"
  add_foreign_key "offers", "players"
  add_foreign_key "players", "genders"
end
