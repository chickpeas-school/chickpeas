# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_12_14_043252) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "announcements", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "children", force: :cascade do |t|
    t.integer "age"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "dob"
    t.string "days"
  end

  create_table "children_parents", id: false, force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "parent_id"
    t.index ["child_id"], name: "index_children_parents_on_child_id"
    t.index ["parent_id"], name: "index_children_parents_on_parent_id"
  end

  create_table "children_years", id: false, force: :cascade do |t|
    t.bigint "child_id"
    t.bigint "year_id"
    t.index ["child_id"], name: "index_children_years_on_child_id"
    t.index ["year_id"], name: "index_children_years_on_year_id"
  end

  create_table "email_configs", force: :cascade do |t|
    t.string "email"
    t.string "genre"
    t.text "description"
    t.boolean "testing"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "mass_messages", force: :cascade do |t|
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "sent"
  end

  create_table "mass_messages_parents", id: false, force: :cascade do |t|
    t.bigint "mass_message_id"
    t.bigint "parent_id"
    t.index ["mass_message_id"], name: "index_mass_messages_parents_on_mass_message_id"
    t.index ["parent_id"], name: "index_mass_messages_parents_on_parent_id"
  end

  create_table "parents", force: :cascade do |t|
    t.string "email"
    t.string "years"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin"
    t.string "name"
    t.string "phone_number"
    t.string "job"
    t.string "address"
  end

  create_table "saleable_days", force: :cascade do |t|
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "buyer_id"
    t.bigint "seller_id"
    t.index ["buyer_id"], name: "index_saleable_days_on_buyer_id"
    t.index ["seller_id"], name: "index_saleable_days_on_seller_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_sessions_on_session_id", unique: true
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "years", force: :cascade do |t|
    t.integer "value"
    t.boolean "current_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
