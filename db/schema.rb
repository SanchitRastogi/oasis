# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[6.1].define(version: 2022_04_18_192512) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "customers", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "mobile_number"
    t.date "date_of_birth"
    t.integer "gender"
    t.string "billing_name"
    t.string "gst_number"
    t.string "address"
    t.integer "state"
    t.string "pincode"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mobile_number"], name: "index_customers_on_mobile_number", unique: true
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "email"
    t.text "password"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "mobile_number"
    t.string "fcm_token"
    t.boolean "is_freezed"
    t.text "auth_token"
    t.jsonb "address"
    t.string "otp_secret_key"
    t.datetime "deleted_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mobile_number"], name: "index_users_on_mobile_number"
  end

end
