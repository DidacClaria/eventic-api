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

ActiveRecord::Schema.define(version: 2021_04_20_082536) do

  create_table "event_images", force: :cascade do |t|
    t.integer "evento_id", null: false
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["evento_id"], name: "index_event_images_on_evento_id"
  end

  create_table "eventos", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.date "start_date"
    t.date "end_date"
    t.binary "image"
    t.integer "capacity"
    t.integer "latitude"
    t.integer "longitude"
    t.integer "participants"
    t.integer "price"
    t.string "URL_share"
    t.string "URL_page"
    t.time "start_time"
    t.time "end_time"
    t.integer "id_creator"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "followers", id: false, force: :cascade do |t|
    t.integer "company_id"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["company_id"], name: "index_followers_on_company_id"
    t.index ["user_id"], name: "index_followers_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.string "name"
    t.string "username"
    t.string "phone"
    t.string "nif"
    t.string "image"
    t.string "language"
    t.string "location"
    t.string "login_token"
    t.string "role", default: "customer", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login_token"], name: "index_users_on_login_token", unique: true
  end

  add_foreign_key "event_images", "eventos"
  add_foreign_key "followers", "companies"
  add_foreign_key "followers", "users"
end
