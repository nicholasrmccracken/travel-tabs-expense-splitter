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

ActiveRecord::Schema[7.0].define(version: 2024_11_27_225023) do
  create_table "expense_participants", force: :cascade do |t|
    t.integer "expense_id", null: false
    t.integer "user_id", null: false
    t.decimal "share", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["expense_id"], name: "index_expense_participants_on_expense_id"
    t.index ["user_id"], name: "index_expense_participants_on_user_id"
  end

  create_table "expenses", force: :cascade do |t|
    t.string "description"
    t.decimal "amount"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id", null: false
    t.integer "trip_id", null: false
    t.index ["creator_id"], name: "index_expenses_on_creator_id"
    t.index ["trip_id"], name: "index_expenses_on_trip_id"
  end

  create_table "expenses_users", id: false, force: :cascade do |t|
    t.integer "expense_id", null: false
    t.integer "user_id", null: false
    t.index ["expense_id"], name: "index_expenses_users_on_expense_id"
    t.index ["user_id"], name: "index_expenses_users_on_user_id"
  end

  create_table "leaguers", force: :cascade do |t|
    t.integer "trip_id", null: false
    t.integer "user_id", null: false
    t.decimal "amount_owed"
    t.decimal "amount_paid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id"], name: "index_leaguers_on_trip_id"
    t.index ["user_id"], name: "index_leaguers_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.integer "trip_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trip_id", "user_id"], name: "index_participants_on_trip_id_and_user_id", unique: true
    t.index ["trip_id"], name: "index_participants_on_trip_id"
    t.index ["user_id"], name: "index_participants_on_user_id"
  end

  create_table "trips", force: :cascade do |t|
    t.string "name"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "owner_id", null: false
    t.index ["owner_id"], name: "index_trips_on_owner_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "expense_participants", "expenses"
  add_foreign_key "expense_participants", "users"
  add_foreign_key "expenses", "trips"
  add_foreign_key "expenses", "users", column: "creator_id"
  add_foreign_key "leaguers", "trips"
  add_foreign_key "leaguers", "users"
  add_foreign_key "participants", "trips"
  add_foreign_key "participants", "users"
  add_foreign_key "trips", "users", column: "owner_id"
end
