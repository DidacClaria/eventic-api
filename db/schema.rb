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

ActiveRecord::Schema.define(version: 2021_04_17_162622) do

  create_table "companies", id: false, force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "name"
    t.string "username"
    t.string "logo"
    t.string "email"
    t.string "language"
    t.string "nif"
    t.text "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_companies_on_email", unique: true
    t.index ["reset_password_token"], name: "index_companies_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_companies_on_uid_and_provider", unique: true
  end

  create_table "event_images", force: :cascade do |t|
    t.integer "evento_id", null: false
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["evento_id"], name: "index_event_images_on_evento_id"
  end

  create_table "event_tags", force: :cascade do |t|
    t.integer "event_id"
    t.integer "tag_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "eventos", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.date "date"
    t.binary "image"
    t.integer "capacity"
    t.string "location"
    t.integer "participants"
    t.integer "price"
    t.string "URL_share"
    t.string "URL_page"
    t.time "start_time"
    t.time "end_time"
    t.string "id_creator"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tags", force: :cascade do |t|
    t.string "tag_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
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
end
