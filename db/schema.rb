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

ActiveRecord::Schema.define(version: 2021_03_28_043303) do

  create_table "awards", force: :cascade do |t|
    t.integer "efile_id"
    t.string "ein"
    t.string "name"
    t.string "address1"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.float "amount"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["efile_id"], name: "index_awards_on_efile_id"
  end

  create_table "efiles", force: :cascade do |t|
    t.string "ein"
    t.string "name"
    t.string "address1"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.integer "tax_year"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "filers", force: :cascade do |t|
    t.string "ein"
    t.string "name"
    t.string "address1"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "awards", "efiles"
end
